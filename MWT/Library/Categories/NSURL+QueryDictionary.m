//  Created by Colin Young on 6/18/12.
#import "NSURL+QueryDictionary.h"

@implementation NSURL (QueryDictionary)

/* Rip of http://forums.macrumors.com/showthread.php?t=996004 */
- (NSDictionary *) queryDictionary {
    NSArray *parameters = [[self query] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
    NSMutableDictionary *kv = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < [parameters count]; i=i+2) {
        [kv setObject:[[parameters objectAtIndex:i+1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[parameters objectAtIndex:i]];
    }
    
    return [NSDictionary dictionaryWithDictionary:kv];
}

@end
