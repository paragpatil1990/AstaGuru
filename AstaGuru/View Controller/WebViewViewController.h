//
//  WebViewViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 22/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface WebViewViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;
@property(nonatomic,retain)NSURL *url;

@end
