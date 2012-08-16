#include "Functions.h"

AppDelegate * appDelegate() {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

NSString * bootString_debug() {
    return @""
    "<html>"
    "<head>"
    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    
    "<link rel=\"stylesheet\" href=\"bootstrap.min.css\" />"
    "<link rel=\"stylesheet\" href=\"bootstrap-responsive.min.css\" />"
    "<link rel=\"stylesheet\" href=\"framework.css\" />"
    "<link rel=\"stylesheet\" href=\"theme-ios.css\" />"
    
    "<script src=\"jquery-1.7.2.min.js\"></script>"
    "<script src=\"jgestures.min.js\"></script>"
    "<script src=\"mustache.js\"></script>"
    "<script src=\"underscore-min.js\"></script>"
    "<script src=\"mobile_framework.js\"></script>"
    "<script src=\"boot.js\"></script>"
    "</head>"
    "<body>"
    "</body>"
    "</html>";
}

NSString * bootString() {
    return @""
    "<html>"
    "<head>"
    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    
        "<link rel=\"stylesheet\" href=\"compiled.css\" />"
        "<script src=\"compiled.js\"></script>"
    
    "</head>"
    "<body>"
    "</body>"
    "</html>";
}

BOOL isEmptyString(NSString *str) {
    return (str == nil || !str || str.length == 0 || [[str stringByTrimmingCharactersInSet:
                                                        [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]);
}