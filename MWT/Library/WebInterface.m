#import "WebInterface.h"

@implementation WebInterface

@synthesize html = _html;
@synthesize css = _css;
@synthesize js = _js;

-(id)initWithObject:(id)jsonObject {
    self = [super init];
    if (self) {
        self.html   = [[jsonObject objectForKey:@"html"] copy];
        self.css    = [[jsonObject objectForKey:@"css"] copy];
        self.js     = [[jsonObject objectForKey:@"js"] copy];
    }
    return self;
}

+(id)interfaceWithObject:(id)jsonObject {
    return [[self alloc] initWithObject:jsonObject];
}

@end
