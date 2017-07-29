//
//  WebViewViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 22/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

-(void)setUpNavigationItem
{
    [self setNavigationBarBackButton];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    self.ActivityIndicator.hidden=NO;
    self.ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view bringSubviewToFront:self.ActivityIndicator];
    [self.webview loadRequest:[NSURLRequest requestWithURL:_url]];
    [self.ActivityIndicator startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.ActivityIndicator stopAnimating];
    self.ActivityIndicator.hidden=YES;
}
 -(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.ActivityIndicator stopAnimating];
    self.ActivityIndicator.hidden=YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webVie
{
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
