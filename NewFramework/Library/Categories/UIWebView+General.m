//  Created by Colin Young on 6/19/12.
#import "UIWebView+General.h"

@interface NSString (JavascriptBridge)

-(NSString *)call:(SEL)method;
-(NSString *)apply:(SEL)method arguments:(NSArray*)arguments;
-(NSString *)arrayAsString:(NSArray *)array;

@end

@implementation NSString (JavascriptBridge)

-(NSString *)call:(SEL)method {
    return [self stringByAppendingString:[NSStringFromSelector(method) stringByAppendingString:@".call($f);"]];
}

-(NSString *)apply:(SEL)method arguments:(NSArray *)arguments {
    return [self stringByAppendingString:[NSStringFromSelector(method) stringByAppendingFormat:@".apply($f, %@)",
                                          [self arrayAsString:arguments]]];
}

-(NSString *)arrayAsString:(NSArray *)array {
    NSMutableString *str = [NSMutableString string];
    
    // Open the array
    [str appendString:@"["];
    
    int ct = [array count];
    int i = 0;
    
    for (id value in array) {
        i++;
        
        if ([value isKindOfClass:[NSNumber class]]) {
            [str appendString:[value stringValue]];
        } else if ([value isKindOfClass:[NSString class]]) {
            [str appendString:[NSString stringWithFormat:@"'%@'", value]];
        } else if ([NSJSONSerialization isValidJSONObject:value]) {
            NSError *error = nil;
            NSData *JSON = [NSJSONSerialization dataWithJSONObject:value options:0 error:&error];
            if (!error) [str appendString:[[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding]];
        }
        
        if (i < ct) {
            [str appendString:@","];
        }
    }
    
    // Close the array
    [str appendString:@"]"];
    
    NSLog(@"%@", str);
    return str;
}

@end

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

- (BOOL)replaceHTMLElements:(NSDictionary *)dictionary {
    
    for (NSString *selector in dictionary) {
        // Empty old element
//        [self perform:[[self select:selector] call:@selector(empty)]];
        
        // Append new HTML
        [self perform:[[self select:selector] apply:@selector(append)
                                          arguments:[dictionary objectForKey:selector]]];
    }
    
    return NO; // @todo
}

- (BOOL)replaceHTMLElementsWithString:(NSString *)HTML {
    [self perform:[[self javascriptObject:@"$f"] apply:@selector(extractTemplatingElements) arguments:[NSArray arrayWithObject:HTML]]];
    
    return YES; // @todo    
}

- (BOOL)updateData:(id)jsonData {
    return NO; // @todo
}

- (NSString *)select:(NSString *)selector {
    return [NSString stringWithFormat:@"$('%@')", selector];
}
                   
#pragma mark - JS Bridge
- (void)perform:(NSString *)string {
    NSLog(@"js > %@", string);
    [self stringByEvaluatingJavaScriptFromString:string];
}

- (NSString *) javascriptObject:(NSString *)objectName {
    return [objectName stringByAppendingString:@"."];
}

@end
