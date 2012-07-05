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
    return [response jsonObject];
}

@end
