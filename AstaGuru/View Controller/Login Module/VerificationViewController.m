//
//  VerificationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "VerificationViewController.h"
#import "CongratulationViewController.h"
#import "CustomTextfied.h"
#import "ClsSetting.h"
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

@end

@implementation VerificationViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
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
    [self SendSMSOTP];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *subviews;
    subviews = [self.viwShowEmailContent subviews];
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
    _viewShowContent.hidden=YES;
    _viwShowEmailContent.hidden=YES;
    _htViwShowContent.constant=0;
    _htviwShowEmailContent.constant=0;
    _txtEmail.text=_strEmail;
    _txtMobile.text=_strMobile;
    
}
-(void)closePressed
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    /*else if(![_btnEmailVerifivation.titleLabel.text isEqualToString:@"Verified"])
    {
        [ClsSetting ValidationPromt:@"To activate your AstaGuru account please verify your Email Address"];
    }*/
    else
    {
        isVerificatinWorking=1;
        isSMS=1;
         [self RegisterUser];
  
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnMobileVerificationPressed:(id)sender
{
    if ([_btnMobileVerification.titleLabel.text isEqualToString:@"Verify"])
    {
        _viewShowContent.hidden=NO;
        _htViwShowContent.constant=100;
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
        _viwShowEmailContent.hidden=NO;
        _htviwShowEmailContent.constant=100;
        [_btnEmailVerifivation setTitle:@"Resend" forState:UIControlStateNormal];
    }
    else if ([_btnEmailVerifivation.titleLabel.text isEqualToString:@"Resend"])
    {
        //Code for Sending Email ThroughSMS getWay
    }
    
    
    
}
- (IBAction)btnCheckVerfysms:(id)sender
{
    NSString *strSmsEnterString=[NSString stringWithFormat:@"%@%@%@%@",_smsOne.text,_smsTwo.text,_smsThree.text,_smsFour.text];
    if ([_strSMSCode isEqualToString:strSmsEnterString])
    {
       
       // [self MobileVerification:@"SmsCode" CodeValue:_strSMSCode verificationCodeKey:@"MobileVerified"];
        
        [_btnMobileVerification setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnMobileVerification setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        _viewShowContent.hidden=YES;
        _htViwShowContent.constant=0;
        
       
    }
    else
    {
    [_btnMobileVerification setTitle:@"Invalid OTP SMS" forState:UIControlStateNormal];
        [_btnMobileVerification setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
- (IBAction)btnCheckVerifyEmail:(id)sender
{
    NSString *strSmsEnterString=[NSString stringWithFormat:@"%@%@%@%@",_EmailOne.text,_smsTwo.text,_smsThree.text,_smsFour.text];
    if ([_strEmialCode isEqualToString:strSmsEnterString])
    {
        isVerificatinWorking=1;
        isSMS=2;
        [self MobileVerification:@"activationcode" CodeValue:_strEmialCode verificationCodeKey:@"EmailVerified"];
    }
    else
    {
    [_btnEmailVerifivation setTitle:@"Invalid OTP SMS" forState:UIControlStateNormal];
        [_btnEmailVerifivation setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
-(void)SendSMSOTP
{
    NSDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    NSString *strMessage=[NSString stringWithFormat:@"Dear %@, One Time Password for your Mobile Verification is %@.\nRegards, \nTeam Astaguru.",_strname,_strSMSCode ];
    
    [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=Astaguru&passwd=icia12345&mobilenumber=%@&message=%@&sid =ASTGRU&mtype=N&DR=Y",_strMobile,strMessage] view:self.view];
    objSetting.PassReseposeDatadelegate=self;
}
-(void)passReseposeData1:(id)str
{
    if (isVerificatinWorking==1 && isSMS==1)
    {
        
       
        NSArray *value = str[@"resource"];
        NSLog(@"%@",value);
        NSDictionary *dictUser=[value objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setValue:[dictUser valueForKey:@"userid"] forKey:USER_id];
      
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        CongratulationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CongratulationViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
        
       
       
    }
   else if (isVerificatinWorking==1 && isSMS==2)
    {
        _viewShowContent.hidden=YES;
        _htviwShowEmailContent.constant=0;
        [_btnEmailVerifivation setTitle:@"Verified" forState:UIControlStateNormal];
        [_btnEmailVerifivation setTitleColor:[UIColor colorWithRed:73.0/255.0 green:185.0/255.0 blue:126.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self btnEmailVerificationPressed:_btnEmailVerifivation];
    }
    else
    {
    [ClsSetting ValidationPromt:[NSString stringWithFormat:@"OTP sent to your number %@",_strMobile]];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
  /*  if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (textField == _smsOne)
    {
        [_smsTwo resignFirstResponder];
    }
    else if (textField == _smsTwo)
    {
        [_smsThree resignFirstResponder];
        //UITextPosition *beginning = [textField beginningOfDocument];
        //[_smsThree setSelectedTextRange:[textField textRangeFromPosition:beginning
                                                            //toPosition:beginning]];
    }
    else if (textField == _smsThree)
    {
        UITextPosition *beginning = [textField beginningOfDocument];
        [_smsFour setSelectedTextRange:[textField textRangeFromPosition:beginning
                                                              toPosition:beginning]];
    }
    return newLength <= 1;*/
   

    /*if(textField == _smsOne)
    {
        if (_smsOne.text.length > 1  && range.length == 0 )
        {
            return NO;
        }
        else {
           
            [_smsTwo becomeFirstResponder];
            return YES;
        }
    }
    else if(textField == _smsTwo)
    {
        if (_smsTwo.text.length > 1  && range.length == 0 )
        {
            return NO;
        }else {
          
            [_smsThree becomeFirstResponder];
            return YES;
        }
    }
    return YES;*/
    
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
        
        }
        else if (textField==_smsFour)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _smsFour.text=string;
               
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
            
        }
        else if (textField==_EmailFour)
        {
            
            NSUInteger length = currentString.length;
            if (length > 0)
            {
                _EmailFour.text=string;
                
                return NO;
            }
            
        }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
           textField.placeholder = @"x";
  
}

-(void)MobileVerification:(NSString*)strCodeKey CodeValue:(NSString*)strCodeValue verificationCodeKey:(NSString *)strVerificationCodeKey
{
if ([self validate])
{
 //SmsCode
    
    NSDictionary *params = @{
                             @"userid":[[NSUserDefaults standardUserDefaults]valueForKey:USER_id],
                             strCodeKey:strCodeValue,
                             strVerificationCodeKey:@"1",
                              @"admin": @"0",
                             };
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
    
    NSDictionary *pardsams = @{@"resource": arr};
    
    
    ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPutWeb:pardsams url:[NSString stringWithFormat:@"%@/users/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objClssetting Url]] view:self.view];
}
//[self calllWeb];
}
-(BOOL)validate
{
    if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtMobile.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter First Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter Last Name"];
        return NO;
    }
    
    
    return YES;
}


-(void)RegisterUser
{
    
    ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPostWeb2:_dictPostParameter url:[NSString stringWithFormat:@"%@/users?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objClssetting Url]] view:self.view];
}


@end
