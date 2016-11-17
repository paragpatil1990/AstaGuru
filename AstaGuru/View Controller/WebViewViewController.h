//
//  WebViewViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 22/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,retain)NSURL *url;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;

@end
