//  Created by Colin Young on 6/18/12.
#import <Foundation/Foundation.h>

@interface NSObject (ObjectConfig)

+(id)loadConfigFromFile:(NSString *)path;
+(id)loadConfigForObject;

@end
