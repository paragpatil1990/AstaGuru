//
//  ViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "ClsSetting.h"
#import "EGOImageView.h"
#import "CurrentOccutionViewController.h"
#import "AppDelegate.h"
#import "BforeLoginViewController.h"
#import "AfterLoginViewController.h"
#import "PastOccuctionViewController.h"
#import "SearchViewController.h"
#import "ItemOfPastAuctionViewController.h"
#import "NotificationViewController.h"
#import "MIBadgeButton.h"

#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ViewController ()<YTPlayerViewDelegate,UISearchBarDelegate, iCarouselDelegate, iCarouselDataSource, CLLocationManagerDelegate>
{
    NSMutableArray *arrmBanner;
    NSMutableArray *arrmBanner2;
    NSMutableArray *arrmBanner3;
    NSMutableArray *arrmBanner4;
    NSMutableArray *arrmBanner5;
    NSMutableArray *arrBottomMenu;
    UIButton *btnBack;
    
    CLLocationManager *locationManager;

}
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CurrentLocationIdentifier];
    arrmBanner=[[NSMutableArray alloc]init];
    arrmBanner2=[[NSMutableArray alloc]init];
    arrmBanner3=[[NSMutableArray alloc]init];
    arrmBanner4=[[NSMutableArray alloc]init];
    arrmBanner5=[[NSMutableArray alloc]init];
    arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"AUCTION",@"UPCOMING",@"PAST", nil];
   
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    self.title=@"AstaGuru";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    btnBack = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, -20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    
    
    MIBadgeButton *btnBack1 = [[MIBadgeButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
    [btnBack1 setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [btnBack1 addTarget:self action:@selector(myastaguru) forControlEvents:UIControlEventTouchUpInside];
    [btnBack1 setBadgeBackgroundColor:[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1]];
    [btnBack1 setBadgeEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnBack1];
    UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -12;
    UIBarButtonItem *spaceFix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -8;
    [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem,spaceFix1, barButtonItem1]];
    
  
    SWRevealViewController *revealController = [self revealViewController];
    [revealController tapGestureRecognizer];
    _vwCarousel.pagingEnabled=YES;
    _vwCarousel.delegate = self;
    _vwCarousel.dataSource = self;
    
    _imgVideo.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    [_imgVideo addGestureRecognizer:tapGesture1];
    
    
    self.searchBar = [[UISearchBar alloc] init];
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;

    // Do any additional setup after loading the view, typically from a nib.
}

//------------ Current Location Address-----
-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;

//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //[locationManager requestWhenInUseAuthorization];
    //[locationManager requestAlwaysAuthorization];
//    [locationManager startUpdatingLocation];
    //------
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            [locationManager requestAlwaysAuthorization];
        } break;
        case kCLAuthorizationStatusDenied: {
            [locationManager requestAlwaysAuthorization];
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
        } break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"update");
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:
                
            case kCLErrorLocationUnknown:
                
            default:
                break;
        }
        
    } else {
        // We handle all non-CoreLocation errors here
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title =@"AstaGuru";
    
    _htVideoViews.constant=(self.view.frame.size.width/2.15);
    
//    [self needsUpdate];
    
    NSString *isNoti = [[NSUserDefaults standardUserDefaults] valueForKey:@"isNoti"];
    NSLog(@"isNoti == %@",isNoti);
    
    if ([isNoti isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isNoti"];
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
        {
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            NotificationViewController *rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
            //        rootViewController.record = @{@"NotificationBody":[[NSUserDefaults standardUserDefaults] valueForKey:@"NotificationBody"],@"NotificationID":[[NSUserDefaults standardUserDefaults] valueForKey:@"NotificationID"]};
            [self.navigationController pushViewController:rootViewController animated:YES];
        }
    }
    
    [self Getbanner];
    //[self SendEmail];
}

-(void)searchPressed
{
    [ClsSetting Searchpage:self.navigationController];
}
-(void)myastaguru
{
    [ClsSetting myAstaGuru:self.navigationController];
}
-(void)Getbanner
{
    //-------
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetHomeBanner?api_key=%@",[ClsSetting procedureURL],[ClsSetting apiKey]];
        
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSMutableArray *arrElement = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             
             [arrmBanner removeAllObjects];
             [arrmBanner2 removeAllObjects];
             [arrmBanner3 removeAllObjects];
             [arrmBanner4 removeAllObjects];
             [arrmBanner5 removeAllObjects];

             for (int i=0; i< arrElement.count; i++)
             {
                 NSDictionary *dictElement=[arrElement objectAtIndex:i];
            
                 if ([[dictElement valueForKey:@"bannerType"] intValue]==1)
                 {
                     [arrmBanner addObject:dictElement];
                 }
                 else if ([[dictElement valueForKey:@"bannerType"] intValue]==2)
                 {
                     [arrmBanner2 addObject:dictElement];
                 }
                 else if ([[dictElement valueForKey:@"bannerType"] intValue]==3)
                 {
                     [arrmBanner3 addObject:dictElement];
                 }
                 else if ([[dictElement valueForKey:@"bannerType"] intValue]==4)
                 {
                     [arrmBanner4 addObject:dictElement];
                 }
                 else if ([[dictElement valueForKey:@"bannerType"] intValue]==5)
                 {
                     [arrmBanner5 addObject:dictElement];
                 }
             }
   
             [_vwCarousel reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             [self.pgControl setNumberOfPages:[arrmBanner count]];
             [self.pgVideo setNumberOfPages:[arrmBanner5 count]];
             [self.pgControlUpcommingAuction setNumberOfPages:[arrmBanner2 count]];
             NSMutableDictionary *dictVideo=[arrmBanner5 objectAtIndex:0];
             NSString *url = [dictVideo valueForKey:@"homebannerImg"];
             // NSURL *nsUrl = [NSURL URLWithString:url];
             
             [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
             _webview.scrollView.bounces = NO;
             [_webview setMediaPlaybackRequiresUserAction:NO];
             
             [_vwCarousel reloadData];
             [_clvUpcommingAuction reloadData];
             [_clvFeaturedAuction reloadData];
             [_clsFullImage reloadData];
             [_clvVideo reloadData];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];
             }];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return arrmBanner.count;
}

// this delegate method returns banner views.
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIView *bannerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.vwCarousel.frame.size.width,self.vwCarousel.frame.size.height)];
    
    EGOImageView *imgvw = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"img-default-painting.png"]];
    
    [imgvw setFrame:bannerview.frame];
    
    //[imgvw setContentMode:UIViewContentModeScaleAspectFit];
//    UIButton *btn=[[UIButton alloc]initWithFrame:bannerview.frame];
    
    //[btn addTarget:self action:@selector(OpenBannerdUrl:) forControlEvents:UIControlEventTouchUpInside];
    
    //[btn setTag:index];
    
    //imgvw.contentMode=UIViewContentModeScaleToFill;
    
    NSDictionary *dict=[arrmBanner objectAtIndex:index];
    
    imgvw.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];
    
    //imgvw.delegate=self;
    
    [bannerview setBackgroundColor:[UIColor clearColor]];
    
    [bannerview addSubview:imgvw];
    
//    [bannerview addSubview:btn];
    
    return  bannerview;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self.pgControl setCurrentPage:[carousel currentItemIndex]];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSDictionary *dict = [ClsSetting RemoveNullOnly:[arrmBanner objectAtIndex:index]];
    clsPastAuctionData *objPastAuctionData = [[clsPastAuctionData alloc]init];
    objPastAuctionData.strAuctionname = dict[@"Auctionname"];
    objPastAuctionData.strAuctionId = dict[@"urlID"];
    objPastAuctionData.strAuctiontitle = dict[@"Auctionname"];
    if ([dict[@"auctionPageUrl"] isEqualToString:@"Current"])
    {
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
        [navcontroll setViewControllers: @[VCLikesControll] animated: YES];
        [self.revealViewController setFrontViewController:navcontroll];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
    else
    {
        ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
        objViewController.objPast = objPastAuctionData;
        objViewController.isWorkArt = NO;
        objViewController.isMyPurchase = NO;
        objViewController.isSearch = NO;
        if ([dict[@"auctionPageUrl"] isEqualToString:@"Upcomming"])
        {
            objViewController.IsUpcomming = 1;
            objViewController.IsPast = 0;
            [self.navigationController pushViewController:objViewController animated:YES];
        }
        else if ([dict[@"auctionPageUrl"] isEqualToString:@"Past"])
        {
            objViewController.IsUpcomming = 0;
            objViewController.IsPast = 1;
            [self.navigationController pushViewController:objViewController animated:YES];
        }
        self.navigationController.navigationItem.title = @"";
    }
//    else if ([dict[@"auctionPageUrl"] isEqualToString:@"Past"])
//    {
//        ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
//        objViewController.objPast=objPastAuctionData;
//        objViewController.IsUpcomming = 0;
//        objViewController.IsPast = 1;
//        objViewController.isWorkArt = 0;
//        objViewController.isMyPurchase = 0;
//        objViewController.isSearch = 0;
//        [self.navigationController pushViewController:objViewController animated:YES];
//    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_clvUpcommingAuction)
    {
        return arrmBanner2.count;
    }
    else if(collectionView==_clvFeaturedAuction)
    {
        return arrmBanner3.count;
    }
    else if (collectionView==_clsFullImage)
    {
        return arrmBanner4.count;
    }
    else if (collectionView==_clvVideo)
    {
        return arrmBanner5.count;
    }
    else
    {
        return arrBottomMenu.count;
    }
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    NSDictionary *dict;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (collectionView==_clvUpcommingAuction)
    {
        dict = [arrmBanner2 objectAtIndex:indexPath.row];
        UILabel *lblTitle = (UILabel *)[cell viewWithTag:12];
        lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"homebannerTitle"]];
        EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
        imgServices.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];

    }
    else if(collectionView==_clvFeaturedAuction)
    {
        dict = [arrmBanner3 objectAtIndex:indexPath.row];
        UILabel *lblTitle = (UILabel *)[cell viewWithTag:12];
        lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"homebannerTitle"]];
        EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
        imgServices.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];

    }
    else if (collectionView==_clsFullImage)
    {
        dict = [arrmBanner4 objectAtIndex:indexPath.row];
        UILabel *lblTitle = (UILabel *)[cell viewWithTag:12];
        lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"homebannerTitle"]];
        EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
        imgServices.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];
    }
    else if (collectionView==_clvVideo)
    {
        dict = [arrmBanner5 objectAtIndex:indexPath.row];
        _imgVideo.hidden=YES;
        
        YTPlayerView *YTPlayer = (YTPlayerView *)[cell viewWithTag:101];
        YTPlayer.delegate=self;
        NSString *strVideoId=[self extractYoutubeIdFromLink:[dict valueForKey:@"homebannerImg"]];
        NSDictionary *playerVars = @{
                                     @"controls" : @0,
                                     @"playsinline" : @0,
                                     @"autohide" : @1,
                                     @"showinfo" : @0,
                                     @"modestbranding" : @0,
                                     @"autoplay" : @0,
                                     @"loop" : @1,
                                     @"origin":@"http://www.youtube.com"
                                     };
        
        // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
        [YTPlayer loadWithVideoId:strVideoId playerVars:playerVars];
        [YTPlayer playVideo];
    }
    else if (collectionView== _clvBottomMenu)
    {
        UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        
        UILabel *lblSelectedline = (UILabel *)[cell viewWithTag:22];
        lblSelectedline.hidden=YES;

        UIButton *btnLive = (UIButton *)[cell viewWithTag:23];
        btnLive.layer.cornerRadius = 4;
        btnLive.hidden = YES;
        
        UILabel *lblline = (UILabel *)[cell viewWithTag:21];

        if (indexPath.row == 1)
        {
           btnLive.hidden = NO;
        }
        
        if (indexPath.row == 0)
        {
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden = NO;
        }
        else
        {
            lblTitle.textColor=[UIColor blackColor];
            lblline.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
            lblSelectedline.hidden=YES;
        }
    }
    else
    {
        //lblPrice.text=[]
        UIWebView *Web = (UIWebView *)[cell viewWithTag:13];
        NSString *url = [dict valueForKey:@"homebannerImg"];
        //NSURL *nsUrl = [NSURL URLWithString:url];
        Web.scalesPageToFit=true;
        [Web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        Web.scrollView.bounces = NO;
        [Web setMediaPlaybackRequiresUserAction:NO];
    }
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvUpcommingAuction)
    {
        float width=(self.view.frame.size.width);
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    else if(collectionView1==_clvFeaturedAuction)
    {
        float width=(self.view.frame.size.width/2)-7;
        return CGSizeMake(width, width);
    }
    else if(collectionView1==_clsFullImage)
    {
        float width=(self.view.frame.size.width);
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    else if(collectionView1==_clvBottomMenu)
    {
        float width=(self.view.frame.size.width/4);
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    else
    {
        float width=(self.view.frame.size.width);
        return CGSizeMake(width, width/2.15);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView==_clvBottomMenu)
    {
        UINavigationController *nvc = (UINavigationController *)[self.revealViewController frontViewController];
        if (indexPath.row==1)
        {
            CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
            [nvc setViewControllers: @[VCLikesControll] animated: YES];
        }
        else if (indexPath.row==2)
        {
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.IsUpcomming = 1;
            [nvc setViewControllers: @[objPastOccuctionViewController] animated: YES];
        }
        else if (indexPath.row == 3)
        {
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.IsUpcomming = 0;
            [nvc setViewControllers: @[objPastOccuctionViewController] animated: YES];
        }
        [self.revealViewController setFrontViewController:nvc];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
    else if (collectionView == _clsFullImage)
    {
        ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
        objViewController.IsUpcomming = 0;
        objViewController.IsPast = 0;
        objViewController.isWorkArt = YES;
        objViewController.isMyPurchase = NO;
        objViewController.isSearch = NO;
        [self.navigationController pushViewController:objViewController animated:YES];
    }
    else if(collectionView==_clvUpcommingAuction)
    {
        
        NSDictionary *dict = [ClsSetting RemoveNullOnly:[arrmBanner2 objectAtIndex:indexPath.row]];
        clsPastAuctionData *objPastAuctionData = [[clsPastAuctionData alloc]init];
        objPastAuctionData.strAuctionname = dict[@"Auctionname"];
        objPastAuctionData.strAuctionId = dict[@"urlID"];
        objPastAuctionData.strAuctiontitle = dict[@"Auctionname"];
        if ([dict[@"auctionPageUrl"] isEqualToString:@"Current"])
        {
            UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
            CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
            [navcontroll setViewControllers: @[VCLikesControll] animated: YES];
            [self.revealViewController setFrontViewController:navcontroll];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
        else
        {
            ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
            objViewController.objPast=objPastAuctionData;
            objViewController.isWorkArt = NO;
            objViewController.isMyPurchase = NO;
            objViewController.isSearch = NO;
            if ([dict[@"auctionPageUrl"] isEqualToString:@"Upcomming"])
            {
                objViewController.IsUpcomming = 1;
                objViewController.IsPast = 0;
                [self.navigationController pushViewController:objViewController animated:YES];
            }
            else if ([dict[@"auctionPageUrl"] isEqualToString:@"Past"])
            {
                objViewController.IsUpcomming = 0;
                objViewController.IsPast = 1;
                [self.navigationController pushViewController:objViewController animated:YES];
            }
        }
//        else if ([dict[@"auctionPageUrl"] isEqualToString:@"Past"])
//        {
//            ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
//            objViewController.objPast=objPastAuctionData;
//            objViewController.IsUpcomming = 0;
//            objViewController.IsPast = 1;
//            objViewController.isWorkArt = 0;
//            objViewController.isMyPurchase = 0;
//            objViewController.isSearch = 0;
//            [self.navigationController pushViewController:objViewController animated:YES];
//        }
    }
    else if (collectionView==_clvVideo)
    {
        if (arrmBanner5.count > 0)
        {
            NSMutableDictionary  *dict=[arrmBanner5 objectAtIndex:indexPath.row];
            NSString *strVideoId=[self extractYoutubeIdFromLink:[dict valueForKey:@"homebannerImg"]];
            NSDictionary *playerVars = @{
                                         @"controls" : @0,
                                         @"playsinline" : @1,
                                         @"autohide" : @1,
                                         @"showinfo" : @0,
                                         @"modestbranding" : @1,
                                         @"autoplay" : @1,
                                         @"loop" : @1,
                                         @"origin":@"http://www.youtube.com"
                                         };
            
            [_viwplayer loadWithVideoId:strVideoId playerVars:playerVars];
            [_viwplayer playVideo];
            _viwplayer.delegate=self;
        }
    }
}
- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}
- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    _imgVideo.hidden=YES;
    NSMutableDictionary  * dict;
    if (arrmBanner5.count>0)
    {
        dict=[arrmBanner5 objectAtIndex:0];
    }
  
    NSString *strVideoId=[self extractYoutubeIdFromLink:[dict valueForKey:@"homebannerImg"]];
    NSDictionary *playerVars = @{
                                 @"controls" : @0,
                                 @"playsinline" : @0,
                                 @"autohide" : @1,
                                 @"showinfo" : @0,
                                 @"modestbranding" : @0,
                                 @"autoplay" : @0,
                                 @"loop" : @1,
                                 @"origin":@"http://www.youtube.com"
                                 };
    
    // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
    [_viwplayer loadWithVideoId:strVideoId playerVars:playerVars];
    [_viwplayer playVideo];
    
    _viwplayer.delegate=self;
    
}
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state)
    {
        case kYTPlayerStatePlaying:
        {
           _imgVideo.hidden=YES;
        }
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        case kYTPlayerStateQueued:
            NSLog(@"Queued state");
            break;
        case kYTPlayerStateEnded:
            NSLog(@"End state");
            [_clvVideo reloadData];
            break;
        default:
            break;
    }
}

#pragma mark UISearchBarDelegate methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.5f animations:^{
        _searchBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = nil;
        //self.navigationItem.rightBarButtonItem = _searchBar;
        btnBack.alpha = 0.0;  // set this *after* adding it back
        [UIView animateWithDuration:0.5f animations:^ {
            btnBack.alpha = 1.0;
        }];
    }];
    
}// ca
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_clvVideo)
    {
     float currentPage = _clvVideo.contentOffset.x / _clvVideo.frame.size.width;
            _pgVideo.currentPage = currentPage;
        NSLog(@"Page Number : %ld", (long)_pgVideo.currentPage);
    }
    else if (scrollView==_clvUpcommingAuction)
    {
        float currentPage = _clvUpcommingAuction.contentOffset.x / _clvUpcommingAuction.frame.size.width;
        _pgControlUpcommingAuction.currentPage = currentPage;
    }
 }

-(void)SendEmail
{
    NSDictionary *dictTo = @{
                             @"name":[NSString stringWithFormat:@"%@",@"Parag"],
                             @"email":@"paragpatil.rane@gmail.com",
                             };
    NSArray*arrTo=[[NSArray alloc]initWithObjects:dictTo, nil];
    NSDictionary *dictMail = @{
                               @"template":@"newsletter",
                               @"to":arrTo,
                               @"subject":@"Warm Greetings from AstaGuru  Online Auction House.",//@"Astaguru Email Validation OTP",
                               @"body_text": @"Texst Astsa email",
                               @"from_name":@"AstaGuru",
                               @"from_email":@"info@infomanav.com",
                               @"reply_to_name":@"AstaGuru",
                               @"reply_to_email":@"info@infomanav.com",
                               };
    [ClsSetting sendEmailWithInfo:dictMail];
}


@end
