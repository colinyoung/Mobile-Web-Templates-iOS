#import "RootViewController.h"
#import "RemoteWebViewController.h"

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Loading...";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RemoteWebViewController *remoteWebVC = [[RemoteWebViewController alloc] initWithNibName:nil bundle:nil];
    
    [remoteWebVC viewWillAppear:NO];
    [self.view addSubview:remoteWebVC.view];
    [remoteWebVC viewDidAppear:NO];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
