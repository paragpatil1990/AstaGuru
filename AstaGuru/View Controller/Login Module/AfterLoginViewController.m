//
//  AfterLoginViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 15/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AfterLoginViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "BforeLoginViewController.h"
#import "RegistrationViewController.h"
#import "MyProfileViewController.h"
#import "ClsSetting.h"
#import "MyAuctionGalleryViewController.h"
@interface AfterLoginViewController ()

@end

@implementation AfterLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
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
    
    /*UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [navcontroll pushViewController:objProductViewController animated:YES];*/
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnMyProfilePressed:(id)sender
{
    MyProfileViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

- (IBAction)btnSignOut:(id)sender
{
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    //[[NSUserDefaults standardUserDefaults ] setObject:@"0" forKey:USER_id];
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict)
    {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    BforeLoginViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
    rootViewController.isCommingFromAfterProfile=1;
    [self.navigationController pushViewController:rootViewController animated:YES];
}
- (IBAction)MyAuctionGalleryPressed:(id)sender
{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyAuctionGalleryViewController *rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
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
