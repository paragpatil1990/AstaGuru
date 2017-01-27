//
//  MyPurcheaseViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 12/26/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "MyPurcheaseViewController.h"
#import "ClsSetting.h"
#import "SWRevealViewController.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "AppDelegate.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "DetailProductViewController.h"
#import "AuctionItemBidViewController.h"
#import "BforeLoginViewController.h"
#import "BidHistoryViewController.h"
#import "ArtistViewController.h"

@interface MyPurcheaseViewController ()<PassResepose,CurrentOccution,UIGestureRecognizerDelegate>
{
    NSMutableArray *arrMyAuctionGallery;
    BOOL isList;
    int WebserviceCount;
//    NSTimer *timer;
}


@end

@implementation MyPurcheaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMyPurchease];
//    timer=[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(Refresh) userInfo:nil repeats:YES];
    [self setUpNavigationItem];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title=@"My Purchease";
}


-(void)getMyPurchease
{
    //USE LIMIT 10
    
    WebserviceCount=1;
    NSString *str;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
    {
        str=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"abhi123" forKey:USER_NAME];
    }
    
    
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"getMyGallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=MyuserID=%@",strUserName] view:self.view Post:NO];
    
}

-(void)getMyBidData
{
    WebserviceCount=2;
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"mygallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@&related=*",strUserName] view:self.view Post:NO];
    
}


-(void)passReseposeData1:(id)str
{
    
}

-(void)setUpNavigationItem
{
    self.navigationItem.title=@"My Purchease";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)closePressed
{
    [self.navigationController popViewControllerAnimated:YES];
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
