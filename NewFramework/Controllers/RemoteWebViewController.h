//
//  RemoteWebViewController.h
//  NewFramework
//
//  Created by Colin Young on 6/12/12.
//  Copyright (c) 2012 Cloudbot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoteWebViewController : UIViewController {
    UIWebView *_webView;
}

@property (nonatomic, retain) UIWebView *webView;

@end
