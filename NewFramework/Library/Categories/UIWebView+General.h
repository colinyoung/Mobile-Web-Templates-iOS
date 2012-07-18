//  Created by Colin Young on 6/19/12.
#import <UIKit/UIKit.h>

@interface UIWebView (General)

- (void) inject:(NSString *)HTML;
- (void) inject:(NSString *)HTML intoElement:(NSString *)element;

/* For chaining of JS */
- (NSString *) select:(NSString *)selector;
- (NSString *) javascriptObject:(NSString *)objectName;
- (NSString *) perform:(NSString *)string;

- (NSString *) HTML;

/* Replaces HTML elements with selectors from a compiled HTML string.
 
 E.g., the string you pass here should have ALL available HTML in it, even if it's cached separately.*/
- (BOOL)replaceHTMLElementsWithString:(NSString *)HTML;

/* Replaces HTML elements with elements with selector keys. Keys should be jQuery/CSS selectors. */
- (BOOL)replaceHTMLElements:(NSDictionary*)dictionary;

/* Replaces Script elements for this local page; does NOT remove global scripts like jQuery. */
- (BOOL)replacePageJSWithString:(NSString*)js;

/* Replaces CSS elements for this local page; does NOT remove global css included thru <link>s. */
- (BOOL)replacePageCSSWithString:(NSString*)css;

/* Updates HTML elements matching selectors with the data array value, ending with correct quantity of that class repeated. */
- (BOOL)updateData:(id)jsonData;

@end
