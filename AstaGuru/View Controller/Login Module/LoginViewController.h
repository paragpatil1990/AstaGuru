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
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtUserName;
- (IBAction)ForgotPasswordpressed:(id)sender;
- (IBAction)SugnUpPressed:(id)sender;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtPassword;
- (IBAction)btnSignInPressed:(id)sender;

@end
