//
//  CurrentOccutionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CurrentOccutionViewController.h"
#import "ClsSetting.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "TopStaticCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
#import "DetailProductViewController.h"
#import "ViewController.h"
#import "ArtistViewController.h"
#import "PastOccuctionViewController.h"
#import "MyAuctionGalleryViewController.h"
#import "AuctionItemBidViewController.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "AfterLoginViewController.h"
#import "BforeLoginViewController.h"
#import "BidHistoryViewController.h"
#import "FilterViewController.h"
#import "AppDelegate.h"
#import "VerificationViewController.h"
#define TRY_AN_ANIMATED_GIF 0

@interface CurrentOccutionViewController ()<PassResepose,CurrentOccution,UIGestureRecognizerDelegate,SortCurrentAuction,FilterDelegate, AuctionItemBidViewControllerDelegate>
{
    NSMutableArray *arrOccution;
    NSMutableArray *arrBottomMenu;
    NSMutableArray *arrSelectedArtistarray;

    BOOL isList;
//    BOOL isUSD;
    
    AppDelegate *objAppDelegate;

    clsCurrentOccution *objCurrentOccutionForAuctionName;
    
    MBProgressHUD *HUD;
    
    int isAuctionItemBidViewController;
    
    int cancelRefreshCurrentAuction;
    int cancelRefreshFilter;
    int cancelRefreshSearch;
    
//    NSTimer *currentTimer;
//    NSTimer *filterTimer;
//    NSTimer *searchResultTimer;
    
    clsCurrentOccution *selectedCurrentOccution;
    BOOL isRefreshBidPrice;
}
@end

@implementation CurrentOccutionViewController

-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"Current Auctions";
    
    if (_isSearch)
    {
        [self setNavigationBarBackButton];
        //self.navigationController.navigationBar.backItem.title = @"Back";
    }
    else
    {
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(-20, 0, -20, 20)];
    [btnSearch setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnSearch];
    
    UIButton *btnMyAstaGuru = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, -20)];
    [btnMyAstaGuru setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [btnMyAstaGuru addTarget:self action:@selector(myastaguru) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc]initWithCustomView:btnMyAstaGuru];
    UIBarButtonItem *spaceFix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix1.width = -12;
    UIBarButtonItem *spaceFix2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix2.width = -8;
    if (_isSearch ==1)
    {
        [self.navigationItem setRightBarButtonItems:@[spaceFix1,barButtonItem2]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItems:@[spaceFix1,barButtonItem1,spaceFix2, barButtonItem2]];
    }
}

-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
  //  [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
  //  [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
   // [_backButton setTitle:@"Back" forState:UIControlStateNormal];
   // [[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
   // [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchPressed
{
    [ClsSetting Searchpage:self.navigationController];
}

-(void)myastaguru
{
    [ClsSetting myAstaGuru:self.navigationController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    cancelRefreshCurrentAuction = 0;
    cancelRefreshFilter = 0;
    cancelRefreshSearch = 0;
    
    objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    objAppDelegate.iSelectedSortInCurrentAuction = 0;
    
    
    [self.view bringSubviewToFront:_lblNoRecords];
    _lblNoRecords.hidden = YES;
    _clvCurrentOccution.hidden = YES;
    
    arrOccution=[[NSMutableArray alloc]init];
    arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"AUCTION",@"UPCOMING",@"PAST", nil];
    
    objCurrentOccutionForAuctionName = [[clsCurrentOccution alloc]init];
    
    _isFilter = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
    
    isAuctionItemBidViewController = 0;

    self.navigationItem.title = nil;
    self.navigationItem.title = @"Current Auctions";

    if(_isSearch == NO)
    {
        [self getCurrentAuctionWithIndex:objAppDelegate.iSelectedSortInCurrentAuction];
    }
    if(_isSearch == YES)
    {
        arrOccution = _arrSearch;
        
        if (arrOccution.count==0)
        {
            _clvCurrentOccution.hidden = YES;
            _noAuction_ImageView.hidden = YES;
            _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
            _lblNoRecords.hidden = NO;
        }
        else
        {
            _clvCurrentOccution.hidden = NO;
            _noAuction_ImageView.hidden = YES;
            _lblNoRecords.hidden = YES;
            
            [UIView animateWithDuration:0 animations:^{
                [_clvCurrentOccution reloadData];
            } completion:^(BOOL finished) {
                //Do something after that...
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
                [self performSelector:@selector(refreshSearch) withObject:nil afterDelay:10.0];
            }];

        }
    }
}

-(void)getCurrentAuctionWithIndex:(int)index
{
    
    cancelRefreshCurrentAuction = 1;
    cancelRefreshFilter = 1;
    cancelRefreshSearch = 1;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];

    if (_isFilter == NO)
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSString *strFunctionName;
        if (index == 0)
        {
            strFunctionName=@"defaultlots";
        }
        else if (index == 1)
        {
            strFunctionName=@"lotslatest";
        }
        else if (index == 2)
        {
            strFunctionName=@"lotssignificant";
        }
        else if (index == 3)
        {
            strFunctionName=@"lotspopular";
        }
        else if (index == 4)
        {
            strFunctionName=@"lotsclosingtime";
        }
        
        @try
        {
            NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            NSString  *strQuery=[NSString stringWithFormat:@"%@%@?api_key=%@",[ClsSetting tableURL],strFunctionName,[ClsSetting apiKey]];
            NSString *url = strQuery;
            NSLog(@"%@",url);
            
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {

                 NSLog(@"respoance");
                 [MBProgressHUD hideHUDForView:self.view animated:YES];

                 NSError *error;
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
                 arrItemCount=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
                 for (int i=0; i<arrOccution.count; i++)
                 {
                     clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                     for (int j=0; j<arrItemCount.count; j++)
                     {
                         clsCurrentOccution *objSortResult = [arrItemCount objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objSortResult.strproductid intValue])
                         {
                             objSortResult.IsSwapOn = objacution.IsSwapOn;
                             objSortResult.strTypeOfCell = objacution.strTypeOfCell;
                             break;
                         }
                     }
                 }
                 
                 [arrOccution removeAllObjects];
                 arrOccution = arrItemCount;

                 if (arrOccution.count == 0)
                 {
                     if (objAppDelegate.iSelectedSortInCurrentAuction == 0)
                     {
                         _clvCurrentOccution.hidden = YES;
                         _lblNoRecords.hidden = YES;
                         _noAuction_ImageView.hidden = NO;
                         _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
                     }
                     else if (objAppDelegate.iSelectedSortInCurrentAuction == 4)
                     {
                         _clvCurrentOccution.hidden = NO;
                         _lblNoRecords.hidden = NO;
                         _lblNoRecords.text = @"Currently there are no closing lots in the next 30 minutes.";
                     }
                     else
                     {
                         _clvCurrentOccution.hidden = NO;
                         _lblNoRecords.hidden = NO;
                         _lblNoRecords.text = @"No records found.";
                         _noAuction_ImageView.hidden = YES;

                     }
                     [_clvCurrentOccution reloadData];
                 }
                 else
                 {
                     [UIView animateWithDuration:0 animations:^{
                         [_clvCurrentOccution reloadData];
                         if (isRefreshBidPrice == YES)
                         {
                             isRefreshBidPrice = NO;
                             if (objAppDelegate.iSelectedSortInCurrentAuction != 0)
                             {
                                 for (int i = 0; i<arrOccution.count; i++)
                                 {
                                     clsCurrentOccution *objCurrent = [arrOccution objectAtIndex:i];
                                     if ([objCurrent.strproductid intValue] == [selectedCurrentOccution.strproductid intValue])
                                     {
                                         NSIndexPath *ip = [NSIndexPath indexPathForItem:i inSection:2];
                                         if ([self indexPathIsValid:ip])
                                         {
                                             [self.clvCurrentOccution scrollToItemAtIndexPath:ip atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
                                             break;
                                         }
                                     }
                                 }
                             }
                         }
                         
                     } completion:^(BOOL finished) {
                         //Do something after that...
                         [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
                         [self performSelector:@selector(refreshCurrentAuction) withObject:nil afterDelay:10.0];
                         
                         cancelRefreshCurrentAuction = 0;
                         cancelRefreshFilter = 0;
                         cancelRefreshSearch = 0;

                     }];
                     
                     _clvCurrentOccution.hidden = NO;
                     _noAuction_ImageView.hidden = YES;
                     _lblNoRecords.hidden= YES;
                    
                 }
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                     
                     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
                     [self performSelector:@selector(refreshCurrentAuction) withObject:nil afterDelay:10.0];
                     cancelRefreshCurrentAuction = 0;
                     cancelRefreshFilter = 0;
                     cancelRefreshSearch = 0;
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                 }];
        }
        @catch (NSException *exception)
        {
        }
        @finally
        {
        }
    }
    else if(_isSearch == YES)
    {
        NSLog(@"Is Search Start");

    }
    else
    {
        NSLog(@"Is Filter Start");
        
        [self getFilterCurrentAuction];
     
    }
}

-(BOOL)indexPathIsValid:(NSIndexPath*)indexPath
{
    return indexPath.section < [_clvCurrentOccution numberOfSections] && indexPath.row < [_clvCurrentOccution numberOfItemsInSection:indexPath.section];
}

-(void)refreshCurrentAuction
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
    
    NSString *strFunctionName;
    if (objAppDelegate.iSelectedSortInCurrentAuction == 0)
    {
        strFunctionName=@"defaultlots";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction == 1)
    {
        strFunctionName=@"lotslatest";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction == 2)
    {
        strFunctionName=@"lotssignificant";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction == 3)
    {
        strFunctionName=@"lotspopular";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction == 4)
    {
        strFunctionName=@"lotsclosingtime";
    }
    
    @try
    {
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@?api_key=%@",[ClsSetting tableURL],strFunctionName,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"respoance");

//             [MBProgressHUD hideHUDForView:self.view animated:YES];

             if (cancelRefreshCurrentAuction == 0)
             {
                 
                 
                 NSError *error;
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
                 arrItemCount=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
                 
                 _isSearch = NO;
                 if (_isFilter == NO)
                 {
                    
                     for (int i=0; i<arrOccution.count; i++)
                     {
                         clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                         for (int j=0; j<arrItemCount.count; j++)
                         {
                             clsCurrentOccution *objFilterResult=[arrItemCount objectAtIndex:j];
                             if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                             {
                                 objFilterResult.IsSwapOn=objacution.IsSwapOn;
                                 objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                                 
                                 break;
                             }
                         }
                     }
                     
                     [arrOccution removeAllObjects];
                     arrOccution = arrItemCount;
                     
                     if (arrOccution.count == 0)
                     {
                         _noAuction_ImageView.hidden = YES;
                         _lblNoRecords.hidden = NO;
                         _lblNoRecords.text = @"No records found";
                         
                         if (objAppDelegate.iSelectedSortInCurrentAuction == 4)
                         {
                             _clvCurrentOccution.hidden = NO;
                             _lblNoRecords.text = @"Currently there are no closing lots in the next 30 minutes.";
                         }
                         [_clvCurrentOccution reloadData];
                     }
                     else
                     {
                         _clvCurrentOccution.hidden = NO;
                         _noAuction_ImageView.hidden = YES;
                         _lblNoRecords.hidden= YES;
                         
                         [UIView animateWithDuration:0 animations:^{
                             [_clvCurrentOccution reloadData];
                             //                         [_clvCurrentOccution reloadItemsAtIndexPaths:[_clvCurrentOccution indexPathsForVisibleItems]];
                         } completion:^(BOOL finished) {
                             //Do something after that...
                             [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
                             if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                             {
                                 if (isAuctionItemBidViewController == 0)
                                 {
                                     //exists
                                     [self performSelector:@selector(refreshCurrentAuction) withObject:nil afterDelay:10.0];
                                 }
                             }
                         }];
                     }
                     
                 }
             }
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
                 if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                 {
                    
                     if (isAuctionItemBidViewController == 0)
                     {
                         if (cancelRefreshCurrentAuction == 0)
                         {
                             //exists
                             [self performSelector:@selector(refreshCurrentAuction) withObject:nil afterDelay:10.0];
                         }
                     }                     
                 }
             }];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}

- (void)refreshSearch
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    NSLog(@"%@",_searchUrl);
    
    NSString *encoded = [_searchUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:encoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
         arrItemCount=[parese parseSortCurrentAuction:dict];

         for (int i=0; i<arrOccution.count; i++)
         {
             clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
             for (int j=0; j<arrItemCount.count; j++)
             {
                 clsCurrentOccution *objFilterResult=[arrItemCount objectAtIndex:j];
                 if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                 {
                     objFilterResult.IsSwapOn=objacution.IsSwapOn;
                     objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                     break;
                 }
             }
         }
         [arrOccution removeAllObjects];
         arrOccution = arrItemCount;
         _arrSearch = arrOccution;
         if (arrOccution.count==0)
         {
             _clvCurrentOccution.hidden = YES;
             _noAuction_ImageView.hidden = YES;
             _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
             _lblNoRecords.hidden = NO;
         }
         else
         {
             _clvCurrentOccution.hidden = NO;
             _noAuction_ImageView.hidden = YES;
             _lblNoRecords.hidden = YES;
             
             [UIView animateWithDuration:0 animations:^{
                 [_clvCurrentOccution reloadData];
             } completion:^(BOOL finished) {
                 //Do something after that...
                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
                 if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                 {
                     if (isAuctionItemBidViewController == 0)
                     {
                         //exists
                         [self performSelector:@selector(refreshSearch) withObject:nil afterDelay:10.0];
                     }
                 }
             }];
         }
         [MBProgressHUD hideHUDForView:self.view animated:YES];

     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              [ClsSetting ValidationPromt:error.localizedDescription];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
              [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
              {
                  if (isAuctionItemBidViewController == 0)
                  {
                      //exists
                      [self performSelector:@selector(refreshSearch) withObject:nil afterDelay:10.0];
                  }
              }
          }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvCurrentOccution)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2)
    {
        return UIEdgeInsetsMake(0, 8, 0, 8);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvCurrentOccution)
    {
        if (indexPath.section==0)
        {
            return   CGSizeMake(collectionView1.frame.size.width, 180);
        }
        if (indexPath.section==1 || indexPath.section == 3)
        {
            return   CGSizeMake((collectionView1.frame.size.width),20);
        }
        else
        {
            if (isList==TRUE)
            {
                return   CGSizeMake((collectionView1.frame.size.width) - 16, 155);
            }
            return   CGSizeMake((collectionView1.frame.size.width/2) - 12, 350);
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView==_clvCurrentOccution)
    {
        if (section==0)
        {
            if (_isSearch == 0)
            {
                return 1;
            }
            return 0;
        }
        else if (section == 1 || section == 3)
        {
            return 1;
        }
        else
        {
            return  arrOccution.count;
        }
    }
    else
    {
        return arrBottomMenu.count;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    TopStaticCollectionViewCell *TopStaticCell;
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
    UICollectionViewCell *cell1;
    if (collectionView==_clvCurrentOccution)
    {
        if (indexPath.section==0)
        {
            TopStaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
            if (isList==TRUE)
            {
                [TopStaticCell.btnGrid setImage:[UIImage imageNamed:@"icon-Grid-Def"] forState:UIControlStateNormal];
                [TopStaticCell.btnList setImage:[UIImage imageNamed:@"icon-list-sel"] forState:UIControlStateNormal];
                
            }
            else
            {
                [TopStaticCell.btnGrid setImage:[UIImage imageNamed:@"icon-grid"] forState:UIControlStateNormal];
                [TopStaticCell.btnList setImage:[UIImage imageNamed:@"icon-list"] forState:UIControlStateNormal];
            }
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
            {
                TopStaticCell.lblCurrency.text=@"USD";
            }
            else
            {
                TopStaticCell.lblCurrency.text=@"INR";
            }
            TopStaticCell.passSortDataDelegate=self;
            if (arrOccution.count>0)
            {
                clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:0];
                EGOImageView *imgServices = (EGOImageView *)[TopStaticCell viewWithTag:22];
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strauctionBanner]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                imgServices.imageURL=[NSURL URLWithString:spaceUrl];
            }
            cell = TopStaticCell;
        }
        else if (indexPath.section == 1 || indexPath.section == 3)
        {
            static NSString *identifier = @"blankcell";
            UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            cell = cell2;
        }
        else
        {
            
            clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexPath.row];
            objCurrentOccutionForAuctionName = [arrOccution objectAtIndex:indexPath.row];
            if (isList==FALSE)
            {
                if ([objCurrentOccution.strTypeOfCell intValue]==1)
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    NSInteger currentBid;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        currentBid = [objCurrentOccution.strpriceus integerValue];
                        CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;

                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        currentBid = [objCurrentOccution.strpricers integerValue];
                        CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                    }
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                    
                    NSInteger incresedPrice;
                    if ([objCurrentOccution.strpricers intValue] >= 10000000)
                    {
                        NSInteger incresedRate = (currentBid*5)/100;
                        incresedPrice = currentBid + incresedRate;
                    }
                    else
                    {
                        NSInteger incresedRate = (currentBid*10)/100;
                        incresedPrice = currentBid + incresedRate;
                    }
                    CurrentSelectedGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
               
                    
                    [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:indexPath.row];

                    CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                    CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                    CurrentSelectedGridCell.btnbidNow.tag=indexPath.row;
                    CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                    CurrentSelectedGridCell.btnBidHistory.tag=indexPath.row;
                    CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                    CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                    
                    CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;

                    
                    //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                    if ([objCurrentOccution.auctionType intValue] != 1)
                    {
                        UILabel *Lbl_1 = (UILabel *)[CurrentSelectedGridCell viewWithTag:1];
                        Lbl_1.text = @"Title: ";
                        UILabel *Lbl_2 = (UILabel *)[CurrentSelectedGridCell viewWithTag:2];
                        Lbl_2.text = @"Description: ";
                        UILabel *Lbl_3 = (UILabel *)[CurrentSelectedGridCell viewWithTag:3];
                        Lbl_3.text = @"";
                        
                        CurrentSelectedGridCell.lblArtistName.text=objCurrentOccution.strtitle;
                        NSString *ht = [ClsSetting getAttributedStringFormHtmlString:objCurrentOccution.strPrdescription];
                        CurrentSelectedGridCell.lblMedium.text= ht;
                        CurrentSelectedGridCell.lblYear.text= @"";
                        
                        CurrentSelectedGridCell.lbl_sizeText.text = @"";
                        CurrentSelectedGridCell.lbl_sizeText_width.constant = 0;
                        CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@",objCurrentOccution.strproductsize];

                    }
                    else
                    {
                        
                        CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                        
                        CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                        
                        CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                        CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                        CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                        //CurrentSelectedGridCell.lbl_sizeText.text = @"Size:";
                    }
//                    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                    if ([objCurrentOccution.strtimeRemains intValue] < 0)
                    {
                        CurrentSelectedGridCell.btnbidNow.enabled = NO;
                        CurrentSelectedGridCell.btnproxy.enabled = NO;
                        CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor grayColor];
                        CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor grayColor];
                        CurrentSelectedGridCell.lblCoundown.text=@"Auction Closed";
                    }
                    else
                    {
                        CurrentSelectedGridCell.btnbidNow.enabled = YES;
                        CurrentSelectedGridCell.btnproxy.enabled = YES;
                        CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor blackColor];
                        CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor blackColor];
                        
                        CurrentSelectedGridCell.lblCoundown.text=objCurrentOccution.strmyBidClosingTime;
                    }
                    
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                            CurrentSelectedGridCell.btnbidNow.hidden = YES;
                            CurrentSelectedGridCell.btnproxy.hidden = YES;
                            UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = NO;
                            if ([objCurrentOccution.strtimeRemains intValue] < 0)
                            {
                                leading_Lbl.text = @"Lot won";
                            }
                            else
                            {
                                leading_Lbl.text = @"You are currently the highest bidder.";
                            }
                        }
                        else
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                            CurrentSelectedGridCell.btnbidNow.hidden = NO;
                            CurrentSelectedGridCell.btnproxy.hidden = NO;
                            UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = YES;
                        }
                    }

                    CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    [ClsSetting SetBorder:CurrentSelectedGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                  
                    
                    cell = CurrentSelectedGridCell;
                    
                }
                else
                {
                    
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                    
                    CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
                    
                    [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    NSInteger currentBid;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        currentBid = [objCurrentOccution.strpriceus integerValue];
                        CurrentDefultGridCell.lblEstimation.text = objCurrentOccution.strestamiate;
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        currentBid = [objCurrentOccution.strpricers integerValue];
                        CurrentDefultGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                    }
                    
                    CurrentDefultGridCell.lblCurrentBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                    
                    NSInteger incresedPrice;
                    if ([objCurrentOccution.strpricers intValue] >= 10000000)
                    {
                        NSInteger incresedRate = (currentBid*5)/100;
                        incresedPrice = currentBid + incresedRate;
                    }
                    else
                    {
                        NSInteger incresedRate = (currentBid*10)/100;
                        incresedPrice = currentBid + incresedRate;
                    }
                    CurrentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
                    
                    //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                    if ([objCurrentOccution.auctionType intValue] != 1)
                    {
                        CurrentDefultGridCell.lblArtistName.text = @"";
                        CurrentDefultGridCell.btnArtist.enabled = NO;
                        CurrentDefultGridCell.btnArtist.hidden= YES;
                        CurrentDefultGridCell.lblArtistName.hidden= YES;
                    }
                    else
                    {
                        CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];

                    }
                    CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    CurrentDefultGridCell.CurrentOccutiondelegate=self;
                    CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                    CurrentDefultGridCell.btnMyGallery.tag=indexPath.row;
                    CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                    CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                    
                    CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                  
                    
                    if ([objCurrentOccution.strtimeRemains intValue] < 0)
                    {
                        CurrentDefultGridCell.lblCoundown.text=@"Auction Closed";
                    }
                    else
                    {
                        CurrentDefultGridCell.lblCoundown.text=objCurrentOccution.strmyBidClosingTime;
                    }
    
                    
                    CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    [ClsSetting SetBorder:CurrentDefultGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];

                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                        }
                        else
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                        }
                    }
                    cell = CurrentDefultGridCell;
                }
            }
            else
            {
                if ([objCurrentOccution.strTypeOfCell intValue]==1)
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelectedList" forIndexPath:indexPath];
                    
                    CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
                    
                    [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:indexPath.row];
                    
                    //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                    if ([objCurrentOccution.auctionType intValue] != 1)
                    {
                        UILabel *Lbl_1 = (UILabel *)[CurrentSelectedGridCell viewWithTag:11];
                        Lbl_1.text = @"Title: ";
                        UILabel *Lbl_2 = (UILabel *)[CurrentSelectedGridCell viewWithTag:12];
                        Lbl_2.text = @"Description:";
                        CurrentSelectedGridCell.lbl_mediumText_width.constant = 66;

                        UILabel *Lbl_3 = (UILabel *)[CurrentSelectedGridCell viewWithTag:13];
                        Lbl_3.text = @"";
                        
                        CurrentSelectedGridCell.lblArtistName.text=objCurrentOccution.strtitle;
                        NSString *ht = [ClsSetting getAttributedStringFormHtmlString:objCurrentOccution.strPrdescription];
                        CurrentSelectedGridCell.lblMedium.text= ht;
                        CurrentSelectedGridCell.lblYear.text= @"";
                        CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@",objCurrentOccution.strproductsize];
                        CurrentSelectedGridCell.lbl_sizeText.text = @"";
                        CurrentSelectedGridCell.lbl_sizeText_width.constant = 0;
                        
                    }
                    else
                    {
                            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                            CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                            CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                        
                        CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                        CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                    }

                    CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
//                    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                    if ([objCurrentOccution.strtimeRemains intValue] < 0)
                    {
                        CurrentSelectedGridCell.lblCoundown.text=@"Auction Closed";
                    }
                    else
                    {
                        CurrentSelectedGridCell.lblCoundown.text=objCurrentOccution.strmyBidClosingTime;
                    }
                
                    CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    [ClsSetting SetBorder:CurrentSelectedGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                   
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                        }
                        else
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                        }
                        
                    }
                    
                    CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                    CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                    CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                    }
                    else
                    {
                        CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                    }
                    cell = CurrentSelectedGridCell;
                    
                }
                else
                {
                    
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefultList" forIndexPath:indexPath];
                    
                    CurrentDefultGridCell.isCommingFromUpcoming = 0;
                    CurrentDefultGridCell.isCommingFromPast = 0;
                    
                    [CurrentDefultGridCell setupGesture];

                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    NSInteger currentBid;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        currentBid = [objCurrentOccution.strpriceus integerValue];
//                        CurrentDefultGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        currentBid = [objCurrentOccution.strpricers integerValue];
//                        CurrentDefultGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                    }
                    
                    CurrentDefultGridCell.lblCurrentBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                    
                    NSInteger incresedPrice;
                    if ([objCurrentOccution.strpricers intValue] >= 10000000)
                    {
                        NSInteger incresedRate = (currentBid*5)/100;
                        incresedPrice = currentBid + incresedRate;
                    }
                    else
                    {
                        NSInteger incresedRate = (currentBid*10)/100;
                        incresedPrice = currentBid + incresedRate;
                    }
                    CurrentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
                    
                    CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
                    [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                    
                    //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                    if ([objCurrentOccution.auctionType intValue] != 1)
                    {
                        CurrentDefultGridCell.btnArtist.hidden= YES;
                        CurrentDefultGridCell.lblArtistName.hidden= YES;
                    }
                    else
                    {
                        CurrentDefultGridCell.btnArtist.hidden= NO;
                        CurrentDefultGridCell.lblArtistName.hidden= NO;
                        CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];

                    }
                    
                    CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    CurrentDefultGridCell.CurrentOccutiondelegate=self;
                    CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                    CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                    CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                    CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                    CurrentDefultGridCell.btnMyGallery.tag = indexPath.row;
                    

                    if ([objCurrentOccution.strtimeRemains intValue] < 0)
                    {
                        CurrentDefultGridCell.lblCoundown.text=@"Auction Closed";
                    }
                    else
                    {
                        CurrentDefultGridCell.lblCoundown.text=objCurrentOccution.strmyBidClosingTime;
                    }
                    
                    if (objCurrentOccution.IsSwapOn == 1)
                    {
                        CurrentDefultGridCell.viwSwap.frame = CGRectMake((CurrentDefultGridCell.viwSwap.frame.size.width/4) - CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
                    else
                    {
                        CurrentDefultGridCell.viwSwap.frame = CGRectMake(0, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
               
                    
                    CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    [ClsSetting SetBorder:CurrentDefultGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                  
                    
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor =[UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1] ;
                        }
                        else
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                        }
                    }

                    cell = CurrentDefultGridCell;
                }
            }
            [ClsSetting SetBorder:cell cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];

        }
    }
    else
    {
        static NSString *identifier = @"Cell11";
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:20];
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];

        
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        lblSelectedline.hidden=YES;

        UIButton *btnLive = (UIButton *)[cell1 viewWithTag:23];
        btnLive.layer.cornerRadius = 4;
        btnLive.hidden = YES;
        
        UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
        
        if (indexPath.row == 1)
        {
            btnLive.hidden = NO;
        }
        
        if (indexPath.row==1)
        {
            
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden=NO;
        }
        else
        {
            lblTitle.textColor=[UIColor blackColor];//[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            lblline.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
            lblSelectedline.hidden=YES;
        }
        cell=cell1;
    }
    return cell;
    
    
}


-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:2];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [self.clvCurrentOccution reloadItemsAtIndexPaths: arrindexpath];
}

- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:sender.tag];

     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:2];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL],objCurrentOccution.strimage]];
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)
    [_clvCurrentOccution cellForItemAtIndexPath:indexPath];
    imageInfo.referenceRect = cell.imgProduct.frame;
    imageInfo.referenceView = cell.imgProduct.superview;
    imageInfo.referenceContentMode = cell.imgProduct.contentMode;
    imageInfo.referenceCornerRadius = cell.imgProduct.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView==_clvBottomMenu)
    {
        UINavigationController *nvc = (UINavigationController *)[self.revealViewController frontViewController];
        if (indexPath.row==0)
        {
            ViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [nvc setViewControllers: @[objViewController] animated: YES];
        }
        else if (indexPath.row==2)
        {
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.IsUpcomming = 1;
            [nvc setViewControllers: @[objPastOccuctionViewController] animated: YES];
        }
        else if (indexPath.row==3)
        {
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.IsUpcomming = 0;
            [nvc setViewControllers: @[objPastOccuctionViewController] animated: YES];
        }
        [self.revealViewController setFrontViewController:nvc];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
}

- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    ArtistViewController *objArtistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];

    objArtistViewController.objCurrentOccution1 = objCurrentOccution;
    [self.navigationController pushViewController:objArtistViewController animated:YES];
    self.navigationController.navigationBar.backItem.title = @"";
}

- (IBAction)btnListPressed:(id)sender
{
    isList=TRUE;
    [_clvCurrentOccution reloadData];
}
- (IBAction)btnGriPressed:(id)sender
{
    isList=FALSE;
    [_clvCurrentOccution reloadData];
   
}
- (IBAction)addToMyAuctionGallery:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    [self insertItemToAuctionGallery:objCurrentOccution];
    }
    else
    {
        [self goLoginVC];
    }
}

-(void)insertItemToAuctionGallery:(clsCurrentOccution*)_objCurrentOuction
{
    NSString *str;
    NSString *strUserid;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
    {
        str=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    }
    else
    {
        str=@"abhi123";
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_id] != nil)
    {
        strUserid=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    }
    else
    {
        strUserid=@"1972";
    }
    @try {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spAddToGallery(%@,%@)?api_key=%@",[ClsSetting procedureURL],_objCurrentOuction.strproductid,strUserid,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSLog(@"%@",responseStr);
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [ClsSetting ValidationPromt:@"The Lot has been added to your auction gallery."];
            [self myAuctionGallery];
             
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
-(void)passReseposeData1:(id)str
{
    [self myAuctionGallery];
}

-(void)myAuctionGallery
{
    
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    
    MyAuctionGalleryViewController *objMyAuctionGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    objMyAuctionGalleryViewController.isCurrent = 1;
    [navcontroll pushViewController:objMyAuctionGalleryViewController animated:YES];
}

- (IBAction)btnBidNowPressed:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] > 0)
    {
        clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
        objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
        selectedCurrentOccution = objCurrentOccution;
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
        {
            [self showAlertWithMessage:@"You are currently the highest bidder."];
        }
        else
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
            {
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
                {
                    isAuctionItemBidViewController = 1;
                    AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                    objAuctionItemBidViewController.delegate = self;
                    objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                    objAuctionItemBidViewController.isBidNow=TRUE;

                    objAuctionItemBidViewController.IsUpcoming = 0;
                    [self addChildViewController:objAuctionItemBidViewController];
                    [self.view addSubview:objAuctionItemBidViewController.view];
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have Bidding Access. Please contact Astaguru."  preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            else
            {
                [ClsSetting ValidationPromt:@"Your are not Verified"];
                
                NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
                NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
                NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
                VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
                rootViewController.dict=dict;
                rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
                rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
                rootViewController.strname=dict[@"t_firstname"];
                rootViewController.strSMSCode=strSMSCode;
                rootViewController.strEmialCode=strEmailCode;
                rootViewController.isRegistration = NO;
                rootViewController.IsCommingFromLoging = 0;
                [self.navigationController pushViewController:rootViewController animated:YES];
                
            }
        }
    }
    else
    {
        [self goLoginVC];
    }
}

-(void)refreshBidPrice
{
    isRefreshBidPrice = YES;
    isAuctionItemBidViewController = 0;

    if(_isSearch == NO)
    {
        [self getCurrentAuctionWithIndex:objAppDelegate.iSelectedSortInCurrentAuction];
    }
    if(_isSearch == YES)
    {
        arrOccution = _arrSearch;
        
        if (arrOccution.count==0)
        {
            _clvCurrentOccution.hidden = YES;
            _noAuction_ImageView.hidden = YES;
            _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
            _lblNoRecords.hidden = NO;
        }
        else
        {
            _clvCurrentOccution.hidden = NO;
            _noAuction_ImageView.hidden = YES;
            _lblNoRecords.hidden = YES;
            
            [UIView animateWithDuration:0 animations:^{
                [_clvCurrentOccution reloadData];
            } completion:^(BOOL finished) {
                //Do something after that...
                HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"loading";
                [self refreshSearch];
            }];
        }
    }
}

-(void)cancelAuctionItemBidViewController
{
    isAuctionItemBidViewController = 0;
    
    if(_isSearch == NO)
    {
        [self getCurrentAuctionWithIndex:objAppDelegate.iSelectedSortInCurrentAuction];
    }
    if(_isSearch == YES)
    {
       
        arrOccution = _arrSearch;
        
        if (arrOccution.count==0)
        {
            _clvCurrentOccution.hidden = YES;
            _noAuction_ImageView.hidden = YES;
            _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
            _lblNoRecords.hidden = NO;
        }
        else
        {
            _clvCurrentOccution.hidden = NO;
            _noAuction_ImageView.hidden = YES;
            _lblNoRecords.hidden = YES;
            
            [UIView animateWithDuration:0 animations:^{
                [_clvCurrentOccution reloadData];
            } completion:^(BOOL finished) {
                //Do something after that...
                HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"loading";
                [self refreshSearch];
//                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
//                [self performSelector:@selector(refreshSearch) withObject:nil afterDelay:10.0];
            }];
            
        }
    }
}

- (IBAction)btnProxyBid:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        clsCurrentOccution *objCurrentOccution = [[clsCurrentOccution alloc]init];
        objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
        {
            [self showAlertWithMessage:@"You are currently the highest bidder."];
        }
        else
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
            {
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
                {
                    isAuctionItemBidViewController = 1;
                    AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                    objAuctionItemBidViewController.delegate = self;
                    objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                    objAuctionItemBidViewController.isBidNow=FALSE;
//                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
//                    {
//                        objAuctionItemBidViewController.iscurrencyInDollar=1;
//                    }
//                    else
//                    {
//                        objAuctionItemBidViewController.iscurrencyInDollar=0;
//                    }
                    
                    [self addChildViewController:objAuctionItemBidViewController];
                    [self.view addSubview:objAuctionItemBidViewController.view];
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have Bidding Access. Please contact Astaguru."  preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            else
            {
                [ClsSetting ValidationPromt:@"Your are not Verified"];
                
                NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
                NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
                NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
                VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
                rootViewController.dict=dict;
                rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
                rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
                rootViewController.strname=dict[@"t_firstname"];
                rootViewController.strSMSCode=strSMSCode;
                rootViewController.strEmialCode=strEmailCode;
                rootViewController.isRegistration = NO;
                rootViewController.IsCommingFromLoging = 1;
                [self.navigationController pushViewController:rootViewController animated:YES];
                
            }
        }
    }
    else
    {
        [self goLoginVC];
    }
}

-(void)goLoginVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

-(void)addTapGestureOnProductimage:(UIImageView*)imgProduct indexpathrow:(NSInteger)indexpathrow
{
    imgProduct.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    imgProduct.tag=indexpathrow;
    [imgProduct addGestureRecognizer:tapGesture1];
    
}

- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    int indexpath=((int)tapGesture.view.tag);
//    NSLog(@"ind %d",indexpath);
    [self showDetailPage:indexpath];
   
}
- (IBAction)detailpageClicked:(UIButton*)sender
{
    int indexpath=((int)sender.tag);
    [self showDetailPage:indexpath];
}

-(void)showDetailPage:(int)indexpath
{
    clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexpath];
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.objCurrentOccution=objCurrentOccution;
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
//    {
//        objProductViewController.iscurrencyInDollar=1;
//    }
//    else
//    {
//        objProductViewController.iscurrencyInDollar=0;
//    }
    objProductViewController.IsCurrent = 1;
    objProductViewController.IsPast = 0;
    objProductViewController.IsUpcomming = 0;
    objProductViewController.IsArtwork = 0;
    
    [navcontroll pushViewController:objProductViewController animated:YES];

}

- (IBAction)ChangeCurrencyPressed:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUSD"];
        [_clvCurrentOccution reloadData];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
        [_clvCurrentOccution reloadData];
    }
}

-(void)ListSwipeOptionpressed:(int)option currentCellIndex:(int)index
{
    clsCurrentOccution *objCurrentOccution = [arrOccution objectAtIndex:index];
//    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];

    if (option==1)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
        
        if ([objCurrentOccution.strtimeRemains intValue] < 0)
        {
            [self showAlertWithMessage:@"This auction is closed"];
        }
        else
        {
            [self btnBidHistoryPressed:btn];
        }
    }
    else if (option==2)
    {
        [self showDetailPage:index ];
    }
    else if (option==3)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
        
        if ([objCurrentOccution.strtimeRemains intValue] < 0)
        {
            [self showAlertWithMessage:@"This auction is closed"];
        }
        else
        {
            [self btnProxyBid:btn];
        }
    }
    else if (option==4)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
        
        if ([objCurrentOccution.strtimeRemains intValue] < 0)
        {
            [self showAlertWithMessage:@"This auction is closed"];
        }
        else
        {
            [self btnBidNowPressed:btn];
        }
    }
}

-(void)showAlertWithMessage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)btnBidHistoryPressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    
    BidHistoryViewController *objBidHistoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
    objBidHistoryViewController.objCurrentOuction=objCurrentOccution;
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}

- (IBAction)btnFilterPressed:(id)sender
{
    FilterViewController *objFilterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    objFilterViewController.arrselectArtist = arrSelectedArtistarray;
    objFilterViewController.delegateFilter = self;
    objFilterViewController.selectedTab=1;
    objFilterViewController.auctionType = objCurrentOccutionForAuctionName.auctionType;
    objFilterViewController.auctionID = [objCurrentOccutionForAuctionName.strOnline intValue];
    objFilterViewController.strType = @"Current";
    [self.navigationController pushViewController:objFilterViewController animated:YES];
}

-(void)clearCancelFilter
{
    _isFilter = NO;

    [arrSelectedArtistarray removeAllObjects];
}

-(void)filter:(NSMutableArray *)arrFilterArray selectedArtistArray:(NSMutableArray *)arrSelectedArtist
{
    
    _isFilter = YES;

    [arrSelectedArtistarray removeAllObjects];
    arrSelectedArtistarray = arrSelectedArtist;
 
}

-(void)getFilterCurrentAuction
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];

    @try {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";

        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        NSMutableArray *arrSelectedArtist=arrSelectedArtistarray;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *strFunctionName;
        if (objAppDelegate.iSelectedSortInCurrentAuction==0)
        {
            strFunctionName=@"defaultlots";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==1)
        {
            strFunctionName=@"lotslatest";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==2)
        {
            strFunctionName=@"lotssignificant";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==3)
        {
            strFunctionName=@"lotspopular";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==4)
        {
            strFunctionName=@"lotsclosingtime";
        }
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@?api_key=%@&filter=",[ClsSetting tableURL],strFunctionName,[ClsSetting apiKey]];
        NSString *str = [[NSString alloc] init];
        for (int i=0; i<arrSelectedArtist.count; i++)
        {
            clsArtistInfo *objArtistInfo=[arrSelectedArtist objectAtIndex:i];
            //if ([objCurrentOccutionForAuctionName.strAuctionname isEqualToString:@"Collectibles Auction"])
            if ([objCurrentOccutionForAuctionName.auctionType intValue] != 1)
            {
                str= [str stringByAppendingString:[NSString stringWithFormat:@"(categoryid=%@)",objArtistInfo.strArtistid]];
            }
            else
            {
                str= [str stringByAppendingString:[NSString stringWithFormat:@"(artistid=%@)",objArtistInfo.strArtistid]];
            }
            
            if (arrSelectedArtist.count-1 != i)
            {
                str= [str stringByAppendingString:@"OR"];
            }
        }
        
        if (![str isEqualToString:@""])
        {
            NSString *strQuery1=[NSString stringWithFormat:@"%@%@",strQuery,str];
            NSLog(@"url:%@",strQuery1);
            
            NSString *url = strQuery1;
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 

                 NSLog(@"respoance");
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                     
                     NSError *error;
                     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                     NSMutableArray *arrFilterResult=[[NSMutableArray alloc]init];
                     arrFilterResult=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
                     
                     
                     for (int i=0; i<arrOccution.count; i++)
                     {
                         clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                         for (int j=0; j<arrFilterResult.count; j++)
                         {
                             clsCurrentOccution *objFilterResult=[arrFilterResult objectAtIndex:j];
                             if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                             {
                                 objFilterResult.IsSwapOn=objacution.IsSwapOn;
                                 objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                                 break;
                             }
                         }
                     }
                     
                     [arrOccution removeAllObjects];
                     arrOccution=arrFilterResult;
                     
                     if (arrOccution.count==0)
                     {
                         _clvCurrentOccution.hidden = NO;
                         _noAuction_ImageView.hidden = YES;
                         _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
                         _lblNoRecords.hidden= NO;
                         _lblNoRecords.text = @"No records found, please try some other filtration options.";
                         
                         if (objAppDelegate.iSelectedSortInCurrentAuction == 4)
                         {
                             _lblNoRecords.text = @"Currently there are no closing lots in the next 30 minutes.";
                         }
                         [_clvCurrentOccution reloadData];
                     }
                     else
                     {
                         _clvCurrentOccution.hidden = NO;
                         _noAuction_ImageView.hidden = YES;
                         _lblNoRecords.hidden = YES;
                         
                         [UIView animateWithDuration:0 animations:^{
                             [_clvCurrentOccution reloadData];
                         } completion:^(BOOL finished) {
                             //Do something after that...
                             [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];

                                     //exists
                                     [self performSelector:@selector(refreshFilter) withObject:nil afterDelay:10.0];
                             cancelRefreshCurrentAuction = 0;
                             cancelRefreshFilter = 0;
                             cancelRefreshSearch = 0;

                         }];
                     }
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];

                                 [self performSelector:@selector(refreshFilter) withObject:nil afterDelay:10.0];
                     cancelRefreshCurrentAuction = 0;
                     cancelRefreshFilter = 0;
                     cancelRefreshSearch = 0;

                 }];
        }
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}


-(void)refreshFilter
{

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];

    @try {
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        NSMutableArray *arrSelectedArtist=arrSelectedArtistarray;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *strFunctionName;
        if (objAppDelegate.iSelectedSortInCurrentAuction==0)
        {
            strFunctionName=@"defaultlots";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==1)
        {
            strFunctionName=@"lotslatest";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==2)
        {
            strFunctionName=@"lotssignificant";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==3)
        {
            strFunctionName=@"lotspopular";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==4)
        {
            strFunctionName=@"lotsclosingtime";
        }
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@?api_key=%@&filter=",[ClsSetting tableURL],strFunctionName,[ClsSetting apiKey]];
        NSString *str = [[NSString alloc] init];
        for (int i=0; i<arrSelectedArtist.count; i++)
        {
            
            clsArtistInfo *objArtistInfo=[arrSelectedArtist objectAtIndex:i];
                //if ([objCurrentOccutionForAuctionName.strAuctionname isEqualToString:@"Collectibles Auction"])
                if ([objCurrentOccutionForAuctionName.auctionType intValue] != 1)
                {
                    str= [str stringByAppendingString:[NSString stringWithFormat:@"(categoryid=%@)",objArtistInfo.strArtistid]];
                }
                else
                {
                    str= [str stringByAppendingString:[NSString stringWithFormat:@"(artistid=%@)",objArtistInfo.strArtistid]];
                }
                
                if (arrSelectedArtist.count-1 != i)
                {
                    str= [str stringByAppendingString:@"OR"];
                }
        }
        
        if (![str isEqualToString:@""])
        {
            NSString *strQuery1=[NSString stringWithFormat:@"%@%@",strQuery,str];
            NSLog(@"url:%@",strQuery1);
            
            NSString *url = strQuery1;
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSLog(@"respoance");

                 if (cancelRefreshFilter == 0)
                 {
                 NSError *error;
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 NSMutableArray *arrFilterResult=[[NSMutableArray alloc]init];
                 arrFilterResult=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
                 

                 for (int i=0; i<arrOccution.count; i++)
                 {
                     clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                     for (int j=0; j<arrFilterResult.count; j++)
                     {
                         clsCurrentOccution *objFilterResult=[arrFilterResult objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                         {
                             objFilterResult.IsSwapOn=objacution.IsSwapOn;
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             break;
                         }
                     }
                 }
                 
                 [arrOccution removeAllObjects];
                 arrOccution=arrFilterResult;
                 
                 if (arrOccution.count==0)
                 {
                     _clvCurrentOccution.hidden = NO;
                     _noAuction_ImageView.hidden = YES;
                     _noAuction_ImageView.image = [UIImage imageNamed:@"no_auction_logo.jpg"];
                     _lblNoRecords.hidden= NO;
                     _lblNoRecords.text = @"No records found, please try some other filtration options.";
                     
                      if (objAppDelegate.iSelectedSortInCurrentAuction == 4)
                     {
                         _lblNoRecords.text = @"Currently there are no closing lots in the next 30 minutes.";
                     }
                     [_clvCurrentOccution reloadData];
                 }
                 else
                 {
                     _clvCurrentOccution.hidden = NO;
                     _noAuction_ImageView.hidden = YES;
                     _lblNoRecords.hidden = YES;
                     
                     [UIView animateWithDuration:0 animations:^{
                         [_clvCurrentOccution reloadData];
                     } completion:^(BOOL finished) {
                         //Do something after that...
                         [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
                         if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                         {
                             if (isAuctionItemBidViewController == 0)
                             {
                                 //exists
                                 [self performSelector:@selector(refreshFilter) withObject:nil afterDelay:10.0];
                             }
                         }
                     }];
                 }
                 }
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
                     if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                     {
                         if (isAuctionItemBidViewController == 0)
                         {
                             if (cancelRefreshFilter == 0)
                             {
                             //exists
                             [self performSelector:@selector(refreshFilter) withObject:nil afterDelay:10.0];
                             }
                         }
                     }
                 }];
        }
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
        
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
}


@end
