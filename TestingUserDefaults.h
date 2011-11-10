@interface TestingUserDefaults : NSObject {}

+ (id) freshDefaults;
+ (id) loadDefaults;

- (void) setObject: (id) value forKey: (NSString*) defaultName;
- (void) setInteger: (NSInteger) value forKey: (NSString*) defaultName;
- (void) setBool: (BOOL) value forKey: (NSString*) defaultName;

- (id) objectForKey: (NSString*) defaultName;
- (NSArray *) arrayForKey: (NSString *)defaultName;
- (NSInteger) integerForKey: (NSString*) defaultName;
- (BOOL) boolForKey: (NSString*) defaultName;
- (NSDictionary*) dictionaryForKey: (NSString*) defaultName;

- (void) synchronize;

@end
