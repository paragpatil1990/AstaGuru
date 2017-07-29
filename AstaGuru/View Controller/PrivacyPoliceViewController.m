//
//  PrivacyPoliceViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "PrivacyPoliceViewController.h"
//#import "SWRevealViewController.h"
//#import "AppDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
@interface PrivacyPoliceViewController ()<MFMailComposeViewControllerDelegate,UITextViewDelegate>

@end

@implementation PrivacyPoliceViewController

-(void)setUpNavigationItem
{
    self.title=@"Privacy Policy";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    
    self.txtViewPrivacyPolice.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.txtViewPrivacyPolice setTintColor:[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1]];
    self.txtViewPrivacyPolice.editable = NO;
    self.txtViewPrivacyPolice.selectable = true;
    self.txtViewPrivacyPolice.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
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
