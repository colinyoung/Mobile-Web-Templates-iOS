#import "Loader.h"

@implementation Loader
@synthesize route = _route;

-(id)initWithRoute:(NSString *)route {
    self = [super init];
    if (self) {
        self.route = route;
        
        [[NetworkUtility getInstance] setDelegate:[[RemoteNetworkUtility alloc] initWithAcceptsHeader:RemoteNetworkUtilityAcceptsJSON]];
    }
    return self;
}

-(id)loadJSON {
    NSError *error = nil;
    ResponseData *response = [[NetworkUtility getInstance] get:self.route
                                            withParameters:nil
                                              authenticate:NO
                                                     error:error];
    if (error || [response data] == nil) {
        [self showError:error];
        return nil;
    }
    return [response jsonObject];
}

-(NSString *)loadHTML {
    id JSON = [self loadJSON];
    if (!JSON || ![JSON respondsToSelector:@selector(objectForKey:)]) {
        return nil;
    }
    
    return [JSON objectForKey:@"html"];
}

-(void)showError:(NSError *)error {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, there was an error loading the data." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    [av show];
}

@end
