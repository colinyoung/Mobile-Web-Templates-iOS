#import "WebController.h"
#import "GRMustache.h"

@implementation WebController

@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Loading...";
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
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dumpHTML) userInfo:nil repeats:NO];
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

#pragma mark - JS methods

-(NSString *) dumpHTML {
    NSMutableString *template = [NSMutableString stringWithString:@"<!doctype html>\n<html>\n"];
    [template appendString:@"<head>\n"];
    [template appendFormat:@"%@\n", [self.webView stringByEvaluatingJavaScriptFromString:@"document.head.innerHTML"]];
    [template appendString:@"</head>\n"];
    
    [template appendString:@"<body>\n"];
    [template appendFormat:@"%@\n", [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]];
    [template appendString:@"</body>"];
    
    NSLog(@"HTML: \n%@", template);
    
    return template;
}

#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"webView:shouldStartLoad:navType");
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"Loading %@", requestString);
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"ios-callback:"]) {
        
        requestString = [requestString stringByReplacingOccurrencesOfString:@"ios-callback:" withString:@"ios-callback://"];
        NSURL *fixedURL = [NSURL URLWithString:requestString];
        
        // Extract the selector name from the URL
        NSString *function = [NSString stringWithFormat:@"%@:", [fixedURL host]];
        
        // Extract query parameters
        NSDictionary *queryParameters = [fixedURL queryDictionary];
        
        [self performSelector:NSSelectorFromString(function) withObject:queryParameters];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
}

#pragma mark - Selectors for javascript
- (void)test:(NSDictionary *)options {
    NSString *message = @"";
    if ([options count]) {
        message = [GRMustacheTemplate renderObject:options fromString:@"Message was: {{say}}" error:NULL];
    }
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"JSTest" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (void)showImage:(NSDictionary *)options {
    [self.webView inject:[NSString stringWithFormat:@"<p><img src=\"%@\" /></p>", [options objectForKey:@"url"]]];
}

- (void)showTableView:(NSDictionary *)options {
    [self.webView inject:@"<div class=\"tableview\">"
     "<ul>"
     "<li><p>Dr. Jekyll</p></li>"
     "<li><p>Mr. Hyde</p></li>"     
     "<li><p>The Pagemaster</p></li>"
     "<li><p><a href=\"ios-callback:test?say=Maculay%20Culkin%20is%20scary\">Maculay Culkin</a></p></li>"
     "<li><p>The Drippy Ceiling</p></li>"
     "</ul>"
     "</div>"];
}

@end