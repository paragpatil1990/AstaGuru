//
//  VerificationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomTextfied.h"
@interface VerificationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UITextField *smsOne;
@property (weak, nonatomic) IBOutlet UITextField *smsTwo;
@property (weak, nonatomic) IBOutlet UITextField *smsThree;
@property (weak, nonatomic) IBOutlet UITextField *smsFour;
@property (weak, nonatomic) IBOutlet UITextField *EmailOne;
@property (weak, nonatomic) IBOutlet UITextField *EmailTwo;
@property (weak, nonatomic) IBOutlet UITextField *EmailThree;
@property (weak, nonatomic) IBOutlet UITextField *EmailFour;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnMobileVerify;
@property (strong, nonatomic) IBOutlet UIButton *btnEmailVerify;
@property(nonatomic)int IsCommingFromLoging;

@property(nonatomic,retain)NSString *strMobile,*strEmail,*strEmialCode,*strSMSCode;
//@property(nonatomic,retain)NSDictionary *dictPostParameter;
@property(nonatomic,retain)NSMutableDictionary *dict;
@property(nonatomic,retain)NSString *strname;
@property BOOL isRegistration;
@end
