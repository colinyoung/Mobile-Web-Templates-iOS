#import <Foundation/Foundation.h>

@interface Loader : NSObject {
    NSString *_route;
}

@property (nonatomic, retain) NSString *route;

-(id)initWithRoute:(NSString*)route;

@end
