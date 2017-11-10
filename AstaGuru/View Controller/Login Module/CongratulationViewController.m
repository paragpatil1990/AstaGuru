//
//  CongratulationViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CongratulationViewController.h"
#import "CurrentOccutionViewController.h"
#import "ClsSetting.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
@interface CongratulationViewController ()

@end

@implementation CongratulationViewController
@synthesize dict;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self SendEmail];
    // Do any additional setup after loading the view.
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
    
    self.navigationItem.title=@"Complete Sign Up";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    
}

- (IBAction)btnProccedPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CurrentOccutionViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}
-(void)closePressed
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
}

-(void)viewWillAppear:(BOOL)animated
{
    _btnViewconnentAuctions .layer.cornerRadius=2;
}

-(void)SendEmail
{
//    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];

    NSDictionary *dictTo = @{
                             @"name":[NSString stringWithFormat:@"%@",_strname],
                             @"email":_strEmail,
                             };
    
    NSArray*arrTo=[[NSArray alloc]initWithObjects:dictTo, nil];
    // NSDictionary *dictMail=[[NSDictionary alloc]init];
    NSDictionary *dictMail = @{
                               @"template":@"newsletter",
                               @"to":arrTo,
                               @"subject":@"Your Registration with Astaguru.com is confirmed & complete.",
                               @"body_text": [NSString stringWithFormat:@"Dear %@,\nThank you for the information provided. Your account security is of paramount importance to us. Therefore we will have one of our representative call you on the number provided within the next 24 hours to verify the following details. Further to which we will provide you with bidding access for our auctions.\nIn case you would like to edit any details, please notify our representative during the course of your conversation.\n\nName: %@\nLastName: %@\nAddress: %@\nCity: %@\nZip: %@\nSate: %@\nCountry: %@\nTelephone: %@\nFax: %@\nEmail: %@\nUsername: %@\nPassword: %@\nFor any further assistance please feel free to write to us at, contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you.\nThanking You,\n\nWarm Regards,\nTeam AstaGuru\n",_strname,dict[@"name"], dict[@"lastname"], dict[@"address1"], dict[@"city"], dict[@"zip"], dict[@"state"], dict[@"country"], dict[@"telephone"], dict[@"fax"], dict[@"email"], dict[@"username"], dict[@"password"]],
                               @"from_name":@"AstaGuru",
                               @"from_email":@"info@infomanav.com",
                               @"reply_to_name":@"AstaGuru",
                               @"reply_to_email":@"info@infomanav.com",
                               };
    [ClsSetting sendEmailWithInfo:dictMail];
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
