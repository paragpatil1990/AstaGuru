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
    
    [self setNavigationBarBackButton];

}
-(void)viewDidAppear:(BOOL)animated
{
    /* self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];*/
   // self.navigationController.navigationBar.backItem.title = @"Back";
    
     self.title=[NSString stringWithFormat:@"AstaGuru"];
}
-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
  //  [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
//    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
 //   [_backButton setTitle:@"Back" forState:UIControlStateNormal];
   // [[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
  //  [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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
