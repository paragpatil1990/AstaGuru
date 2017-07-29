//
//  RegistrationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 09/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "RegistrationViewController.h"
#import "VerificationViewController.h"

@interface RegistrationViewController ()
{
}

@end

@implementation RegistrationViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"Sign Up";
    
    //[self.navigationItem setHidesBackButton:YES];
    
   // [self setNavigationBarCloseButton];//Target:self selector:@selector(closePressed)];

}

-(void)closePressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    [self setUpNavigationItem];
    
//    isTrue=0;

    [self setBroder];
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    
    [GlobalClass setBorder:_btnProceed cornerRadius:5 borderWidth:0 color:bColor];

    [GlobalClass setBorder:_fName_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_lName_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_address_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_city_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_country_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_state_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_zip_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_mobile_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_telephone_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_fax_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_email_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_userName_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_password_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_confirmPassword_View cornerRadius:2 borderWidth:1 color:bColor];
    
    _imgCheckTermsAndCondition.image = nil;
    [GlobalClass setBorder:_imgCheckTermsAndCondition cornerRadius:10 borderWidth:1 color:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAgreePressed:(id)sender
{
    if (_btnTandC.selected == NO)
    {
        _btnTandC.selected = YES;
        _imgCheckTermsAndCondition.image=[UIImage imageNamed:@"img-checkbox-checked"];
    }
    else
    {
        _btnTandC.selected = NO;
        _imgCheckTermsAndCondition.image=[UIImage imageNamed:@""];
    }
}


- (IBAction)btnProccedPressed:(id)sender
{
    if ([self validate])
    {
        if(_btnTandC.selected)
        {
            [self checkEmailORUsernameExist];
        }
        else
        {
            [GlobalClass showTost:@"Please accept terms and condition"];
        }
    }
}

-(void)checkEmailORUsernameExist
{
    NSString *url = [NSString stringWithFormat:@"users/?api_key=%@&fields=userid,username,email,name&filter=(username=%@)or(email=%@)", [GlobalClass apiKey], [GlobalClass trimWhiteSpaceAndNewLine:_txtUserName.text], [GlobalClass trimWhiteSpaceAndNewLine:_txtEmail.text]];
    
    [GlobalClass call_tableGETWebURL:url parameters:nil view:self.view success:^(id responseObject)
     {
         NSArray *resourceArray = responseObject[@"resource"];
         if (resourceArray.count > 0)
         {
             [GlobalClass showTost:@"Email or Username already exists please use other Email and Username"];
         }
         else
         {
             [self registerUser];
         }
     }failure:^(NSError *error)
     {
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
}

-(void)registerUser
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate registerForRemoteNotification];

    NSString *nickname = [NSString stringWithFormat:@"Anonymous%u",arc4random() % 900000 + 100000];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *registrationDate = [DateFormatter stringFromDate:[NSDate date]];
    
    NSString *deviceToken = @"";
    if (TARGET_IPHONE_SIMULATOR)
    {
        deviceToken=@"";
    }
    else
    {
        deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICETOKEN];
    }
    if (deviceToken == nil)
    {
        deviceToken = @"";
    }
    
    NSDictionary *userDic = @{@"name":[NSString stringWithFormat:@"%@",_txtFirstName.text],
                             @"lastname":_txtLastName.text,
                             @"city":_txtCity.text,
                             @"country":_txtcountry.text,
                             @"state":_txtState.text,
                             @"zip":_txtZip.text,
                             @"address1":_txtAddress.text,
                             @"Mobile":[NSString stringWithFormat:@"%@%@",[GlobalClass trimWhiteSpaceAndNewLine:_txtCountryCode.text], [GlobalClass trimWhiteSpaceAndNewLine:_txtMobileNumber.text]],
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
                             @"t_mobile":[NSString stringWithFormat:@"%@%@",[GlobalClass trimWhiteSpaceAndNewLine:_txtCountryCode.text], [GlobalClass trimWhiteSpaceAndNewLine:_txtMobileNumber.text]],
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
                             @"admin": @"0",
                             @"MobileVerified": @"0",
                             @"EmailVerified":@"0",
                             @"confirmbid":@"0",
                             @"Visits":@"0",
                             @"buy":@"0",
                             @"applyforbid":@"1",
                             @"applyforchange":@"0",
                             @"chatdept":@"test",
                             @"RegistrationDate":registrationDate,
                             @"deviceTocken":deviceToken
                             };
    
    NSArray *resourceArray = [NSArray arrayWithObjects:userDic,nil];
    NSDictionary *parameter = @{@"resource": resourceArray};
    
    NSString *urlStr = [NSString stringWithFormat:@"users?api_key=%@", [GlobalClass apiKey]];
    
    [GlobalClass call_tablePOSTWebURL:urlStr parameters:parameter view:self.view success:^(NSDictionary *responseObject)
     {
         NSMutableArray *resourceArray = responseObject[@"resource"];
         if (resourceArray.count > 0)
         {
             NSMutableDictionary *dictUserID = [resourceArray objectAtIndex:0];
             
             [[NSUserDefaults standardUserDefaults] setValue:[dictUserID valueForKey:USER_ID] forKey:RUSER_ID];
             
             //save user value in defaults
             [[NSUserDefaults standardUserDefaults] setValue:[GlobalClass trimWhiteSpaceAndNewLine:_txtUserName.text] forKey:USER_NAME];
             [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:USER];
             
             VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
             rootViewController.isRegistration = YES;
             [self.navigationController pushViewController:rootViewController animated:YES];
         }
         else
         {
             [GlobalClass showTost:@"User registation fail!"];
         }
     }failure:^(NSError *error)
     {
         [GlobalClass showTost:error.localizedDescription];
     }];

    
//    ClsSetting *objClssetting=[[ClsSetting alloc] init];
//    objClssetting.PassReseposeDatadelegate = self;
//    [objClssetting calllPostWeb2:parameter url:[NSString stringWithFormat:@"%@/users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]] view:self.view];
}

//-(void)passReseposeData1:(id)str
//{
//    NSArray *value = str[@"resource"];
//    NSLog(@"%@",value);
//    NSMutableDictionary *dictUser=[value objectAtIndex:0];
//
//    
////    //save user value in defaults
////    [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:USER];
//    
////    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:USER_CONFIRMBID];
////    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:USER_EMAILVERIFIED];
////    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:USER_MOBILEVERIFIED];
//    
//    
//    VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
////    rootViewController.strEmail = [ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text];
////    rootViewController.strMobile = [ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text];
////    rootViewController.strName = [NSString stringWithFormat:@"%@ %@", _txtFirstName.text, _txtLastName];
////    rootViewController.strSMSCode = strSMSCode;
////    rootViewController.strEmialCode = strEmailCode;
//    rootViewController.isRegistration = YES;
////    rootViewController.dict = [paradict mutableCopy];
//    [self.navigationController pushViewController:rootViewController animated:YES];
//}

-(BOOL)validate
{
    if ([GlobalClass trimWhiteSpaceAndNewLine:_txtFirstName.text].length==0)
    {
        [GlobalClass showTost:@"Please enter first name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtLastName.text].length==0)
    {
        [GlobalClass showTost:@"Please enter last name"];
    return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtAddress.text].length==0)
    {
        [GlobalClass showTost:@"Please enter address"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtCity.text].length==0)
    {
        [GlobalClass showTost:@"Please enter city name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtcountry.text].length==0)
    {
        [GlobalClass showTost:@"Please enter country name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtState.text].length==0)
    {
        [GlobalClass showTost:@"Please enter state name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtZip.text].length==0)
    {
        [GlobalClass showTost:@"Please enter zip code"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtCountryCode.text].length==0)
    {
        [GlobalClass showTost:@"Please enter country code"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtMobileNumber.text].length==0)
    {
        [GlobalClass showTost:@"Please enter mobile number"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtTelephoneNumber.text].length==0)
    {
        [GlobalClass showTost:@"Please enter telephone number"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtMobileNumber.text].length<10)
    {
        [GlobalClass showTost:@"mobile number should be 10 digits long"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtEmail.text].length==0)
    {
        [GlobalClass showTost:@"Please enter email-id"];
        return NO;
    }
    else if (![GlobalClass isValidEmail:_txtEmail.text])
    {
        [GlobalClass showTost:@"Please enter valid email-id"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtUserName.text].length==0)
    {
        [GlobalClass showTost:@"Please enter user name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtPassword.text].length==0)
    {
        [GlobalClass showTost:@"Please enter password"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtPassword.text].length<6)
    {
        [GlobalClass showTost:@"password should have minimum six charter"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtConfarmPassword.text].length==0)
    {
        [GlobalClass showTost:@"Please enter confirm password"];
        return NO;
    }
    else if (![_txtPassword.text isEqualToString:_txtConfarmPassword.text])
    {
        [GlobalClass showTost:@"Password & confirm Password should be same"];
        return NO;
    }
    return YES;
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
