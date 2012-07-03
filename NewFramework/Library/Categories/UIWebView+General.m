//  Created by Colin Young on 6/19/12.
#import "UIWebView+General.h"

@implementation UIWebView (General)

- (void) inject:(NSString *)HTML {
    [self inject:HTML intoElement:@"body"];
}
- (void) inject:(NSString *)HTML intoElement:(NSString *)element {
    HTML = [HTML stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"jQuery(\"%@\").append(\"%@\");", element, HTML]];
}
- (NSString *) HTML {
    NSMutableString *template = [NSMutableString stringWithString:@"<!doctype html>\n<html>\n"];
    [template appendString:@"<head>\n"];
    [template appendFormat:@"%@\n", [self stringByEvaluatingJavaScriptFromString:@"document.head.innerHTML"]];
    [template appendString:@"</head>\n"];
    
    [template appendString:@"<body>\n"];
    [template appendFormat:@"%@\n", [self stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]];
    [template appendString:@"</body>"];
    
    NSLog(@"HTML: \n%@", template);
    
    return template;  
}

@end
