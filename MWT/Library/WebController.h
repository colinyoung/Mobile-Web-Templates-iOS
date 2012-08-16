#import <UIKit/UIKit.h>
#import "Loader.h"

@class WebInterface;

#define kWebController_JSONDataKey @"resources"

typedef enum {
    WebControllerStatusEmpty = 0,
    WebControllerStatusLoading,
    WebControllerStatusError,
    WebControllerStatusLoaded,
    WebControllerStatusUpdated
} WebControllerStatus;

@interface WebController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_route, *_baseURL;
    Loader *_loader;
    WebControllerStatus status;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *route;
@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) Loader *loader;

- (id)initWithRoute:(NSString *)route;
- (id)initWithBaseURL:(NSString*)baseURL route:(NSString *)route;

- (void)documentReady:(NSDictionary *)params; /* Called by javascript to inform the controller that the document is ready. */

-(void)load:(NSDictionary *)params; /* Loads whatever is needed to render a view (recommended). */

-(void)loadData:(NSDictionary *)params; /* Loads just the data - usually. If there's no HTML, it'll call -(void)load instead. */
-(void)loadUI:(NSDictionary *)params; /* Loads just the HTML. */

@end
