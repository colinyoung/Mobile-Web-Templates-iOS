#import <Foundation/Foundation.h>

@class WebInterface;

@interface Loader : NSObject {
    NSString *_route;
}

@property (nonatomic, retain) NSString *route;

-(id)initWithRoute:(NSString*)route;
-(id)loadJSON;
-(WebInterface *)loadUI;

-(void)showError:(NSError *)error;

@end
