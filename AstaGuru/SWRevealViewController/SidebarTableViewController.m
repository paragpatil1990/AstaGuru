//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "EGOImageView.h"
#import "AboutUsViewController.h"
#import "ServicesViewController.h"
#import "ContactUsViewController.h"
#import "OurValuattionViewController.h"
#import "CareersViewController.h"
#import "PrivacyPoliceViewController.h"
#import "LoginViewController.h"
#import "CategoryListSidePageViewController.h"
#import "TermsConditionViewController.h"
#import "HowToBuyViewController.h"
#import "GetInTouchViewController.h"
//#import "LoginViewController.h"
@interface SidebarTableViewController ()
{
    UINavigationController *navController;
    UISwipeGestureRecognizer *swipeGst;
    
}
@end

@implementation SidebarTableViewController {
    NSArray *menuItems,*arrmenuItemsImages;
}
-(void)viewWillAppear:(BOOL)animated
{
[self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
    [self.tableView reloadData];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    navController = [[UINavigationController alloc] init];
    //navController.navigationBar.tintColor = [UIColor yellowColor];
    //navController.navigationBar.barTintColor = [UIColor redColor];
    
    //navController.navigationBar.tintColor = [UIColor yellowColor];
    navController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    [navController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    menuItems = @[@"About Us", @"Services", @"Categories", @"Valuation",@"How to Buy", @"How to Sell",@"Contact Us",@"Careers",@"Privacy Policy",@"Terms & Condition"];
    arrmenuItemsImages = @[@"icon-about-us", @"icon-services",@"icon-categories",@"icon-valuation",@"icon-how-to-buy", @"icon-how-to-sell", @"icon-contact-us",@"icon-careers",@"icon-privacy",@"icon-T&C"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    swipeGst = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(CloseMenu)];
    swipeGst.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:swipeGst];
    self.tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView setSeparatorColor:[UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0)
    {
        return 100;
    }
    else
    {
    return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   /* NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
    
    */
    
    if (indexPath.section==0)
    {
        static NSString* cellIdentifier = @"Profile";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *btnSignIn=(UIButton *)[cell viewWithTag:71];
        
        [btnSignIn addTarget:self action:@selector(btnSignInPressed) forControlEvents:UIControlEventTouchUpInside];
    
        
       
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
        {
            [btnSignIn setTitle:@"Sign Out" forState:UIControlStateNormal];
        }
        else
        {
            [btnSignIn setTitle:@"Sign In" forState:UIControlStateNormal];
        }
       
        cell.separatorInset = UIEdgeInsetsZero;
        return cell;
    }
    else
    {
    static NSString* cellIdentifier = @"Cell";
    
    UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell1)
    {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
   UILabel *lblUserNmae=(UILabel *)[cell1 viewWithTag:10];
  UIImageView *img=(UIImageView *)[cell1 viewWithTag:11];
        img.image=[UIImage imageNamed:[arrmenuItemsImages objectAtIndex:indexPath.row]];
        lblUserNmae.text = [menuItems objectAtIndex:indexPath.row];
    
    
    
   // cell1.backgroundColor=[UIColor colorWithRed:34/255.0 green:44/255.0 blue:59/255 alpha:1];
    
    return cell1;
        }
    
}

-(void)btnSignInPressed
{
    [[NSUserDefaults standardUserDefaults ]setObject:@"0" forKey:USER_id];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    LoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    
    [navController setViewControllers: @[rootViewController] animated: YES];
    
    [self.revealViewController setFrontViewController:navController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];

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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
   /* NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
        UINavigationController *navController = segue.destinationViewController;
        SellViewController *photoController = [navController childViewControllers].firstObject;
        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
        //photoController.photoFilename = photoFilename;
    }*/
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
     
    }
    else
    {
        if (indexPath.row==0)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AboutUsViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==1)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ServicesViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ServicesViewController"];
            
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==2)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CategoryListSidePageViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CategoryListSidePageViewController"];
            
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==3)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OurValuattionViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"OurValuattionViewController"];
            
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==4)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HowToBuyViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
            rootViewController.isHowTobuy=1;
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==5)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HowToBuyViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
           rootViewController.isHowTobuy=2;
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==6)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactUsViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
            
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==7)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CareersViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CareersViewController"];
            
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==8)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PrivacyPoliceViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"PrivacyPoliceViewController"];
            rootViewController.isPrivacyPolice=YES;
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else if (indexPath.row==9)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TermsConditionViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TermsConditionViewController"];
          
            
            [navController setViewControllers: @[rootViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navController];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
    }
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked OK
    
        
        
        if (buttonIndex == 0)
        {
           
        }
        else if (buttonIndex == 1)
        {
            //[self showVideoCamera];
           
          
            
        }
        
    
}

-(void)CloseMenu
{
    [self.revealViewController revealToggle:nil];
}
@end
