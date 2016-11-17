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
@property (weak, nonatomic) IBOutlet CustomTextfied *txtFirstName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtLastName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtCity;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtState;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtZip;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtMobileNumber;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtTelephoneNumber;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtBillingTelephoneNumber;

@property (weak, nonatomic) IBOutlet CustomTextfied *txtEmail;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtUserName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtPassword;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtNickName;

@property (weak, nonatomic) IBOutlet CustomTextfied *txtBillingName;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtBillingAddress;


@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self GetProfile];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)GetProfile
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=userid=%@",[[NSUserDefaults standardUserDefaults] valueForKey:USER_id]] view:self.view Post:NO];
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
        NSString *strname=[dict valueForKey:@"name"];
        
        NSArray * arrname = [strname componentsSeparatedByString:@" "];
        if (arrname.count==2)
        {
            _txtFirstName.text=[arrname objectAtIndex:0];
            _txtLastName.text=[arrname objectAtIndex:1];
        }
        else if (arrname.count==1)
        {
            _txtFirstName.text=[arrname objectAtIndex:0];
        }
        _txtBillingName.text=[dict valueForKey:@"name"];
        _txtBillingAddress.text=[dict valueForKey:@"address1"];
        _txtCity.text=[dict valueForKey:@"city"];
        _txtState.text=[dict valueForKey:@"state"];
        _txtZip.text=[dict valueForKey:@"zip"];
        _txtMobileNumber.text=[dict valueForKey:@"Mobile"];
        _txtTelephoneNumber.text=[dict valueForKey:@"telephone"];
        _txtBillingTelephoneNumber.text=[dict valueForKey:@"fax"];
        _txtCity.text=[dict valueForKey:@"city"];
        _txtEmail.text=[dict valueForKey:@"email"];
        _txtUserName.text=[dict valueForKey:@"username"];
        _txtPassword.text=[dict valueForKey:@"password"];
        _txtNickName.text=[dict valueForKey:@"username"];
        //_txtBillingAddress.text=@"";
        
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
        NSLog(@"%@ %@ %@",_txtBillingAddress.text,_txtBillingName.text,_txtBillingTelephoneNumber.text);
        
        NSDictionary *params = @{@"name":[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text],
                                 @"city":_txtCity.text,
                                 @"state":_txtState.text,
                                 @"zip":_txtZip.text,
                                 @"Mobile":_txtMobileNumber.text,
                                 @"telephone":_txtTelephoneNumber.text,
                                 @"BillingTelephone":_txtBillingTelephoneNumber.text,
                                  @"BillingName":_txtBillingName.text,
                                 @"BillingAddress":_txtBillingAddress.text,
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
                                 @"t_address1":_txtBillingAddress.text,
                                 @"address1":_txtBillingAddress.text,
                                 @"t_billingaddress":_txtBillingAddress.text,
                                 
                                 
                                // @"t_email":_txtEmail.text,
                                 //@"t_mobile":_txtMobileNumber.text,
                                 @"admin": @"0",
                                 @"userid":[[NSUserDefaults standardUserDefaults] valueForKey:USER_id],
                                 };
        
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
        
        NSDictionary *pardsams = @{@"resource": arr};
        
        
        ClsSetting *objClssetting=[[ClsSetting alloc] init];
        // objClssetting.PassReseposeDatadelegate=self;
        objClssetting.PassReseposeDatadelegate=self;
        [objClssetting calllPutWeb:pardsams url:[NSString stringWithFormat:@"%@/users?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objClssetting Url]] view:self.view];
    }
    //[self calllWeb];
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
