//
//  LoginViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 07/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftbarButton;

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *userName_View;
@property (weak, nonatomic) IBOutlet UIView *password_View;

- (IBAction)ForgotPasswordpressed:(id)sender;
- (IBAction)SugnUpPressed:(id)sender;
- (IBAction)btnSignInPressed:(id)sender;

@end
