#import <Foundation/Foundation.h>

@interface Loader : NSObject {
    NSString *_route;
}

@property (nonatomic, retain) NSString *route;

-(id)initWithRoute:(NSString*)route;
-(id)loadJSON;
-(NSString *)loadUI;

-(void)showError:(NSError *)error;

@end
