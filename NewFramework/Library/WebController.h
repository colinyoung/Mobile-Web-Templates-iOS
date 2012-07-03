#import <UIKit/UIKit.h>

@interface WebController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
}

@property (nonatomic, retain) UIWebView *webView;

-(NSString *) dumpHTML;

@end
