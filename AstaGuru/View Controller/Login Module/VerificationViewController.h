//
//  VerificationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VerificationViewController : BaseViewController
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;

@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UIButton *btnSMSResend;
@property (weak, nonatomic) IBOutlet UIView *viewSMSContent;
@property (weak, nonatomic) IBOutlet UITextField *smsOne;
@property (weak, nonatomic) IBOutlet UITextField *smsTwo;
@property (weak, nonatomic) IBOutlet UITextField *smsThree;
@property (weak, nonatomic) IBOutlet UITextField *smsFour;
@property (strong, nonatomic) IBOutlet UIButton *btnMobileVerify;
@property (strong, nonatomic) IBOutlet UILabel *lblsmserror;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailResend;
@property (weak, nonatomic) IBOutlet UIView *viewEmailContent;
@property (weak, nonatomic) IBOutlet UITextField *EmailOne;
@property (weak, nonatomic) IBOutlet UITextField *EmailTwo;
@property (weak, nonatomic) IBOutlet UITextField *EmailThree;
@property (weak, nonatomic) IBOutlet UITextField *EmailFour;
@property (strong, nonatomic) IBOutlet UIButton *btnEmailVerify;
@property (strong, nonatomic) IBOutlet UILabel *lblemailerror;


//@property (nonatomic)int isCommingFromLoging;
@property (nonatomic,retain) NSString *strName, *strMobile, *strEmail, *strEmailCode, *strSMSCode;
//@property(nonatomic,retain)NSDictionary *dictPostParameter;
//@property(nonatomic,retain)NSMutableDictionary *dict;
//@property(nonatomic,retain)NSString *strName;
@property BOOL isRegistration;

- (IBAction)btnSMSResendPressed:(UIButton *)sender;
- (IBAction)btnVerifySMSPressed:(UIButton *)sender;
- (IBAction)btnEMAILResendPressed:(UIButton *)sender;
- (IBAction)btnVerifyEMAILPressed:(UIButton *)sender;
- (IBAction)btnProceedPressed:(UIButton *)sender;

@end
