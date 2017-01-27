//
//  LoginViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 07/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClsSetting.h"
@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (weak, nonatomic) IBOutlet CustomTextfied *txtUserName;
- (IBAction)ForgotPasswordpressed:(id)sender;
- (IBAction)SugnUpPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
//@property (weak, nonatomic) IBOutlet CustomTextfied *txtPassword;
- (IBAction)btnSignInPressed:(id)sender;
@property(nonatomic)int IsCommingFromSideMenu;

@property (weak, nonatomic) IBOutlet UIView *userName_View;

@property (weak, nonatomic) IBOutlet UIView *password_View;

@end
