//
//  BforeLoginViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 08/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "BforeLoginViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "ViewController.h"
@interface BforeLoginViewController ()

@end

@implementation BforeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpNavigationItem];
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
    
    self.navigationItem.title=@"My AstaGuru";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
   
}
-(void)closePressed
{
    if (_isCommingFromAfterProfile==1)
    {
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [navcontroll pushViewController:objProductViewController animated:YES];
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
- (IBAction)btnSignUpPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    RegistrationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
    
    
}
- (IBAction)btnSignInPressed:(id)sender
{
   
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    LoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //rootViewController.IsCommingFromSideMenu=1;
    [self.navigationController pushViewController:rootViewController animated:YES];
}

@end
