//
//  ServicesViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ServicesViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
@interface ServicesViewController ()

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopNavigation"]];
    //[self.navigationItem setTitleView:titleView];
    self.navigationItem.title=@"Services";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   // [self.txtServices setContentOffset:CGPointZero animated:NO];
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews
{
    CGPoint bottomOffset = CGPointMake(0, -60);
    [self.txtServices setContentOffset:bottomOffset animated:NO];
}

-(void)closePressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
}
- (void)didReceiveMemoryWarning {
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

@end
