#import "FriendsController.h"

@implementation FriendsController

-(void)loadView {
    [super loadView];
    
    self.title = @"Friends";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Load Data"
                                                                              style:UIBarButtonItemStyleBordered
                                                                                           target:self
                                                                                           action:@selector(loadData:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Load UI"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(loadUI:)];    
}

@end
