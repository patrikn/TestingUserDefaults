#import "TestingUserDefaults.h"

@interface TestingUserDefaults ()
@property(retain) NSMutableDictionary *data;
@end

static NSString *tempDir;

@implementation TestingUserDefaults
@synthesize data;

+ (NSString *)dataFile
{
    NSString *filePath = [tempDir stringByAppendingPathComponent:@"defaults"];
    
    return filePath;
}

+ (id) freshDefaults
{
    tempDir = NSTemporaryDirectory();
    NSString *dataFile = [TestingUserDefaults dataFile];
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dataFile]) {
        [fileManager removeItemAtPath:dataFile error:&error];
        if (error != nil) {
            @throw error;
        }
    }
    return [TestingUserDefaults loadDefaults];
}

+ (id)loadDefaults
{
    TestingUserDefaults *defaults = [[[self alloc] init] autorelease];
    NSMutableDictionary *savedDefaults = [NSMutableDictionary dictionaryWithContentsOfFile:[TestingUserDefaults dataFile]];
    [defaults.data addEntriesFromDictionary:savedDefaults];
    return defaults;
}

- (id) init
{
    [super init];
    self.data = [NSMutableDictionary dictionary];
    
    return self;
}

- (void) dealloc
{
    self.data = nil;
    [super dealloc];
}

#pragma mark Writing

- (void) setObject: (id) value forKey: (NSString*) defaultName
{
    [data setObject:value forKey:defaultName];
}

- (void) setInteger: (NSInteger) value forKey: (NSString*) defaultName
{
    [data setObject:[NSNumber numberWithInteger:value] forKey:defaultName];
}

- (void) setBool: (BOOL) value forKey: (NSString*) defaultName
{
    [data setObject:[NSNumber numberWithBool:value] forKey:defaultName];
}

- (void) removeObjectForKey: (NSString*) defaultName
{
    [data removeObjectForKey:defaultName];
}

- (void) synchronize {
    NSString *dataFile = [TestingUserDefaults dataFile];
    
    [data writeToFile:dataFile atomically:TRUE];
}

#pragma mark Reading

- (id) objectForKey: (NSString*) defaultName
{
    return [data objectForKey:defaultName];
}

- (NSArray *)arrayForKey:(NSString *)defaultName
{
    return [NSArray arrayWithArray:[data objectForKey:defaultName]];
}

- (NSInteger) integerForKey: (NSString*) defaultName
{
    return [[data objectForKey:defaultName] integerValue];
}

- (BOOL) boolForKey: (NSString*) defaultName
{
    return [[data objectForKey:defaultName] boolValue];
}

- (NSDictionary *) dictionaryForKey:(NSString *)defaultName
{
    NSDictionary *dict = [data objectForKey:defaultName];
    
    return dict != nil ? [NSDictionary dictionaryWithDictionary:dict] : nil;
}
@end
