//
//  LoginViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 07/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "RegistrationViewController.h"
#import "ViewController.h"
#import "AfterLoginViewController.h"
#import "ForGotViewController.h"
#import "VerificationViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()<PassResepose>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    self.title=@"Sign In";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
   
    
    //self.navigationItem.title=@"Sign Up";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    
    [ClsSetting SetBorder:_userName_View cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];

    [ClsSetting SetBorder:_password_View cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];

}
-(void)searchPressed
{
    
}
-(void)myastaguru
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)closePressed
{
    if (_IsCommingFromSideMenu==1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        
        [self.navigationController setViewControllers: @[rootViewController] animated: YES];
        
        [self.revealViewController setFrontViewController:self.navigationController];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
    else
    {
    [self.navigationController popViewControllerAnimated:YES];
    }
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSignInPressed:(id)sender
{
    if (_txtUserName.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Username"];
    }
    else if (_txtPassword.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Password"];
    }
    else
    {
//        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
        if (deviceToken == nil)
        {
            deviceToken = @"";
        }
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];

        NSString  *strQuery=[NSString stringWithFormat:@"%@/spUserLogin(%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text], [ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text],deviceToken,@"IOS",[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [self passReseposeData:responseObject];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];
             }];
    }
}

- (IBAction)ForgotPasswordpressed:(id)sender
{
    ForGotViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForGotViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

- (IBAction)SugnUpPressed:(id)sender
{
    RegistrationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *arr1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    if (arr1.count>0)
    {
        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
        if ([[dict valueForKey:@"password"] isEqualToString:[ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text]])
        {
            dict=[ClsSetting RemoveNullOnly:dict];
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"username"] forKey:USER_NAME];
             [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"userid"] forKey:USER_id];
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"confirmbid"] forKey:@"confirmbid"];
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"EmailVerified"] forKey:@"EmailVerified"];
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"MobileVerified"] forKey:@"MobileVerified"];

            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"user"];

            if ([dict[@"EmailVerified"] intValue] == 1 && [dict[@"MobileVerified"] intValue] == 1)
            {
                [ClsSetting ValidationPromt:@"Login Successfully"];
                if (_IsCommingFromSideMenu==1)
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                    
                    [self.navigationController setViewControllers: @[rootViewController] animated: YES];
                    
                    [self.revealViewController setFrontViewController:self.navigationController];
                    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
                }
                else
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            else
            {
                [ClsSetting ValidationPromt:@"Your are not Verified"];

                NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
                NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
                VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
                rootViewController.dict=dict;
                rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
                rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
                rootViewController.strname=dict[@"t_firstname"];
                rootViewController.strSMSCode=strSMSCode;
                rootViewController.strEmialCode=strEmailCode;
                rootViewController.isRegistration = NO;
                rootViewController.IsCommingFromLoging = 1;
                [self.navigationController pushViewController:rootViewController animated:YES];

            }
        }
        else
        {
            [ClsSetting ValidationPromt:@"Invalid Username or Password"];
        }
    }
    else
    {
        [ClsSetting ValidationPromt:@"Invalid Username or Password"];
    }
}

@end
