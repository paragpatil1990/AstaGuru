//
//  RegistrationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 09/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface RegistrationViewController : BaseViewController

//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UIView *fName_View;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UIView *lName_View;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UIView *address_View;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;

@property (weak, nonatomic) IBOutlet UIView *city_View;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;

@property (weak, nonatomic) IBOutlet UIView *country_View;
@property (strong, nonatomic) IBOutlet UITextField *txtcountry;

@property (weak, nonatomic) IBOutlet UIView *state_View;
@property (weak, nonatomic) IBOutlet UITextField *txtState;

@property (weak, nonatomic) IBOutlet UIView *zip_View;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;

@property (weak, nonatomic) IBOutlet UIView *mobile_View;
@property (strong, nonatomic) IBOutlet UITextField *txtCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;

@property (weak, nonatomic) IBOutlet UIView *telephone_View;
@property (weak, nonatomic) IBOutlet UITextField *txtTelephoneNumber;

@property (weak, nonatomic) IBOutlet UIView *fax_View;
@property (weak, nonatomic) IBOutlet UITextField *txtFaxNumber;

@property (weak, nonatomic) IBOutlet UIView *email_View;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIView *userName_View;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (weak, nonatomic) IBOutlet UIView *password_View;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIView *confirmPassword_View;
@property (weak, nonatomic) IBOutlet UITextField *txtConfarmPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnTandC;

@property (weak, nonatomic) IBOutlet UIImageView *imgCheckTermsAndCondition;

@property (strong, nonatomic) IBOutlet UIButton *btnProceed;

- (IBAction)btnAgreePressed:(id)sender;
//- (IBAction)btnTermsAndCondition:(id)sender;

@end
