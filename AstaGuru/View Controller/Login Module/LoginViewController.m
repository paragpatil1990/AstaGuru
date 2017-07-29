//
//  LoginViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 07/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "HomeViewController.h"
#import "AfterLoginViewController.h"
#import "ForGotViewController.h"
#import "VerificationViewController.h"
//#import "GlobalClass.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)setUpNavigationItem
{
    self.title = @"Sign In";
    
    [self.navigationItem setHidesBackButton:YES];
    
   // [self setNavigationBarCloseButton];//Target:self selector:@selector(closePressed)];
    
    //    UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    //    closeBarButton.tintColor=[UIColor whiteColor];
    //    [self.navigationItem setRightBarButtonItem:closeBarButton];
    
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor whiteColor],
    //       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:16]}];
    
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    [self setUpNavigationItem];
    [GlobalClass setBorder:_userName_View cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];
    
    [GlobalClass setBorder:_password_View cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [GlobalClass showTost:@"Please enter your username"];
    }
    else if (_txtPassword.text.length == 0)
    {
        [GlobalClass showTost:@"Please enter your password"];
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate registerForRemoteNotification];

        NSString *deviceToken = deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICETOKEN];
        if(deviceToken == nil)
        {
            deviceToken = @"";
        }

        NSString *strurl = [NSString stringWithFormat:@"spUserLogin(%@,%@,%@,%@)", [GlobalClass trimWhiteSpaceAndNewLine:_txtUserName.text], [GlobalClass trimWhiteSpaceAndNewLine:_txtPassword.text], deviceToken,@"IOS"];

        [GlobalClass call_procGETWebURL:strurl parameters:nil view:self.view success:^(id responseObject){
            if ([responseObject isKindOfClass:[NSArray class]])
            {
                NSArray *userArray = responseObject;
                if (userArray.count > 0)
                {
                    NSDictionary *userDic = [GlobalClass removeNullOnly:[userArray objectAtIndex:0]];
                    if ([[GlobalClass trimWhiteSpaceAndNewLine:[userDic valueForKey:@"password"]] isEqualToString:[GlobalClass trimWhiteSpaceAndNewLine:_txtPassword.text]])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:USER];
                        [[NSUserDefaults standardUserDefaults] setValue:userDic[USER_NAME] forKey:USER_NAME];
                        [[NSUserDefaults standardUserDefaults] setValue:userDic[USER_ID] forKey:USER_ID];
                        
                        if ([GlobalClass isUserVerified])
                        {
                            [GlobalClass showTost:@"Login Successfully"];
                            if (self.isCommingFromSideMenu == 1)
                            {
                                [self showHomeViewController];
                            }
                            else
                            {
                                [self.navigationController popToRootViewControllerAnimated:YES];
                            }
                        }
                        else
                        {
                            [GlobalClass showTost:@"Your are not verified"];
                            VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
                            rootViewController.isRegistration = NO;
                            [self.navigationController pushViewController:rootViewController animated:YES];
                        }
                    }
                    else
                    {
                        [GlobalClass showTost:@"Please Check Password"];
                    }
                }
                else
                {
                    [GlobalClass showTost:@"Please Check Username"];
                }
            }
            else
            {
                [GlobalClass showTost:@"Please try again!"];
            }
        } failure:^(NSError *error){
            [GlobalClass showTost:error.localizedDescription];
        } callingCount:0];
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

//-(void)passReseposeData:(id)arr
//{
//    NSError *error;
//    NSMutableArray *arr1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
//    if (arr1.count>0)
//    {
//        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
//        if ([[dict valueForKey:@"password"] isEqualToString:[ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text]])
//        {
//            dict = [ClsSetting RemoveNullOnly:dict];
//            
//            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"username"] forKey:USER_NAME];
//            
//            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"userid"] forKey:USER_ID];
//            
////            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"confirmbid"] forKey:@"confirmbid"];
////            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"EmailVerified"] forKey:@"EmailVerified"];
////            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"MobileVerified"] forKey:@"MobileVerified"];
//
//            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:USER];
//
//            if ([ClsSetting isUserVerified])
//            {
//                [ClsSetting ValidationPromt:@"Login Successfully"];
//                if (_IsCommingFromSideMenu == 1)
//                {
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    ViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//                    
//                    [self.navigationController setViewControllers: @[rootViewController] animated: YES];
//                    
//                    [self.revealViewController setFrontViewController:self.navigationController];
//                    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
//                }
//                else
//                {
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }
//            }
//            else
//            {
//                [ClsSetting ValidationPromt:@"Your are not Verified"];
//
////                NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
////                NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
//                VerificationViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
////                rootViewController.dict=dict;
////                rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
////                rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
////                rootViewController.strName = dict[@"t_firstname"];
////                rootViewController.strSMSCode=strSMSCode;
////                rootViewController.strEmialCode=strEmailCode;
//                rootViewController.isRegistration = NO;
////                rootViewController.IsCommingFromLoging = 1;
//                [self.navigationController pushViewController:rootViewController animated:YES];
//            }
//        }
//        else
//        {
//            [ClsSetting ValidationPromt:@"Please Check Password"];
//        }
//    }
//    else
//    {
//        [ClsSetting ValidationPromt:@"Please Check User Name"];
//    }
//}

@end
