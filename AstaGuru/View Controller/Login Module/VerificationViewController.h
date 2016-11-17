//
//  VerificationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextfied.h"
@interface VerificationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtMobile;
@property (weak, nonatomic) IBOutlet CustomTextfied *smsOne;
@property (weak, nonatomic) IBOutlet CustomTextfied *smsTwo;
@property (weak, nonatomic) IBOutlet CustomTextfied *smsThree;
@property (weak, nonatomic) IBOutlet CustomTextfied *smsFour;

@property (weak, nonatomic) IBOutlet CustomTextfied *EmailOne;
@property (weak, nonatomic) IBOutlet CustomTextfied *EmailTwo;
@property (weak, nonatomic) IBOutlet CustomTextfied *EmailThree;
@property (weak, nonatomic) IBOutlet CustomTextfied *EmailFour;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtEmail;
@property(nonatomic,retain)NSString *strMobile,*strEmail,*strEmialCode,*strSMSCode;
@property(nonatomic,retain)NSDictionary *dictPostParameter;
@property(nonatomic,retain)NSString *strname;
@end
