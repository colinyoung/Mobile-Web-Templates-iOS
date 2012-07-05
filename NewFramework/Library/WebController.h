#import <UIKit/UIKit.h>

@interface WebController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_route, *_baseURL;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *route;
@property (nonatomic, retain) NSString *baseURL;

- (id)initWithRoute:(NSString *)route;
- (id)initWithBaseURL:(NSString*)baseURL route:(NSString *)route;

@end
