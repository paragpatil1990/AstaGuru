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
    
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [navcontroll pushViewController:objProductViewController animated:YES];
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
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[ClsSetting TrimWhiteSpaceAndNewLine:_txtUserName.text]] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
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
 //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
    if (arr1.count>0)
    {
        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
        if ([[dict valueForKey:@"password"] isEqualToString:[ClsSetting TrimWhiteSpaceAndNewLine:_txtPassword.text]])
        {
            [ClsSetting ValidationPromt:@"Login Successfully"];
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"username"] forKey:USER_NAME];
             [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"userid"] forKey:USER_id];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            ViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            
            
            [self.navigationController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:self.navigationController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            
        }
        else
        {
            [ClsSetting ValidationPromt:@"Please Check Password"];
        }
    }
    else
    {
        [ClsSetting ValidationPromt:@"Please Check User Name"];
    }
    
}

@end
