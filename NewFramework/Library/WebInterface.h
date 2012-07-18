#import <Foundation/Foundation.h>

@interface WebInterface : NSObject {
    NSString *_html;
    NSString *_js;
    NSString *_css;
}

@property (nonatomic, retain) NSString *html;
@property (nonatomic, retain) NSString *js;
@property (nonatomic, retain) NSString *css;

-(id)initWithObject:(id)jsonObject;
+(id)interfaceWithObject:(id)jsonObject;

@end
