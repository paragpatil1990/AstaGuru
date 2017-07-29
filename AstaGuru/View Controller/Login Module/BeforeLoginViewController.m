//
//  BforeLoginViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 08/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "BeforeLoginViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
//#import "ViewController.h"
//#import "GlobalClass.h"
@interface BeforeLoginViewController ()

@end

@implementation BeforeLoginViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"My AstaGuru";
//    [self.navigationController setNavigationBarTitleTextAttribut:self.navigationController];
    
    //[self.navigationItem setHidesBackButton:YES];
    
    //[self setNavigationBarCloseButton];//Target:self selector:@selector(closePressed)];
    
    //    UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    //    closeBarButton.tintColor=[UIColor whiteColor];
    //    [self.navigationItem setRightBarButtonItem:closeBarButton];
    //
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor whiteColor],
    //       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:16]}];
}

-(void)closePressed
{
    //    if (_isCommingFromAfterProfile==1)
    //    {
    //        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //        ViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //        [navcontroll pushViewController:objProductViewController animated:YES];
    //    }
    //    else
    //    {
    [self.navigationController popViewControllerAnimated:YES];
    //    }
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    [self setUpNavigationItem];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    [self.navigationController pushViewController:rootViewController animated:YES];
}

@end
