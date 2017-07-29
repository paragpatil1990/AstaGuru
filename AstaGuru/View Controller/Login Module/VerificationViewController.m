//
//  VerificationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "VerificationViewController.h"
#import "CongratulationViewController.h"
//#import "SWRevealViewController.h"
//#import "GlobalClass.h"
//#import "HomeViewController.h"

@interface VerificationViewController ()
{
    int isSMSVerifyed;
    int isEMAILVerifyed;
    
//    int isVerificatinWorking;
//    int isSMS;
}

@end

@implementation VerificationViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"Verification";

    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = nil;

    [self setNavigationBarCloseButton];//Target:self selector:@selector(closePressed)];

//    UIBarButtonItem * btnClose = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStylePlain target:self action:@selector(closePressed)];
//    [self.navigationItem setRightBarButtonItem:btnClose];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor],
//       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:16]}];
}

-(void)closePressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = rootViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];

    _lblemailerror.hidden= YES;
    _lblsmserror.hidden = YES;
    
    _strName = [GlobalClass getUserFullName];
    _strEmail = [[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_EMAIL];
    _strMobile = [[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_MOBILE];
    
    isSMSVerifyed = 0;
    isEMAILVerifyed = 0;
    
    if (_isRegistration)
    {
//        [self sendSMSOTP];
//        [self sendEmail];
    }
    else
    {
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_MOBILEVERIFIED] intValue] != 1)
        {
            _lblsmserror.hidden = NO;
            _lblsmserror.text = @"Not Verified";
            _lblsmserror.textColor = [UIColor redColor];
            [self sendSMSOTP];
        }
        else
        {
            isSMSVerifyed = 1;
            
            [_btnSMSResend setTitle:@"Verified" forState:UIControlStateNormal];
            [_btnSMSResend setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            _smsOne.hidden = YES;
            _smsTwo.hidden = YES;
            _smsThree.hidden = YES;
            _smsFour.hidden = YES;
            
            _btnMobileVerify.hidden = YES;
            
            _lblsmserror.hidden = YES;
            _lblsmserror.text = @"Verified";
            _lblsmserror.textColor = [UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0];
        }
        
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_EMAILVERIFIED] intValue] != 1)
        {
            _lblemailerror.hidden = NO;
            _lblemailerror.text = @"Not Verified";
            _lblemailerror.textColor = [UIColor redColor];
            [self sendEmail];
        }
        else
        {
            isEMAILVerifyed = 1;

//            isVerificatinWorking=1;
//            isSMS=2;
            
            [_btnEmailResend setTitle:@"Verified" forState:UIControlStateNormal];
            [_btnEmailResend setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            _EmailOne.hidden = YES;
            _EmailTwo.hidden = YES;
            _EmailThree.hidden = YES;
            _EmailFour.hidden = YES;
            
            _btnEmailVerify.hidden = YES;
            
            _lblemailerror.hidden = YES;
            _lblemailerror.text = @"Verified";
            _lblemailerror.textColor = [UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *subviews;
    subviews = [self.viewSMSContent subviews];
    UIColor *color = [UIColor colorWithRed:196.0/255.0 green:196.0/255.0 blue:196.0/255.0 alpha:1.0];
    for(UIView *subview in subviews)
    {
        if([subview isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)subview;
            [GlobalClass underline:textField color:color];
        }
    }
    
    subviews = [self.viewEmailContent subviews];
    for(UIView *subview in subviews)
    {
        if([subview isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)subview;
            [GlobalClass underline:textField color:color];
            
        }
    }
    
    _txtEmail.text = _strEmail;
    _txtMobile.text = _strMobile;
}


- (IBAction)btnBackPressed:(id)sender
{
    [self closePressed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSMSResendPressed:(UIButton *)sender
{
    
//    if ([_btnSMSResend.titleLabel.text isEqualToString:@"Verify"])
//    {
//        [_btnSMSResend setTitle:@"Resend" forState:UIControlStateNormal];
//    }
//    else
    
    if([_btnSMSResend.titleLabel.text isEqualToString:@"Resend"])
    {
        [self sendSMSOTP];   //Code for Sending SMS ThroughSMS getWay
    }
}

- (IBAction)btnVerifySMSPressed:(UIButton *)sender
{
    NSString *strSmsEnterString=[NSString stringWithFormat:@"%@%@%@%@", _smsOne.text, _smsTwo.text, _smsThree.text, _smsFour.text];
    
    if ([_strSMSCode isEqualToString:strSmsEnterString])
    {
        
        isSMSVerifyed = 1;
        
        _lblsmserror.hidden = YES;
        
        [_btnSMSResend setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnSMSResend setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        _smsOne.hidden = YES;
        _smsTwo.hidden = YES;
        _smsThree.hidden = YES;
        _smsFour.hidden = YES;
        _btnMobileVerify.hidden = YES;
        _lblsmserror.hidden = YES;
        _lblsmserror.text = @"Verified";
        _lblsmserror.textColor = [UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0];
        
    }
    else
    {
        _lblsmserror.hidden = NO;
        _lblsmserror.text = @"Invalid OTP Code";
        _lblsmserror.textColor = [UIColor redColor];
    }

}


- (IBAction)btnEMAILResendPressed:(UIButton *)sender
{
//    if ([_btnEmailResend.titleLabel.text isEqualToString:@"Verify"])
//    {
//        [_btnEmailResend setTitle:@"Resend" forState:UIControlStateNormal];
//    }
//    else
    if ([_btnEmailResend.titleLabel.text isEqualToString:@"Resend"])
    {
        [self sendEmail]; //Code for Sending Email ThroughSMS getWay
    }
}

- (IBAction)btnVerifyEMAILPressed:(UIButton *)sender
{
    NSString *strSmsEnterString=[NSString stringWithFormat:@"%@%@%@%@",_EmailOne.text,_EmailTwo.text,_EmailThree.text,_EmailFour.text];
    if ([_strEmailCode isEqualToString:strSmsEnterString])
    {
        isEMAILVerifyed = 1;
        
        _lblemailerror.hidden = YES;
        
//        isVerificatinWorking=1;
//        isSMS=2;
        
        [_btnEmailResend setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnEmailResend setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        _EmailOne.hidden = YES;
        _EmailTwo.hidden = YES;
        _EmailThree.hidden = YES;
        _EmailFour.hidden = YES;
        
        _btnEmailVerify.hidden = YES;
        
        _lblemailerror.hidden = YES;
        _lblemailerror.text = @"Verified";
        _lblemailerror.textColor = [UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0];
        
    }
    else
    {
        _lblemailerror.hidden = NO;
        _lblemailerror.text = @"Invalid OTP Code";
        _lblemailerror.textColor = [UIColor redColor];
    }
}


-(void)sendEmail
{
    _strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
    NSDictionary *dictMailParameters = @{
                               @"to":@[@{
                                           @"name":_strName,
                                           @"email":_strEmail,
                                           }],
                               @"subject":@"Warm Greetings from AstaGuru  Online Auction House.",
                               @"body_text": [NSString stringWithFormat:@"Dear %@,\n\n    Thank you for choosing AstaGuru Online Auction House. We are glad that you have given us this opportunity to cater to your Indian Art related requirements. Looking forward to building a longstanding relationship with you.\nPlease Enter the OTP %c%@%c to complete the registration & verification process.\nIn case you are unable to open the link, please write to us at, contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you further.\n\nWarm Regards,\nTeam AstaGuru\n",_strName,'"',_strEmailCode,'"']
                               };
    
    [GlobalClass sendEmail:dictMailParameters success:^(id responseObject)
     {
         [GlobalClass showTost:[NSString stringWithFormat:@"OTP sent to your email %@",_strEmail]];
     }failure:^(NSError *error)
     {
     }];
}

-(void)sendSMSOTP
{
    _strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
    NSString *strMessage=[NSString stringWithFormat:@"Dear %@, One Time Password for your Mobile Verification is %@.\nRegards, \nTeam Astaguru.",_strName,_strSMSCode ];
    
    NSDictionary *paraDic = @{
                              @"mobiles":_strMobile,
                              @"message":strMessage,
                              };
    
    [GlobalClass sendSMS:paraDic success:^(NSDictionary *responseObject)
                                 {
                                     [GlobalClass showTost:[NSString stringWithFormat:@"OTP sent to your number %@",_strMobile]];
                                 }
                                failure:^(NSError *error)
                                     {
                                     }];
}

- (IBAction)btnProceedPressed:(id)sender
{
    if (![_btnSMSResend.titleLabel.text isEqualToString:@"Verified"])
    {
        [GlobalClass showTost:@"To activate your AstaGuru account please verify your mobile number"];
    }
    else if(![_btnEmailResend.titleLabel.text isEqualToString:@"Verified"])
    {
        [GlobalClass showTost:@"To activate your AstaGuru account please verify your Email Address"];
    }
    else
    {
        NSString *userid;
        if (_isRegistration)
        {
            userid = [[NSUserDefaults standardUserDefaults] valueForKey:RUSER_ID];
        }
        else
        {
            userid = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID];
        }
        
        NSDictionary *paraDic = @{
                                  @"userid":userid,
                                  @"MobileVerified":@"1",
                                  @"EmailVerified":@"1",
                                  @"admin": @"0"
                                  };
        NSArray *resourceArray = [NSArray arrayWithObjects:paraDic,nil];
        NSDictionary *parameter = @{@"resource": resourceArray};

        NSString *strUrl = [NSString stringWithFormat:@"users?api_key=%@",[GlobalClass apiKey]];
        
        [GlobalClass call_tablePUTWeb:strUrl parameters:parameter view:self.view success:^(id responseObject)
         {
             NSMutableArray *resourceArray = responseObject[@"resource"];
             if (resourceArray.count > 0)
             {
                 [GlobalClass showTost:[NSString stringWithFormat:@"Congratulation your verification are done"]];
                 
                 NSLog(@"%@",resourceArray);
                 NSDictionary *userIDDic = [resourceArray objectAtIndex:0];
                 
                 [[NSUserDefaults standardUserDefaults] setValue:[userIDDic valueForKey:USER_ID] forKey:USER_ID];
                 
                 NSMutableDictionary *saveUserDic = [[NSUserDefaults standardUserDefaults] valueForKey:USER];
                 [saveUserDic setValue:@"1" forKey:USER_MOBILEVERIFIED];
                 [saveUserDic setValue:@"1" forKey:USER_EMAILVERIFIED];
                 [[NSUserDefaults standardUserDefaults] setObject:saveUserDic forKey:USER];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
                 CongratulationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CongratulationViewController"];
                 [self.navigationController pushViewController:rootViewController animated:YES];
             }
             else
             {
                 [GlobalClass showTost:[NSString stringWithFormat:@"Verification fail! please try again."]];
             }
             
         }failure:^(NSError *error)
         {
             [GlobalClass showTost:error.localizedDescription];
         }];
    }
}

//-(void)passReseposeData1:(id)str
//{
//    if (isVerificatinWorking==1 && isSMS==1)
//    {
//        [ClsSetting ValidationPromt:[NSString stringWithFormat:@"Congratulation your verification are done"]];
//        
//        NSArray *value = str[@"resource"];
//        NSLog(@"%@",value);
//        NSDictionary *dictUser = [value objectAtIndex:0];
//        [[NSUserDefaults standardUserDefaults] setValue:[dictUser valueForKey:USER_ID] forKey:USER_ID];
//        
////        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:USER_CONFIRMBID];
////        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:USER_EMAILVERIFIED];
////        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:USER_MOBILEVERIFIED];
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
//        CongratulationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CongratulationViewController"];
////        rootViewController.strname = _strname;
////        rootViewController.strEmail = _strEmail;
////        rootViewController.dict = _dict;
//        [self.navigationController pushViewController:rootViewController animated:YES];
//    }
//    else if (isVerificatinWorking==1 && isSMS==2)
//    {
//        _viwShowEmailContent.hidden=YES;
//        _htviwShowEmailContent.constant=0;
//        [_btnEmailVerifivation setTitle:@"Verified" forState:UIControlStateNormal];
//        [_btnEmailVerifivation setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [self btnEmailVerificationPressed:_btnEmailVerifivation];
//    }
//    else
//    {
//        [ClsSetting ValidationPromt:[NSString stringWithFormat:@"OTP sent to your number %@",_strMobile]];
//    }
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField==_smsOne)
    {
        NSUInteger length = currentString.length;
        if (length > 0)
        {   _smsOne.text=string;
            [_smsTwo becomeFirstResponder];
            return NO;
        }
    }
    else if (textField==_smsTwo)
        {
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _smsTwo.text=string;
                [_smsThree becomeFirstResponder];
                return NO;
            }
            else if (length == 0)
            {
                _smsTwo.text=string;
                [_smsOne becomeFirstResponder];
                return NO;
            }

        }
        else if (textField==_smsThree)
        {
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _smsThree.text=string;
                [_smsFour becomeFirstResponder];
                return NO;
            }
            else if (length == 0)
            {
                _smsThree.text=string;
                [_smsTwo becomeFirstResponder];
                return NO;
            }
        }
        else if (textField==_smsFour)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _smsFour.text=string;
                return NO;
            }
            else if (length == 0)
            {
                _smsFour.text=string;
                [_smsThree becomeFirstResponder];
                return NO;
            }
        }
        else if (textField==_EmailOne)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _EmailOne.text=string;
                 [_EmailTwo becomeFirstResponder];
                return NO;
            }
            
        }
        else if (textField==_EmailTwo)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _EmailTwo.text=string;
                 [_EmailThree becomeFirstResponder];
                return NO;
            }
            else if (length == 0)
            {
                _EmailTwo.text=string;
                [_EmailOne becomeFirstResponder];
                return NO;
            }
        }
        else if (textField==_EmailThree)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _EmailThree.text=string;
                [_EmailFour becomeFirstResponder];
                return NO;
            }
            else if (length == 0)
            {
                _EmailThree.text=string;
                [_EmailTwo becomeFirstResponder];
                return NO;
            }
        }
        else if (textField==_EmailFour)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _EmailFour.text=string;
                return NO;
            }
            else if (length == 0)
            {
                _EmailFour.text=string;
                [_EmailThree becomeFirstResponder];
                return NO;
            }
        }
    
    return YES;
}

@end
