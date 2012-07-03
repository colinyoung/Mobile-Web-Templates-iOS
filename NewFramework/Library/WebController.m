#import "WebController.h"
#import "GRMustache.h"
#import "AppDelegate.h"

@implementation WebController

@synthesize webView = _webView;
@synthesize route = _route;
@synthesize baseURL = _baseURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Loading...";
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
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
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
    [self.webView loadHTMLString:bootString() baseURL:baseURL];
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
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"Loading %@", requestString);
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:prefix]) {
        
        requestString = [requestString stringByReplacingOccurrencesOfString:prefix withString:[@"://" stringByAppendingString:prefix]];
        NSURL *fixedURL = [NSURL URLWithString:requestString];
        
        // Extract the selector name from the URL
        NSString *function = [NSString stringWithFormat:@"%@:", [fixedURL host]];
        
        // Extract query parameters
        NSDictionary *queryParameters = [fixedURL queryDictionary];
        
        SEL method = NSSelectorFromString(function);
        if (![self respondsToSelector:method]) return NO;
        
        [self performSelector:method withObject:queryParameters];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
}

@end