//
//  MyProfileViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 15/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MyProfileViewController : BaseViewController

//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *fName_View;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UIView *lName_View;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UIView *mobile_View;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;

@property (weak, nonatomic) IBOutlet UIView *telephone_View;
@property (weak, nonatomic) IBOutlet UITextField *txtTelephoneNumber;

@property (weak, nonatomic) IBOutlet UIView *email_View;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (strong, nonatomic) IBOutlet UIView *bname_View;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingName;

@property (weak, nonatomic) IBOutlet UIView *baddress_View;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingAddress;

@property (weak, nonatomic) IBOutlet UIView *bcity_View;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;

@property (weak, nonatomic) IBOutlet UIView *bcountry_View;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;

@property (weak, nonatomic) IBOutlet UIView *bstate_View;
@property (weak, nonatomic) IBOutlet UITextField *txtState;

@property (weak, nonatomic) IBOutlet UIView *bzip_View;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;

@property (weak, nonatomic) IBOutlet UIView *btelephone_View;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingTelephoneNumber;

@property (weak, nonatomic) IBOutlet UIView *userName_View;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (weak, nonatomic) IBOutlet UIView *password_View;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIView *nikname_View;
@property (weak, nonatomic) IBOutlet UITextField *txtNickName;

@end
