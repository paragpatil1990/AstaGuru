//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SlideMenuTableViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AboutUsViewController.h"
#import "ServicesViewController.h"
#import "CategoryViewController.h"
#import "OurValuattionViewController.h"
#import "HowToBuyViewController.h"
#import "HowToSellViewController.h"
#import "ContactUsContainerViewController.h"
#import "CareersSegmentedContainerViewController.h"
#import "PrivacyPoliceViewController.h"
#import "TermsAndConditionsViewController.h"
#import "EGOImageView.h"

@interface SlideMenuTableViewController ()
{
}

@end

@implementation SlideMenuTableViewController
{
    NSArray *menuItems,*arrmenuItemsImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuItems = @[@"Home", @"About Us", @"Services", @"Categories", @"Valuation",@"How to Buy", @"How to Sell",@"Contact Us",@"Careers",@"Privacy Policy",@"Terms & Condition"];
    arrmenuItemsImages = @[@"icon_home", @"icon-about-us", @"icon-services",@"icon-categories",@"icon-valuation",@"icon-how-to-buy", @"icon-how-to-sell", @"icon-contact-us",@"icon-careers",@"icon-privacy",@"icon-T&C"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView setSeparatorColor:[UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0)
    {
        return 1;
    }
    else
    {
    return menuItems.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 100;
    }
    else
    {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        static NSString* cellIdentifier = @"SignInCell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lblSignIN = (UILabel*)[cell viewWithTag:11];
        UIButton *btnSignIn = (UIButton *)[cell viewWithTag:22];
        
        [btnSignIn addTarget:self action:@selector(btnSignInPressed) forControlEvents:UIControlEventTouchUpInside];
        
        if ([GlobalClass isUserLogin])
        {
            lblSignIN.text = @"Sign out from My AstaGuru";
            [btnSignIn setTitle:@"Sign Out" forState:UIControlStateNormal];
        }
        else
        {
            lblSignIN.text = @"Sign in to My AstaGuru";
            [btnSignIn setTitle:@"Sign In" forState:UIControlStateNormal];
        }
        cell.separatorInset = UIEdgeInsetsZero;
        return cell;
    }
    else
    {
        static NSString* cellIdentifier = @"MenuCell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgMenu = (UIImageView *)[cell viewWithTag:11];
        UILabel *lblMenu = (UILabel *)[cell viewWithTag:22];
        
        imgMenu.image = [UIImage imageNamed:[arrmenuItemsImages objectAtIndex:indexPath.row]];
        lblMenu.text = [menuItems objectAtIndex:indexPath.row];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)btnSignInPressed
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.isCommingFromSideMenu = 1;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
    }
    else
    {
        UINavigationController *nvc;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if (indexPath.row==0)
        {
            HomeViewController *objHomeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            objHomeViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objHomeViewController];
        }
        else if (indexPath.row==1)
        {
            AboutUsViewController *objAboutUsViewController = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            objAboutUsViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objAboutUsViewController];
        }
        else if (indexPath.row==2)
        {
            ServicesViewController *objServicesViewController = [storyboard instantiateViewControllerWithIdentifier:@"ServicesViewController"];
            objServicesViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objServicesViewController];
        }
        else if (indexPath.row==3)
        {
            CategoryViewController *objCategoryViewController = [storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
            objCategoryViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objCategoryViewController];
        }
        else if (indexPath.row==4)
        {
            OurValuattionViewController *objOurValuattionViewController = [storyboard instantiateViewControllerWithIdentifier:@"OurValuattionViewController"];
            objOurValuattionViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objOurValuattionViewController];
        }
        else if (indexPath.row==5)
        {
            HowToBuyViewController *objHowToBuyViewController = [storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
            objHowToBuyViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objHowToBuyViewController];
        }
        else if (indexPath.row==6)
        {
            HowToSellViewController *objHowToSellViewController = [storyboard instantiateViewControllerWithIdentifier:@"HowToSellViewController"];
            objHowToSellViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objHowToSellViewController];
        }
        else if (indexPath.row==7)
        {
            ContactUsContainerViewController *objContactUsContainerViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContactUsContainerViewController"];
            objContactUsContainerViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objContactUsContainerViewController];
        }
        else if (indexPath.row==8)
        {
            CareersSegmentedContainerViewController *objCareersSegmentedContainerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CareersSegmentedContainerViewController"];
            objCareersSegmentedContainerViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objCareersSegmentedContainerViewController];
        }
        else if (indexPath.row==9)
        {
            PrivacyPoliceViewController *objPrivacyPoliceViewController = [storyboard instantiateViewControllerWithIdentifier:@"PrivacyPoliceViewController"];
            objPrivacyPoliceViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objPrivacyPoliceViewController];
        }
        else if (indexPath.row==10)
        {
            TermsAndConditionsViewController *objTermsAndConditionsViewController = [storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditionsViewController"];
            objTermsAndConditionsViewController.isCommingFromSideMenu = 1;
            nvc = [[UINavigationController alloc] initWithRootViewController:objTermsAndConditionsViewController];
        }
        [self.revealViewController setFrontViewController:nvc];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
}

@end
