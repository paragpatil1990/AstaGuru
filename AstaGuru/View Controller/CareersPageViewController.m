//
//  CareersPageViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 12/28/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CareersPageViewController.h"
#import "CareersViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "HowToBuyViewController.h"

@interface CareersPageViewController ()
{
    CareersViewController *startingViewController;
    HowToBuyViewController *objHowToBuyViewController;
    BOOL isApply_Now;
}
@end

@implementation CareersPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"Careers";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    
    _segmentedMenu.tintColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0];
    _segmentedMenu.layer.borderWidth = 1.0;
    _segmentedMenu.layer.cornerRadius=3.0;
    _segmentedMenu.layer.borderColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0].CGColor;
    [_segmentedMenu addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
//    self.pageViewController.dataSource = self;
    
    startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CareersViewController"];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height - 125);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title=[NSString stringWithFormat:@"Careers"];
    if (_segmentedMenu.selectedSegmentIndex == 1)
    {
        objHowToBuyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
        objHowToBuyViewController.isHowTobuy=5;
        NSArray *viewControllers = @[objHowToBuyViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

-(void)closePressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
}


- (IBAction)segmentClicked:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
//        CareersViewController *startingViewController = (CareersViewController*)[self viewControllerAtIndex:sender.selectedSegmentIndex];
//        CareersViewController *
//        if (startingViewController == nil)
//        {
            startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CareersViewController"];
//        }
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    else if (sender.selectedSegmentIndex==1)
    {
//        HowToBuyViewController *
//        if (objHowToBuyViewController == nil)
//        {
            objHowToBuyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
//        }
        objHowToBuyViewController.isHowTobuy=5;
        NSArray *viewControllers = @[objHowToBuyViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

//        HowToBuyViewController *objHowToBuyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
//        objHowToBuyViewController.isHowTobuy=5;
//        [self.navigationController pushViewController:objHowToBuyViewController animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)startWalkthrough:(id)sender {
//    CareersViewController *startingViewController = [self viewControllerAtIndex:0];
//    NSArray *viewControllers = @[startingViewController];
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
//}

//- (id)viewControllerAtIndex:(NSUInteger)index
//{
////    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
////        return nil;
////    }
//    // Create a new view controller and pass suitable data.
//    if (index == 0)
//    {
//        CareersViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CareersViewController"];
//        return pageContentViewController;
//
//    }
//    else if (index == 1)
//    {
//        HowToBuyViewController *objHowToBuyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
//        objHowToBuyViewController.isHowTobuy=5;
//        return objHowToBuyViewController;
//
//    }
//    return nil;
//
////    pageContentViewController.imageFile = self.pageImages[index];
////    pageContentViewController.titleText = self.pageTitles[index];
////    pageContentViewController.pageIndex = index;
//    
//}
//
#pragma mark - Page View Controller Data Source

//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    NSUInteger index = ((CareersViewController*) viewController).pageIndex;
//    
//    if ((index == 0) || (index == NSNotFound)) {
//        return nil;
//    }
//    
//    index--;
//    return [self viewControllerAtIndex:index];
//}
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    NSUInteger index = ((CareersViewController*) viewController).pageIndex;
//    
//    if (index == NSNotFound) {
//        return nil;
//    }
//    
//    index++;
//    if (index == [self.pageTitles count]) {
//        return nil;
//    }
//    return [self viewControllerAtIndex:index];
//}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 2;//[self.pageTitles count];
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
