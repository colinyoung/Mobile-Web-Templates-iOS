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

@end
