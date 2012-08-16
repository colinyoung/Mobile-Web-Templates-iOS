#import "UIWebView+Interface.h"

@implementation UIWebView (Interface)

-(void)applyInterface:(WebInterface*)interface {
    [self replaceHTMLElementsWithString:[interface html]];
    [self replacePageCSSWithString:[interface css]];
    [self replacePageJSWithString:[interface js]];
}

@end
