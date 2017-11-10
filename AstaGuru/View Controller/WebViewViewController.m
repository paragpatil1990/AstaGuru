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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ActivityIndicator.hidden=NO;
    _ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view bringSubviewToFront:_ActivityIndicator];
    [_webview loadRequest:[NSURLRequest requestWithURL:_url]];
    [_ActivityIndicator startAnimating];
}
-(void)viewDidAppear:(BOOL)animated
{
    /* self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];*/
    self.navigationController.navigationBar.backItem.title = @"Back";
     self.title=[NSString stringWithFormat:@"AstaGuru"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_ActivityIndicator stopAnimating];
    _ActivityIndicator.hidden=YES;
}
 -(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_ActivityIndicator stopAnimating];
    _ActivityIndicator.hidden=YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webVie
{
//    [_ActivityIndicator stopAnimating];
//    _ActivityIndicator.hidden=YES;
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
