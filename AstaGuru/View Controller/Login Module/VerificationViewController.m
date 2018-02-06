//
//  VerificationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "VerificationViewController.h"
#import "CongratulationViewController.h"
//#import "CustomTextfied.h"
#import "SWRevealViewController.h"
#import "ClsSetting.h"
#import "ViewController.h"
#import "AppDelegate.h"
@interface VerificationViewController ()<PassResepose>
{
    int isVerificatinWorking;
    int isSMS;
}
@property (weak, nonatomic) IBOutlet UIButton *btnMobileVerification;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailVerifivation;
@property (weak, nonatomic) IBOutlet UIView *viewShowContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *htViwShowContent;
@property (weak, nonatomic) IBOutlet UIView *viwShowEmailContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *htviwShowEmailContent;
@property (strong, nonatomic) IBOutlet UILabel *lblsmserror;
@property (strong, nonatomic) IBOutlet UILabel *lblemailerror;

@end

@implementation VerificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lblemailerror.hidden= YES;
    _lblsmserror.hidden = YES;
    [self setUpNavigationItem];
    if (_isRegistration)
    {
        [self SendSMSOTP];
        [self SendEmail];
    }
    else
    {
        if ([_dict[@"MobileVerified"] intValue] != 1)
        {
            _lblsmserror.hidden = NO;
            _lblsmserror.text = @"Not Verified";
            _lblsmserror.textColor = [UIColor redColor];
            [self SendSMSOTP];
        }
        else
        {
            
            [_btnMobileVerification setTitle:@"Verified" forState:UIControlStateNormal];
            [_btnMobileVerification setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            _smsOne.hidden = YES;
            _smsTwo.hidden = YES;
            _smsThree.hidden = YES;
            _smsFour.hidden = YES;
            _btnMobileVerify.hidden = YES;
            _lblsmserror.hidden = YES;
            _lblsmserror.text = @"Mobile Number Verified";
            _lblsmserror.textColor = [UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0];
        }
        
        if ([_dict[@"EmailVerified"] intValue] != 1)
        {
            _lblemailerror.hidden = NO;
            _lblemailerror.text = @"Not Verified";
            _lblemailerror.textColor = [UIColor redColor];
            [self SendEmail];
        }
        else
        {
            isVerificatinWorking=1;
            isSMS=2;
            [_btnEmailVerifivation setTitle:@"Verified" forState:UIControlStateNormal];
            [_btnEmailVerifivation setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            _EmailOne.hidden = YES;
            _EmailTwo.hidden = YES;
            _EmailThree.hidden = YES;
            _EmailFour.hidden = YES;
            _btnEmailVerify.hidden = YES;
            _lblemailerror.hidden = YES;
            _lblemailerror.text = @"Email Id Verified";
            _lblemailerror.textColor = [UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0];
        }
    }
}

-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    self.navigationItem.title=@"Verification";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *subviews;
    subviews = [self.viewShowContent subviews];
    for(UIView *subview in subviews)
    {
        if([subview isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)subview;
            [ClsSetting underline:textField];
        }
    }
    subviews = [self.viwShowEmailContent subviews];
    for(UIView *subview in subviews)
    {
        if([subview isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)subview;
            [ClsSetting underline:textField];
            
        }
    }
   // _viewShowContent.hidden=YES;
   // _viwShowEmailContent.hidden=YES;
   // _htViwShowContent.constant=0;
   // _htviwShowEmailContent.constant=0;
    _txtEmail.text=_strEmail;
    _txtMobile.text=_strMobile;
    
}
-(void)closePressed
{
    //if (_IsCommingFromLoging==1)
    //{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        UIViewController *viewController =rootViewController;
        AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        objApp.window.rootViewController = viewController;
    //}
    //else
    //{
     //   [self.navigationController popViewControllerAnimated:YES];
    //}
}
- (IBAction)btnBackPressed:(id)sender
{
    [self closePressed];
}

- (IBAction)btnProceedPressed:(id)sender
{
    if (![_btnMobileVerification.titleLabel.text isEqualToString:@"Verified"])
    {
        [ClsSetting ValidationPromt:@"To activate your AstaGuru account please verify your mobile number"];
    }
    else if(![_btnEmailVerifivation.titleLabel.text isEqualToString:@"Verified"])
    {
        [ClsSetting ValidationPromt:@"To activate your AstaGuru account please verify your Email Address"];
    }
    else
    {
        isVerificatinWorking=1;
        isSMS=1;
        
        NSString *userid;
        if (_isRegistration)
        {
            userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"ruserid"];
        }
        else
        {
            userid = [[NSUserDefaults standardUserDefaults] valueForKey:USER_id];
        }
        NSDictionary *params = @{
                                 @"userid":userid,
                                 @"MobileVerified":@"1",
                                 @"EmailVerified":@"1",
                                 @"admin": @"0"
                                 };
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
        NSDictionary *pardsams = @{@"resource": arr};
        ClsSetting *objClssetting=[[ClsSetting alloc] init];
        objClssetting.PassReseposeDatadelegate=self;
        [objClssetting calllPutWeb:pardsams url:[NSString stringWithFormat:@"%@/users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]] view:self.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnMobileVerificationPressed:(id)sender
{
    if ([_btnMobileVerification.titleLabel.text isEqualToString:@"Verify"])
    {
        [_btnMobileVerification setTitle:@"Resend" forState:UIControlStateNormal];
    }
    else if([_btnMobileVerification.titleLabel.text isEqualToString:@"Resend"])
    {
        [self SendSMSOTP];   //Code for Sending SMS ThroughSMS getWay
    }
}

- (IBAction)btnEmailVerificationPressed:(id)sender
{
    if ([_btnEmailVerifivation.titleLabel.text isEqualToString:@"Verify"])
    {
        [_btnEmailVerifivation setTitle:@"Resend" forState:UIControlStateNormal];
    }
    else if ([_btnEmailVerifivation.titleLabel.text isEqualToString:@"Resend"])
    {
       [self SendEmail]; //Code for Sending Email ThroughSMS getWay
    }
}

- (IBAction)btnCheckVerfysms:(id)sender
{
    NSString *strSmsEnterString=[NSString stringWithFormat:@"%@%@%@%@",_smsOne.text,_smsTwo.text,_smsThree.text,_smsFour.text];
    if ([_strSMSCode isEqualToString:strSmsEnterString])
    {
      
        _lblsmserror.hidden = YES;
        [_btnMobileVerification setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnMobileVerification setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
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
        _lblsmserror.text = @"Please Enter Valid Code";
        _lblsmserror.textColor = [UIColor redColor];
    }
}
- (IBAction)btnCheckVerifyEmail:(id)sender
{
    NSString *strSmsEnterString=[NSString stringWithFormat:@"%@%@%@%@",_EmailOne.text,_EmailTwo.text,_EmailThree.text,_EmailFour.text];
    if ([_strEmialCode isEqualToString:strSmsEnterString])
    {
        _lblemailerror.hidden = YES;

        isVerificatinWorking=1;
        isSMS=2;
        [_btnEmailVerifivation setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnEmailVerifivation setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
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
        _lblemailerror.text = @"Please Enter Valid Code";
        _lblemailerror.textColor = [UIColor redColor];
    }
}
-(void)SendEmail
{
    
    [ClsSetting ValidationPromt:[NSString stringWithFormat:@"OTP Has Been Sent To Your Email Id %@",_strEmail]];

    NSDictionary *dictTo = @{
                             @"name":[NSString stringWithFormat:@"%@",_strname],
                             @"email":_strEmail,
                             };
    
    NSArray*arrTo=[[NSArray alloc]initWithObjects:dictTo, nil];
    // NSDictionary *dictMail=[[NSDictionary alloc]init];
    NSDictionary *dictMail = @{
                               @"template":@"newsletter",
                               @"to":arrTo,
                               @"subject":@"Warm Greetings from AstaGuru  Online Auction House.",//@"Astaguru Email Validation OTP",
                               @"body_text": [NSString stringWithFormat:@"Dear %@,\n\n    Thank you for choosing AstaGuru Online Auction House. We are glad that you have given us this opportunity to cater to your Indian Art related requirements. Looking forward to building a longstanding relationship with you.\nPlease Enter the OTP %c%@%c to complete the registration & verification process.\nIn case you are unable to open the link, please write to us at, contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you further.\n\nWarm Regards,\nTeam AstaGuru\n",_strname,'"',_strEmialCode,'"'],
                               @"from_name":@"AstaGuru",
                               @"from_email":@"info@infomanav.com",
                               @"reply_to_name":@"AstaGuru",
                               @"reply_to_email":@"info@infomanav.com",
                               };
    [ClsSetting sendEmailWithInfo:dictMail];
}
-(void)SendSMSOTP
{
    NSDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    NSString *strMessage=[NSString stringWithFormat:@"Dear %@, One Time Password for your Mobile Verification is %@.\nRegards, \nTeam Astaguru.",_strname,_strSMSCode ];
    
    [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://gateway.netspaceindia.com/api/sendhttp.php?authkey=131841Aotn6vhT583570b5&mobiles=%@&message=%@&sender=AstGru&route=4&country=91",_strMobile,strMessage] view:self.view];
    objSetting.PassReseposeDatadelegate=self;
}


-(void)passReseposeData1:(id)str
{
    if (isVerificatinWorking==1 && isSMS==1)
    {
        [ClsSetting ValidationPromt:[NSString stringWithFormat:@"Congratulation your verification are done"]];
        
        NSArray *value = str[@"resource"];
        NSLog(@"%@",value);
        NSDictionary *dictUser=[value objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setValue:[dictUser valueForKey:@"userid"] forKey:USER_id];
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"confirmbid"];
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"EmailVerified"];
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"MobileVerified"];
        
//        [[NSUserDefaults standardUserDefaults] setObject:dictUser forKey:@"user"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        CongratulationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CongratulationViewController"];
        rootViewController.strname = _strname;
        rootViewController.strEmail = _strEmail;
        rootViewController.dict = _dict;
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
    else if (isVerificatinWorking==1 && isSMS==2)
    {
        _viwShowEmailContent.hidden=YES;
        _htviwShowEmailContent.constant=0;
        [_btnEmailVerifivation setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnEmailVerifivation setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self btnEmailVerificationPressed:_btnEmailVerifivation];
    }
    else
    {
        [ClsSetting ValidationPromt:[NSString stringWithFormat:@"OTP Has Been Sent To Your Mobile Number  %@",_strMobile]];
    }
}
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
