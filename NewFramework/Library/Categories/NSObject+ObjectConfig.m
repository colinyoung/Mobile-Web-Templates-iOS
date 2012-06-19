//  Created by Colin Young on 6/18/12.
#import "NSObject+ObjectConfig.h"

@implementation NSObject (ObjectConfig)

+(id)loadConfigFromFile:(NSString *)path {
    NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:path];
    if (!config) return nil;
    
    return config;
}

+(id)loadConfigForObject {
    NSString *fileName = [NSString stringWithFormat:@"Config-%@", NSStringFromClass(self)];
    NSString *fullName = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    return [self loadConfigFromFile:fullName];
}

@end
