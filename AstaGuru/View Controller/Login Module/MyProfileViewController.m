//
//  MyProfileViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 15/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "MyProfileViewController.h"
#import "ClsSetting.h"
@interface MyProfileViewController ()<PassResepose>
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtTelephoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingTelephoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNickName;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingName;
@property (weak, nonatomic) IBOutlet UITextField *txtBillingAddress;

@end

@implementation MyProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self GetProfile];
    [self setBroder];
    // Do any additional setup after loading the view.
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    [ClsSetting SetBorder:_fName_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_lName_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_bname_View cornerRadius:2 borderWidth:1 color:bColor];

    [ClsSetting SetBorder:_baddress_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_bcity_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_bcountry_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_bstate_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_bzip_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_mobile_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_telephone_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_btelephone_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_email_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_userName_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_password_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_nikname_View cornerRadius:2 borderWidth:1 color:bColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetProfile
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=%@&filter=userid=%@",[ClsSetting apiKey],[[NSUserDefaults standardUserDefaults] valueForKey:USER_id]] view:self.view Post:NO];
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
        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
        dict=[ClsSetting RemoveNullOnly:dict];
      
        _txtFirstName.text=[dict valueForKey:@"name"];
        _txtLastName.text=[dict valueForKey:@"lastname"];
        _txtMobileNumber.text=[dict valueForKey:@"Mobile"];
        _txtTelephoneNumber.text=[dict valueForKey:@"telephone"];
        _txtEmail.text=[dict valueForKey:@"email"];

        _txtBillingName.text=[dict valueForKey:@"BillingName"];
        _txtBillingAddress.text=[dict valueForKey:@"BillingAddress"];
        _txtCity.text=[dict valueForKey:@"BillingCity"];
        _txtCountry.text=[dict valueForKey:@"BillingCountry"];
        _txtState.text=[dict valueForKey:@"BillingState"];
        _txtZip.text=[dict valueForKey:@"BillingZip"];
        _txtBillingTelephoneNumber.text=[dict valueForKey:@"BillingTelephone"];
        
        _txtUserName.text=[dict valueForKey:@"username"];
        _txtPassword.text=[dict valueForKey:@"password"];
        _txtNickName.text=[dict valueForKey:@"nickname"];
    }
    else
    {
        [ClsSetting ValidationPromt:@"Some thing went wrong"];
    }
}

-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    self.title=@"My Profile";
     self.sidebarButton=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.sidebarButton.tintColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(btnProccedPressed)];
    self.sideleftbarButton.tintColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}
- (void)btnProccedPressed
{
    if ([self validate])
    {
        NSDictionary *params = @{
                                 @"userid":[[NSUserDefaults standardUserDefaults] valueForKey:USER_id],
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
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
        NSDictionary *pardsams = @{@"resource": arr};
        ClsSetting *objClssetting=[[ClsSetting alloc] init];
        objClssetting.PassReseposeDatadelegate=self;
        [objClssetting calllPutWeb:pardsams url:[NSString stringWithFormat:@"%@/users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]] view:self.view];
    }
}
-(void)closePressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)passReseposeData1:(id)str
{
    NSArray *value = str[@"resource"];
    NSLog(@"%@",value);
    NSDictionary *dictUser=[value objectAtIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:[dictUser valueForKey:@"userid"] forKey:USER_id];
    [ClsSetting ValidationPromt:@"Thank You!\nYour details will be updated soon. You might receive a verification call from our team."];
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)validate
{
    if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtFirstName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter First Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtLastName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter Last Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtCity.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Select City Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtCountry.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Select Country Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtState.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae select State Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtMobileNumber.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter Mobile Number"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter Email-id"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter User Name"];
        return NO;
    }
    else if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Pleae Enter Password"];
        return NO;
    }
    else if (![_txtPassword.text isEqualToString:_txtPassword.text])
    {
        [ClsSetting ValidationPromt:@"Password & Confarm Password should be same"];
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
