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
#import "CustomTextfied.h"
#import "MBProgressHUD.h"
@interface RegistrationViewController ()<PassResepose>
{
    NSString *strEmailCode;
    NSString *strSMSCode;
    int isTrue;
}

@property (weak, nonatomic) IBOutlet CustomTextfied *txtFirstName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtLastName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtCity;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtState;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtZip;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtMobileNumber;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtTelephoneNumber;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtFaxNumber;

@property (weak, nonatomic) IBOutlet CustomTextfied *txtEmail;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtUserName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtPassword;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtConfarmPassword;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtAddress;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    isTrue=0;
    _imgCheckTermsAndCondition.image=[UIImage imageNamed:@""];
  
    
    self.navigationItem.title=@"Sign Up";
    
    // Do any additional setup after loading the view.
}

-(void)CheckEmailUserNameExist
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&fields=userid,username,email,name&filter=(username=%@)or(email=%@)",[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text],[ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text]] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
    
    
    
    
    
}

-(void)passReseposeData:(id)arr
{
    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
    if (arr1.count>0)
    {
        [ClsSetting ValidationPromt:@"Email or Username already exists please use other Email and Username"];
    }
    else
    {
       // [self RegisterUser];
        
        strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
        strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
        
        NSDictionary *params = @{@"name":[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text],
                                 @"city":_txtCity.text,
                                 @"state":_txtState.text,
                                 @"zip":_txtZip.text,
                                 @"Mobile":_txtMobileNumber.text,
                                 @"telephone":_txtTelephoneNumber.text,
                                 @"fax":_txtFaxNumber.text,
                                 @"email":_txtEmail.text,
                                 @"username":_txtUserName.text,
                                 @"password":_txtPassword.text,
                                 @"t_username":_txtUserName.text,
                                 @"t_password":_txtPassword.text,
                                 @"t_firstname":_txtFirstName.text,
                                 @"t_lastname":_txtLastName.text,
                                 @"t_City":_txtCity.text,
                                 @"t_State":_txtState.text,
                                 @"t_zip":_txtZip.text,
                                 @"t_telephone":_txtTelephoneNumber.text,
                                 @"t_fax":_txtFaxNumber.text,
                                 @"t_email":_txtEmail.text,
                                 @"t_mobile":_txtMobileNumber.text,
                                 @"SmsCode":strSMSCode,
                                 @"admin": @"0",
                                 @"address1":_txtAddress.text,
                                 @"BillingAddress":_txtAddress.text,
                                 @"t_billingaddress":_txtAddress.text,
                                 @"t_address1":_txtAddress.text,
                                  @"MobileVerified": @"1"
                                 };
        
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
        
        NSDictionary *pardsams = @{@"resource": arr};
        
          [[NSUserDefaults standardUserDefaults] setValue:[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text] forKey:USER_NAME];
        VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
        rootViewController.dictPostParameter=pardsams;
        rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text];
        rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text];
        rootViewController.strname=_txtFirstName.text;
        rootViewController.strSMSCode=strSMSCode;
        rootViewController.strEmialCode=strEmailCode;
        
        [self.navigationController pushViewController:rootViewController animated:YES];
        
        
        
    }
    
}
- (void)didReceiveMemoryWarning {
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
            [ClsSetting ValidationPromt:@"Please accept terms and condition"];
        }
       
      
    }
    //[self calllWeb];
}


-(void)RegisterUser
{
    strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
    strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
    
    NSDictionary *params = @{@"name":[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text],
                             @"city":_txtCity.text,
                             @"state":_txtState.text,
                             @"zip":_txtZip.text,
                             @"Mobile":_txtMobileNumber.text,
                             @"telephone":_txtTelephoneNumber.text,
                             @"fax":_txtFaxNumber.text,
                             @"email":_txtEmail.text,
                             @"username":_txtUserName.text,
                             @"password":_txtPassword.text,
                             @"t_username":_txtUserName.text,
                             @"t_password":_txtPassword.text,
                             @"t_firstname":_txtFirstName.text,
                             @"t_lastname":_txtLastName.text,
                             @"t_City":_txtCity.text,
                             @"t_State":_txtState.text,
                             @"t_zip":_txtZip.text,
                             @"t_telephone":_txtTelephoneNumber.text,
                             @"t_fax":_txtFaxNumber.text,
                             @"t_email":_txtEmail.text,
                             @"t_mobile":_txtMobileNumber.text,
                             @"SmsCode":strSMSCode,
                             @"admin": @"0",
                             @"address1":_txtAddress.text,
                             @"BillingAddress":_txtAddress.text,
                             @"t_billingaddress":_txtAddress.text,
                             @"t_address1":_txtAddress.text,
                             @"MobileVerified": @"1"
                             
                             };
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
    
    NSDictionary *pardsams = @{@"resource": arr};
    
    
    ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPostWeb2:pardsams url:[NSString stringWithFormat:@"%@/users?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objClssetting Url]] view:self.view];
}


-(void)closePressed
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*-(void)calllWeb
{
    NSDictionary *params = @{@"name":[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text],
                             @"city":_txtCity.text,
                             @"state":_txtState.text,
                             @"zip":_txtZip.text,
                             @"Mobile":_txtMobileNumber.text,
                             @"telephone":_txtTelephoneNumber.text,
                             @"fax":_txtFaxNumber.text,
                             @"email":_txtEmail.text,
                             @"t_username":_txtUserName.text,
                             @"t_password":_txtPassword.text,
                             @"t_firstname":_txtFirstName.text,
                             @"t_lastname":_txtLastName.text,
                             @"t_City":_txtCity.text,
                             @"t_State":_txtState.text,
                             @"t_zip":_txtZip.text,
                             @"t_telephone":_txtTelephoneNumber.text,
                             @"t_fax":_txtFaxNumber.text,
                             @"t_email":_txtEmail.text,
                             @"t_mobile":_txtMobileNumber.text,
                             @"admin": @"0"
                              };
                              
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
    
    NSDictionary *pardsams = @{@"resource": arr};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Dict %@",pardsams);
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    [manager POST:@"http://54.169.244.245/api/v2/guru/_table/users?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed" parameters:pardsams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
}*/
-(void)passReseposeData1:(id)str
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self SendSMSOTP];
    NSArray *value = str[@"resource"];
    NSLog(@"%@",value);
    NSDictionary *dictUser=[value objectAtIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:[dictUser valueForKey:@"userid"] forKey:USER_id];
    [[NSUserDefaults standardUserDefaults] setValue:[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text] forKey:USER_NAME];
    
    VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
    rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text];
    rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text];
    rootViewController.strname=_txtFirstName.text;
    rootViewController.strSMSCode=strSMSCode;
    rootViewController.strEmialCode=strEmailCode;
    
    [self.navigationController pushViewController:rootViewController animated:YES];
}
-(BOOL)validate
{
    if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtFirstName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter first name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtLastName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter last name"];
    return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtCity.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae select city name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtState.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae select state name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter mobile number"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text].length<10)
    {
        [ClsSetting ValidationPromt:@"mobile number should be 10 digits long"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter email-id"];
        return NO;
    }
    else if (![ClsSetting NSStringIsValidEmail:_txtEmail.text])
    {
        [ClsSetting ValidationPromt:@"Pleae enter valid email-id"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter user name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter password"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtConfarmPassword.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae enter confirm password"];
        return NO;
    }
    else if (![_txtPassword.text isEqualToString:_txtConfarmPassword.text])
    {
        [ClsSetting ValidationPromt:@"Password & confirm Password should be same"];
        return NO;
    }
    
    
    return YES;
}

-(void)SendSMSOTP
{
    NSDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    NSString *strMessage=[NSString stringWithFormat:@"Dear %@, One Time Password for your Mobile Verification is %@.\nRegards, \nTeam Astaguru.",[ClsSetting TrimWhiteSpaceAndNewLine:_txtFirstName.text],strSMSCode ];
    
    [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=Astaguru&passwd=icia12345&mobilenumber=%@&message=%@&sid =ASTGRU&mtype=N&DR=Y",[ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text],strMessage] view:self.view];
    //objSetting.PassReseposeDatadelegate=self;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


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
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_txtFirstName)
    {
       textField.placeholder = @"Your First Name";
        
    }
  else if (textField==_txtAddress)
    {
        textField.placeholder = @"Your Address";
        
    }
    else if (textField==_txtLastName)
    {
     textField.placeholder = @"Your Last Name";
    }
    else if (textField==_txtCity)
    {
        textField.placeholder = @"Enter Your City";
    }
    else if (textField==_txtState)
    {
        textField.placeholder = @"Enter Your State";
    }
    else if (textField==_txtZip)
    {
        textField.placeholder = @"Enter Your ZIP/PIN Code";
    }
    else if (textField==_txtMobileNumber)
    {
        textField.placeholder = @"+91";
    }
    else if (textField==_txtTelephoneNumber)
    {
        textField.placeholder = @"+91";
    }
    else if (textField==_txtFaxNumber)
    {
        textField.placeholder = @"+91";
    }
    else if (textField==_txtEmail)
    {
        textField.placeholder = @"name@Domain.com";
    }
    else if (textField==_txtUserName)
    {
        textField.placeholder = @"Enter a Name of your choice";
    }
    else if (textField==_txtPassword)
    {
        textField.placeholder = @"XXXXXXXXXXX";
    }
    else if (textField==_txtConfarmPassword)
    {
        textField.placeholder = @"XXXXXXXXXXX";
    }
}
@end