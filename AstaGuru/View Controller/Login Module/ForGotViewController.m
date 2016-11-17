//
//  ForGotViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ForGotViewController.h"
#import "SWRevealViewController.h"
@interface ForGotViewController ()

@end

@implementation ForGotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
     _scrScreollviw.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _viwInnerview.layer.cornerRadius = _viwInnerview.frame.size.width/2;
    _viwInnerview.clipsToBounds = YES;
    // Do any additional setup after loading the view.
}
-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    self.title=@"Forgot Password";
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
    
    [self.navigationController popViewControllerAnimated:YES];
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
