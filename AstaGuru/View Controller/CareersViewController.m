//
//  CareersViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CareersViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "HowToBuyViewController.h"
@interface CareersViewController ()

@end

@implementation CareersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title=@"Careers";
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];

//    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
//    self.sideleftbarButton.tintColor=[UIColor whiteColor];
//    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
//    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
//    self.sidebarButton.tintColor=[UIColor whiteColor];
//    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    _segmentedMenu.layer.borderWidth = 1.0;
//    _segmentedMenu.layer.cornerRadius=3.0;
//    
//    _segmentedMenu.tintColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0];
//
//    _segmentedMenu.layer.borderColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0].CGColor;
//    [_segmentedMenu addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];
   /* [_segmentedMenu addTarget:self
action:@selector(action:)
forControlEvents:UIControlEventValueChanged];*/
    // Do any additional setup after loading the view.
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
    
//    _segmentedMenu.selectedSegmentIndex=0;
//    for (int i=0; i<[_segmentedMenu.subviews count]; i++)
//    {
//        UIColor *tintcolor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0];
//        if ([[_segmentedMenu.subviews objectAtIndex:i]isSelected])
//        {
//            
//            [[_segmentedMenu.subviews objectAtIndex:i] setTintColor:tintcolor];
//            
//        }
//        else
//        {
//            [[_segmentedMenu.subviews objectAtIndex:i] setTintColor:[UIColor whiteColor]];
//            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        tintcolor,NSForegroundColorAttributeName,nil];
//            [_segmentedMenu setTitleTextAttributes:attributes forState:UIControlStateNormal];
//        }
//    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentClicked:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        
    }
    else if (sender.selectedSegmentIndex==1)
    {
        HowToBuyViewController *objHowToBuyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
         objHowToBuyViewController.isHowTobuy=5;
        [self.navigationController pushViewController:objHowToBuyViewController animated:YES];
       
    }
    
}
- (void)action:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        
    }
    else if (sender.selectedSegmentIndex==1)
    {
        HowToBuyViewController *objHowToBuyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToBuyViewController"];
        objHowToBuyViewController.isHowTobuy=5;
        [self.navigationController pushViewController:objHowToBuyViewController animated:YES];
        
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

@end
