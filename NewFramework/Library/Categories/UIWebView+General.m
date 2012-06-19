//  Created by Colin Young on 6/19/12.
#import "UIWebView+General.h"

@implementation UIWebView (General)

- (void) inject:(NSString *)HTML {
    [self inject:HTML intoElement:@"body"];
}
- (void) inject:(NSString *)HTML intoElement:(NSString *)element {
    HTML = [HTML stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"jQuery(\"%@\").append(\"%@\");", element, HTML]];
}

@end
