#import "WebController.h"
#import "GRMustache.h"
#import "AppDelegate.h"

@implementation WebController

@synthesize webView = _webView;
@synthesize route = _route;
@synthesize baseURL = _baseURL;
@synthesize loader = _loader;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Loading...";
        status = WebControllerStatusEmpty;
    }
    return self;
}

- (id)initWithRoute:(NSString *)route {
    NSDictionary *config = [AppDelegate loadConfigForObject];
    return [self initWithBaseURL:[config objectForKey:@"baseURL"] route:route];
}

- (id)initWithBaseURL:(NSString *)baseURL route:(NSString *)route {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Loading...";
        self.baseURL = baseURL;
        self.route = route;
        self.loader = [[Loader alloc] initWithRoute:[baseURL stringByAppendingString:route]];
        status = WebControllerStatusEmpty;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create and display webview
    CGRect frame = self.view.frame;
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height-self.navigationController.navigationBar.frame.size.height);
    self.webView = [[UIWebView alloc] initWithFrame:frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:bootString_debug() baseURL:baseURL];
}

- (void)documentReady:(NSDictionary *)params {
    [self load:nil]; // @todo load with params that were set to load this view
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"webView:shouldStartLoad:navType");
    NSString *prefix = [[AppDelegate loadConfigForObject] objectForKey:@"prefix"];
    NSString *prefixWithColon = [prefix stringByAppendingString:@":"];
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"Loading %@", requestString);
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:prefix]) {
        
        requestString = [requestString stringByReplacingOccurrencesOfString:prefixWithColon withString:[prefix stringByAppendingString:@"://"]];
        NSURL *fixedURL = [NSURL URLWithString:requestString];
        NSLog(@"%@", fixedURL);
        
        // Extract the selector name from the URL
        NSString *function = [NSString stringWithFormat:@"%@:", [fixedURL host]];
        
        // Extract query parameters
        NSDictionary *queryParameters = [fixedURL queryDictionary];
        
        SEL method = NSSelectorFromString(function);
        NSLog(@"%@", function);
        if (![self respondsToSelector:method]) return NO;
        
        [self performSelector:method withObject:queryParameters];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
}

-(void)load:(NSDictionary *)params {
    [self loadUI:params];
    [self loadData:params];
    
    self.title = @"";
}

-(void)loadData:(NSDictionary *)params {
    id JSON = [[self.loader loadJSON] objectForKey:kWebController_JSONDataKey];
    [self.webView updateData:JSON];
    
    status = WebControllerStatusUpdated;
}

-(void)loadUI:(NSDictionary *)params {
    WebInterface *interface = [self.loader loadUI];
    [self.webView applyInterface:interface];
    
    status = WebControllerStatusLoaded;
}

@end