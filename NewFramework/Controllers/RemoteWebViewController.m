#import "RemoteWebViewController.h"
#import "GRMustache.h"

@implementation RemoteWebViewController

@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    CGRect frame = self.view.frame;
    frame = CGRectMake(0, -20, frame.size.width, frame.size.height);
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [self.view addSubview:_webView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self dumpHTML];
    
    [self.webView stringByEvaluatingJavaScriptFromString:[[self class] bootString]];
    
    [self dumpHTML];
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
+(NSString *) bootString {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *js = @""
    "document.write('<html><head></head><body><p>Hello world.</p></body></html>');"
    "var head = document.getElementsByTagName('head').item(0);"
    "var newScript = document.createElement('script');"
    "newScript.type = 'text/javascript';"
    "newScript.src = '{{baseURL}}/boot.js';"
    "head.appendChild(newScript);";
    
    NSString *script = [GRMustacheTemplate renderObject:[NSDictionary dictionaryWithObject:[baseURL path] forKey:@"baseURL"]
                                 fromString:js
                                                  error:NULL];
    
    NSLog(@"script: %@", script);
    
    return script;
}

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

@end
