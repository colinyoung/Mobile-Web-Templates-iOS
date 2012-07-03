//  Created by Colin Young on 6/19/12.
#import <UIKit/UIKit.h>

@interface UIWebView (General)

- (void) inject:(NSString *)HTML;
- (void) inject:(NSString *)HTML intoElement:(NSString *)element;
- (NSString *) HTML;

@end
