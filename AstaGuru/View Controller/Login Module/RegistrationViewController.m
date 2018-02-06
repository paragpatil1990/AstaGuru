//
//  RegistrationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 09/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "RegistrationViewController.h"
#import "VerificationViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ClsSetting.h"
//#import "CustomTextfied.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface RegistrationViewController ()<PassResepose>
{
    NSString *strEmailCode;
    NSString *strSMSCode;
    int isTrue;
    NSDictionary *paradict;
}

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (strong, nonatomic) IBOutlet UITextField *txtcountry;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (strong, nonatomic) IBOutlet UITextField *txtCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtTelephoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFaxNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfarmPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;

@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];
    isTrue=0;
    _imgCheckTermsAndCondition.image=[UIImage imageNamed:@""];
  
    
    self.navigationItem.title=@"Sign Up";
    
    _imgCheckTermsAndCondition.layer.cornerRadius = 10;
    _imgCheckTermsAndCondition.clipsToBounds = YES;

    [self setBroder];
    // Do any additional setup after loading the view.
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    [ClsSetting SetBorder:_btnProceed cornerRadius:5 borderWidth:0 color:bColor];

    [ClsSetting SetBorder:_fName_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_lName_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_address_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_city_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_country_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_state_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_zip_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_mobile_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_telephone_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_fax_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_email_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_userName_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_password_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_confirmPassword_View cornerRadius:2 borderWidth:1 color:bColor];    
}
-(void)CheckEmailUserNameExist
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=%@&fields=userid,username,email,name&filter=(username=%@)or(email=%@)",[ClsSetting apiKey],[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text],[ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text]] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
    
}

-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
    if (arr1.count>0)
    {
        [ClsSetting ValidationPromt:@"Email or Username already exists please use other Email and Username"];
    }
    else
    {
        [self RegisterUser];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}
- (IBAction)btnProccedPressed:(id)sender
{
    if ([self validate])
    {
        if (isTrue)
        {
            [self CheckEmailUserNameExist];
        }
        else
        {
            [ClsSetting ValidationPromt:@"Please Accept Terms and Conditions"];
        }
    }
}
-(void)RegisterUser
{
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate registerForRemoteNotification];

    strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
    strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
    
    NSString *nickname = [NSString stringWithFormat:@"Anonymous%u",arc4random() % 900000 + 100000];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *registrationDate = [DateFormatter stringFromDate:[NSDate date]];
    

    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    if (deviceToken == nil)
    {
        deviceToken = @"";
    }

    
    NSDictionary *params = @{@"name":[NSString stringWithFormat:@"%@",_txtFirstName.text],
                             @"lastname":_txtLastName.text,
                             @"city":_txtCity.text,
                             @"country":_txtcountry.text,
                             @"state":_txtState.text,
                             @"zip":_txtZip.text,
                             @"address1":_txtAddress.text,
                             @"Mobile":[NSString stringWithFormat:@"%@%@",_txtCountryCode.text,_txtMobileNumber.text],
                             @"telephone":_txtTelephoneNumber.text,
                             @"fax":_txtFaxNumber.text,
                             @"email":_txtEmail.text,
                             @"username":_txtUserName.text,
                             @"password":_txtPassword.text,
                             @"nickname":nickname,
                             @"t_username":_txtUserName.text,
                             @"t_password":_txtPassword.text,
                             @"t_firstname":_txtFirstName.text,
                             @"t_lastname":_txtLastName.text,
                             @"t_City":_txtCity.text,
                             @"t_State":_txtState.text,
                             @"t_Country":_txtcountry.text,
                             @"t_zip":_txtZip.text,
                             @"t_telephone":_txtTelephoneNumber.text,
                             @"t_fax":_txtFaxNumber.text,
                             @"t_email":_txtEmail.text,
                             @"t_mobile":[NSString stringWithFormat:@"%@%@",_txtCountryCode.text,_txtMobileNumber.text],
                             @"t_address1":_txtAddress.text,
                             @"t_nickname":nickname,
                             @"t_billingaddress":_txtAddress.text,
                             @"t_billingname":[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text],
                             @"t_billingcity":_txtCity.text,
                             @"t_billingstate":_txtState.text,
                             @"t_billingcountry":_txtcountry.text,
                             @"t_billingzip":_txtZip.text,
                             @"t_billingtelephone":_txtTelephoneNumber.text,
                             @"t_billingemail":_txtEmail.text,
                             @"BillingName":[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text],
                             @"BillingCity":_txtCity.text,
                             @"BillingState":_txtState.text,
                             @"BillingCountry":_txtcountry.text,
                             @"BillingZip":_txtZip.text,
                             @"BillingAddress":_txtAddress.text,
                             @"BillingTelephone":_txtTelephoneNumber.text,
                             @"BillingEmail":_txtEmail.text,
                             @"SmsCode":strSMSCode,
                             @"admin": @"0",
                             @"MobileVerified": @"0",
                             @"EmailVerified":@"0",
                             @"chatdept":@"test",
                             @"confirmbid":@"0",
                             @"Visits":@"0",
                             @"buy":@"0",
                             @"applyforbid":@"1",
                             @"applyforchange":@"0",
                             @"RegistrationDate":registrationDate,
                             @"deviceTocken":deviceToken
                             };
    
    paradict = params;
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
    
    NSDictionary *pardsams = @{@"resource": arr};
    ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPostWeb2:pardsams url:[NSString stringWithFormat:@"%@/users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]] view:self.view];
}
-(void)closePressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)passReseposeData1:(id)str
{
    NSArray *value = str[@"resource"];
    NSLog(@"%@",value);
    NSMutableDictionary *dictUser=[value objectAtIndex:0];
    NSDictionary *dict=[ClsSetting RemoveNullOnly:dictUser];

//    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] setValue:[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text] forKey:USER_NAME];
//    [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"userid"] forKey:USER_id];
    [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"userid"] forKey:@"ruserid"];
    [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"confirmbid"];
    [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"EmailVerified"];
    [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"MobileVerified"];
    
    
    VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
//    rootViewController.dictPostParameter=pardsams;
    rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text];
    rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text];
    rootViewController.strname=_txtFirstName.text;
    rootViewController.strSMSCode=strSMSCode;
    rootViewController.strEmialCode=strEmailCode;
    rootViewController.isRegistration = YES;
    rootViewController.dict = [paradict mutableCopy];
    [self.navigationController pushViewController:rootViewController animated:YES];
}
-(BOOL)validate
{
    if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtFirstName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter First Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtLastName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Last Name"];
    return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtAddress.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Address"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtCity.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter City"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtcountry.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Country"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtState.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter State"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtZip.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Zip Code"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtCountryCode.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Country Code"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Mobile Number"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtTelephoneNumber.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Telephone Number"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text].length<10)
    {
        [ClsSetting ValidationPromt:@"Mobile number should be 10 digits long"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Email Id"];
        return NO;
    }
    else if (![ClsSetting NSStringIsValidEmail:_txtEmail.text])
    {
        [ClsSetting ValidationPromt:@"Enter Valid Email Id"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter User Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Enter Password"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text].length<6)
    {
        [ClsSetting ValidationPromt:@"Password Not Less Than 6 Digits"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtConfarmPassword.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Re-enter Password"];
        return NO;
    }
    else if (![_txtPassword.text isEqualToString:_txtConfarmPassword.text])
    {
        [ClsSetting ValidationPromt:@"Password Not Match"];
        return NO;
    }
    return YES;
}


- (IBAction)btnAgreePressed:(id)sender
{
    if (isTrue==0)
    {
        isTrue=1;
        _imgCheckTermsAndCondition.image=[UIImage imageNamed:@"img-checkbox-checked"];
    }
    else
    {
        isTrue=0;
        _imgCheckTermsAndCondition.image=[UIImage imageNamed:@""];

    }
}

- (IBAction)btnTermsAndCondition:(id)sender
{
    if (isTrue==0)
    {
        isTrue=1;
        _imgCheckTermsAndCondition.image=[UIImage imageNamed:@"img-checkbox-checked"];
    }
    else
    {
        isTrue=0;
        _imgCheckTermsAndCondition.image=[UIImage imageNamed:@""];
        
    } 
}

#define MAX_LENGTH 13

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_txtMobileNumber)
    {
        if (textField.text.length >= MAX_LENGTH && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {return YES;}
    }
    else
        return YES;
}
@end
