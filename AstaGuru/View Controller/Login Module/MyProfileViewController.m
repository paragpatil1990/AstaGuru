//
//  MyProfileViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 15/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()
@end

@implementation MyProfileViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"My Profile";
    
    UIBarButtonItem *cancelBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closePressed)];
    [self.navigationItem setLeftBarButtonItem:cancelBarButtonItem];
    cancelBarButtonItem.tintColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];

    UIBarButtonItem *doneBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(btnDonePressed)];
    doneBarButtonItem.tintColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    [self.navigationItem setRightBarButtonItem:doneBarButtonItem];
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
    [self setBroder];

    [self getUserProfile];
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    [GlobalClass setBorder:_fName_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_lName_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_bname_View cornerRadius:2 borderWidth:1 color:bColor];

    [GlobalClass setBorder:_baddress_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_bcity_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_bcountry_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_bstate_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_bzip_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_mobile_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_telephone_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_btelephone_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_email_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_userName_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_password_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_nikname_View cornerRadius:2 borderWidth:1 color:bColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUserProfile
{
    [self getUserProfile:^(NSDictionary *userProfile){
        _txtFirstName.text = [userProfile valueForKey:@"name"];
        _txtLastName.text = [userProfile valueForKey:@"lastname"];
        _txtBillingName.text = [userProfile valueForKey:@"name"];
        _txtBillingAddress.text = [userProfile valueForKey:@"address1"];
        _txtCity.text = [userProfile valueForKey:@"city"];
        _txtState.text = [userProfile valueForKey:@"state"];
        _txtZip.text = [userProfile valueForKey:@"zip"];
        _txtMobileNumber.text = [userProfile valueForKey:@"Mobile"];
        _txtTelephoneNumber.text = [userProfile valueForKey:@"telephone"];
        _txtBillingTelephoneNumber.text = [userProfile valueForKey:@"telephone"];
        _txtCity.text = [userProfile valueForKey:@"city"];
        _txtEmail.text = [userProfile valueForKey:@"email"];
        _txtUserName.text = [userProfile valueForKey:@"username"];
        _txtPassword.text = [userProfile valueForKey:@"password"];
        _txtNickName.text = [userProfile valueForKey:@"nickname"];
        _txtCountry.text = [userProfile valueForKey:@"country"];
    }];
}

//-(void)passReseposeData:(id)arr
//{
//    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
//    NSError *error;
//    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
//    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
//    if (arr1.count>0)
//    {
//        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
//        dict=[ClsSetting RemoveNullOnly:dict];
//      //  NSString *strname=[dict valueForKey:@"name"];
//        
//        //NSArray * arrname = [strname componentsSeparatedByString:@" "];
//       // if (arrname.count==2)
//        //{
//            _txtFirstName.text=[dict valueForKey:@"name"];
//            _txtLastName.text=[dict valueForKey:@"lastname"];
//       // }
//        //else if (arrname.count==1)
//        //{
//          //  _txtFirstName.text=[arrname objectAtIndex:0];
//        //}
//        _txtBillingName.text=[dict valueForKey:@"name"];
//        _txtBillingAddress.text=[dict valueForKey:@"address1"];
//        _txtCity.text=[dict valueForKey:@"city"];
//        _txtState.text=[dict valueForKey:@"state"];
//        _txtZip.text=[dict valueForKey:@"zip"];
//        _txtMobileNumber.text=[dict valueForKey:@"Mobile"];
//        _txtTelephoneNumber.text=[dict valueForKey:@"telephone"];
//        _txtBillingTelephoneNumber.text=[dict valueForKey:@"fax"];
//        _txtCity.text=[dict valueForKey:@"city"];
//        _txtEmail.text=[dict valueForKey:@"email"];
//        _txtUserName.text=[dict valueForKey:@"username"];
//        _txtPassword.text=[dict valueForKey:@"password"];
//        _txtNickName.text=[dict valueForKey:@"nickname"];
//        _txtCountry.text=[dict valueForKey:@"country"];
//        //_txtBillingAddress.text=@"";
//        
//    }
//    else
//    {
//        [ClsSetting ValidationPromt:@"Some thing went wrong"];
//    }
//    
//}

- (void)btnDonePressed
{
    if ([self validate])
    {
        NSDictionary *params = @{
                                 @"userid":[[NSUserDefaults standardUserDefaults] valueForKey:USER_ID],
                                 @"t_username":_txtUserName.text,
                                 @"t_password":_txtPassword.text,
                                 @"t_firstname":_txtFirstName.text,
                                 @"t_lastname":_txtLastName.text,
                                 @"t_mobile":_txtMobileNumber.text,
                                 @"t_City":_txtCity.text,
                                 @"t_State":_txtState.text,
                                 @"t_zip":_txtZip.text,
                                 @"t_telephone":_txtTelephoneNumber.text,
                                 @"t_address1":_txtBillingAddress.text,
                                 @"t_billingname":_txtBillingName.text,
                                 @"t_billingaddress":_txtBillingAddress.text,
                                 @"t_billingcity":_txtCity.text,
                                 @"t_billingstate":_txtState.text,
                                 @"t_billingcountry":_txtCountry.text,
                                 @"t_billingzip":_txtZip.text,
                                 @"t_billingtelephone":_txtBillingTelephoneNumber.text,
                                 @"admin": @"0",
                                 @"nickname":_txtNickName.text,
                                 @"t_nickname":_txtNickName.text,
                                 @"password":_txtPassword.text,
                                 @"t_password":_txtPassword.text
                                 };
        NSMutableArray *resourceArray = [NSMutableArray arrayWithObjects:params,nil];
        NSDictionary *parameters = @{@"resource": resourceArray};
        
        NSString *strUrl = [NSString stringWithFormat:@"users?api_key=%@", [GlobalClass apiKey]];
        
        [GlobalClass call_tablePUTWeb:strUrl parameters:parameters view:self.view success:^(id responseObject)
         {
             NSMutableArray *resourceArray = responseObject[@"resource"];
             NSLog(@"%@",resourceArray);
             if (resourceArray.count > 0)
             {
                 [GlobalClass showTost:@"Thank You!\nYour details will be updated soon. You might receive a verification call from our team."];
                 
//             NSDictionary *userIDDic = [resourceArray objectAtIndex:0];
             
//             [[NSUserDefaults standardUserDefaults] setValue:[userIDDic valueForKey:USER_ID] forKey:USER_ID];
             
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [GlobalClass showTost:[NSString stringWithFormat:@"Profile update fali! please try again."]];
             }
         }failure:^(NSError *error)
         {
             [GlobalClass showTost:error.localizedDescription];
         }];

        
//        ClsSetting *objClssetting=[[ClsSetting alloc] init];
//        objClssetting.PassReseposeDatadelegate=self;
//        [objClssetting calllPutWeb:pardsams url:[NSString stringWithFormat:@"%@/users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]] view:self.view];
    }
}

//-(void)passReseposeData1:(id)str
//{
//    NSArray *value = str[@"resource"];
//    NSLog(@"%@",value);
//    NSDictionary *dictUser=[value objectAtIndex:0];
//    [[NSUserDefaults standardUserDefaults] setValue:[dictUser valueForKey:@"userid"] forKey:USER_ID];
//    [ClsSetting ValidationPromt:@"Thank You!\nYour details will be updated soon. You might receive a verification call from our team."];
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(BOOL)validate
{
    if ([GlobalClass trimWhiteSpaceAndNewLine:_txtFirstName.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Enter First Name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtLastName.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Enter Last Name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtCity.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Select City Name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtCountry.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Select Country Name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtState.text].length==0)
    {
        [GlobalClass showTost:@"Pleae select State Name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtMobileNumber.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Enter Mobile Number"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtEmail.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Enter Email-id"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtUserName.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Enter User Name"];
        return NO;
    }
    else if ([GlobalClass trimWhiteSpaceAndNewLine:_txtPassword.text].length==0)
    {
        [GlobalClass showTost:@"Pleae Enter Password"];
        return NO;
    }
    else if (![_txtPassword.text isEqualToString:_txtPassword.text])
    {
        [GlobalClass showTost:@"Password & Confarm Password should be same"];
        return NO;
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
