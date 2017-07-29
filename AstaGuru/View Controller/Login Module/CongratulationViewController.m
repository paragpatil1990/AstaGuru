//
//  CongratulationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CongratulationViewController.h"
#import "CurrentAuctionViewController.h"
//#import "GlobalClass.h"
//#import "SWRevealViewController.h"
//#import "AppDelegate.h"
@interface CongratulationViewController ()

@end

@implementation CongratulationViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"Complete Sign Up";

    self.navigationItem.leftBarButtonItem = nil;

    [self.navigationItem setHidesBackButton:YES];

    [self setNavigationBarCloseButton];
}

-(void)closePressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = rootViewController;
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self sendEmail];
    self.isCommingFromSideMenu = YES;
    [GlobalClass setBorder:_btnViewCurrentAuctions cornerRadius:2 borderWidth:1 color:[UIColor clearColor]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnViewCurrentAuctionPressed:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CurrentAuctionViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentAuctionViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

-(void)sendEmail
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"loading";
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] valueForKey:USER];
    NSString *strName = [GlobalClass getUserFullName];
    NSString *strEmail = [userDic valueForKey:USER_EMAIL];
    
    NSDictionary *dictMailParameters = @{
                               @"to":@[@{
                                           @"name":strName,
                                           @"email":strEmail,
                                           }],
                               @"subject":@"Your Registration with Astaguru.com is confirmed & complete.",
                               @"body_text": [NSString stringWithFormat:@"Dear %@,\nThank you for the information provided. Your account security is of paramount importance to us. Therefore we will have one of our representative call you on the number provided within the next 24 hours to verify the following details. Further to which we will provide you with bidding access for our auctions.\nIn case you would like to edit any details, please notify our representative during the course of your conversation.\n\nName: %@\nLastName: %@\nAddress: %@\nCity: %@\nZip: %@\nSate: %@\nCountry: %@\nTelephone: %@\nFax: %@\nEmail: %@\nUsername: %@\nPassword: %@\n\nFor any further assistance please feel free to write to us at, contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you.\nThanking You,\n\nWarm Regards,\nTeam AstaGuru\n",strName, userDic[@"name"], userDic[@"lastname"], userDic[@"address1"], userDic[@"city"], userDic[@"zip"], userDic[@"state"], userDic[@"country"], userDic[@"telephone"], userDic[@"fax"], userDic[@"email"], userDic[@"username"], userDic[@"password"]],
                               };
    
    [GlobalClass sendEmail:dictMailParameters success:^(NSDictionary *responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }failure:^(NSError *error)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];

//    [ClsSetting sendEmailWithInfo:dictMail];
}

@end
