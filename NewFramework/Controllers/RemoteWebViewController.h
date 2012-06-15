//
//  RemoteWebViewController.h
//  NewFramework
//
//  Created by Colin Young on 6/12/12.
//  Copyright (c) 2012 Cloudbot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoteWebViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
}

@property (nonatomic, retain) UIWebView *webView;

+(NSString *) bootString;
-(NSString *) dumpHTML;

@end
