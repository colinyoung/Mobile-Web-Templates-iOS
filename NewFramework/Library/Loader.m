#import "Loader.h"

@implementation Loader
@synthesize route = _route;

-(id)initWithRoute:(NSString *)route {
    self = [super init];
    if (self) {
        self.route = route;
    }
    return self;
}

-(void)load {
    [[NetworkUtility getInstance] setDelegate:[[RemoteNetworkUtility alloc] initWithAcceptsHeader:RemoteNetworkUtilityAcceptsJSON]];
}

@end
