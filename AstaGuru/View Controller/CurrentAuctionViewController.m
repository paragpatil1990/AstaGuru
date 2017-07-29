//
//  CurrentOccutionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CurrentAuctionViewController.h"
#import "CurrentAuctionTopBannerCollectionViewCell.h"
#import "FilterViewController.h"
#import "ArtistInfo.h"
#import "CurrentAuction.h"
#import "BidNowViewController.h"
#import "CurrentProxyBidViewController.h"
#define TRY_AN_ANIMATED_GIF 0

@interface CurrentAuctionViewController ()<UIGestureRecognizerDelegate, CurrentAuctionTopBannerCollectionViewCellDelegate, FilterViewControllerDelegate, BidNowViewControllerDelegate, ProxyBidViewControllerDelegate>
{
    AppDelegate *objAppDelegate;

    CurrentAuction *objCurrentOccutionForAuctionName;
    
    MBProgressHUD *HUD;
}
@end

@implementation CurrentAuctionViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"Current Auctions";
    if (self.isSearch)
    {
        [self setNavigationBarBackButton];
    }
    else
    {
        [self setNavigationBarSlideButton];
    }
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNavigationItem];
    
    objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    objAppDelegate.iSelectedSortInCurrentAuction = 0;
    
    [self.view bringSubviewToFront:_lblNoRecords];
    _lblNoRecords.hidden = YES;
    _clvCurrentAuction.hidden = YES;
    
    _isFilter = NO;
    
    [self registerNibCurrentAuctionCollectionView:self.clvCurrentAuction];

    self.selectedFilterArray = @[];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getSetAuctionData];
}

-(void)didChangeSortOptionWithIndex:(NSInteger)index
{
    [self getSetAuctionData];
}

-(void)getSetAuctionData
{
    [self.task cancel];
    self.task = nil;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
    
    if(_isSearch == NO && _isFilter == NO)
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        [self refreshCurrentAuction];
    }
    else if(_isSearch == YES)
    {
        [self setUpAndReloadAuctionDataWithArray:self.arrSearch];
    }
    else if(_isFilter == YES)
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        [self refreshFilter];
    }
    else
    {
        NSLog(@"Something roang");
    }
}

-(void)setUpAndReloadAuctionDataWithArray:(NSMutableArray*)arrParese
{
    if ([self checkArrayCount:arrParese])
    {
        NSMutableArray *arrayAuctionData = [self setUpCellValueWithArray:arrParese];
        
        self.currentAuctionArray = arrayAuctionData;
        objCurrentOccutionForAuctionName = self.currentAuctionArray[0];
        [self reloadAuctionData];
    }
}

-(BOOL)checkArrayCount:(NSMutableArray*)arrayAuctionData
{
    if(_isSearch == NO && _isFilter == NO)
    {
        if (arrayAuctionData.count == 0)
        {
            self.currentAuctionArray = nil;
            if (objAppDelegate.iSelectedSortInCurrentAuction == 0)
            {
                _clvCurrentAuction.hidden = YES;
                _lblNoRecords.hidden = YES;
                _noAuction_ImageView.hidden = NO;
            }
            else if (objAppDelegate.iSelectedSortInCurrentAuction == 4)
            {
                _clvCurrentAuction.hidden = NO;
                _lblNoRecords.hidden = NO;
                _lblNoRecords.text = @"Currently there are no closing lots in the next 30 minutes.";
                _noAuction_ImageView.hidden = YES;
            }
            else
            {
                _clvCurrentAuction.hidden = NO;
                _lblNoRecords.hidden = NO;
                _lblNoRecords.text = @"No records found.";
                _noAuction_ImageView.hidden = YES;
                
            }
            [_clvCurrentAuction reloadData];
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else if(_isSearch == YES)
    {
        if (arrayAuctionData.count==0)
        {
            self.currentAuctionArray = nil;
            _clvCurrentAuction.hidden = YES;
            _lblNoRecords.hidden = NO;
            _lblNoRecords.text = @"No records found.";
            _noAuction_ImageView.hidden = YES;
            [_clvCurrentAuction reloadData];
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else if(_isFilter == YES)
    {
        if (arrayAuctionData.count==0)
        {
            self.currentAuctionArray = nil;
            _clvCurrentAuction.hidden = NO;
            _lblNoRecords.hidden= NO;
            _lblNoRecords.text = @"No record found, please try some other filtration options.";
            _noAuction_ImageView.hidden = YES;
            [_clvCurrentAuction reloadData];
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        self.currentAuctionArray = nil;
        _clvCurrentAuction.hidden = YES;
        _lblNoRecords.hidden = NO;
        _lblNoRecords.text = @"AstaGuru.";
        _noAuction_ImageView.hidden = YES;
        [_clvCurrentAuction reloadData];
        return NO;
    }
}


-(NSMutableArray*)setUpCellValueWithArray:(NSMutableArray*)pareseArray
{
    if (self.currentAuctionArray.count == pareseArray.count)
    {
        for (int i=0; i < self.currentAuctionArray.count; i++)
        {
            CurrentAuction *objCurrentAcution = [self.currentAuctionArray objectAtIndex:i];
            for (int j=0; j<pareseArray.count; j++)
            {
                CurrentAuction *objParseAuction = [pareseArray objectAtIndex:j];
                if ([objCurrentAcution.strproductid intValue] == [objParseAuction.strproductid intValue])
                {
                    objParseAuction.isSwipOn = objCurrentAcution.isSwipOn;
                    objParseAuction.cellType = objCurrentAcution.cellType;
                    break;
                }
            }
        }
    }
    return pareseArray;
}

-(void)reloadAuctionData
{
    _clvCurrentAuction.hidden = NO;
    _lblNoRecords.hidden = YES;
    _noAuction_ImageView.hidden = YES;
    
    [UIView animateWithDuration:0 animations:^{
        [_clvCurrentAuction reloadData];
    } completion:^(BOOL finished) {
        //Do something after that...
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
        if([self.navigationController.visibleViewController isKindOfClass:[self class]])
        {
            //exists
            if(_isSearch == NO && _isFilter == NO)
            {
                [self performSelector:@selector(refreshCurrentAuction) withObject:nil afterDelay:10.0];
            }
            else if(_isSearch == YES)
            {
                [self performSelector:@selector(refreshSearch) withObject:nil afterDelay:10.0];
            }
            else if(_isFilter == YES)
            {
                [self performSelector:@selector(refreshFilter) withObject:nil afterDelay:10.0];
            }
            else
            {
                NSLog(@"Something roang");
            }
        }
    }];
}

-(NSString*)getFunctionName
{
    NSString *strFunctionName = @"";
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
    return strFunctionName;
}


-(void)refreshCurrentAuction
{
    NSString  *url = [NSString stringWithFormat:@"%@?api_key=%@", [self getFunctionName], [GlobalClass apiKey]];
    self.task = [GlobalClass call_tableGETWebURL:url parameters:nil view:nil success:^(id responseObject)
     {
         [self cancelTask];
         
         NSMutableArray *arrParese = [CurrentAuction parseAuction:responseObject[@"resource"] auctionType:AuctionTypeCurrent];
         
         [self setUpAndReloadAuctionDataWithArray:arrParese];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
     }failure:^(NSError *error)
     {
         [self cancelTask];
         
         [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
         if([self.navigationController.visibleViewController isKindOfClass:[self class]])
         {
             //exists
             [self performSelector:@selector(refreshCurrentAuction) withObject:nil afterDelay:10.0];
         }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     } callingCount:0];
}

-(void)refreshFilter
{
    
    if (self.selectedFilterArray.count > 0)
    {
        NSString *filterStr = @"";
        for (int i=0; i<self.selectedFilterArray.count; i++)
        {
            ArtistInfo *objArtistInfo = [self.selectedFilterArray objectAtIndex:i];
            if ([objCurrentOccutionForAuctionName.strAuctionname isEqualToString:@"Collectibles Auction"])
            {
                filterStr = [filterStr stringByAppendingString:[NSString stringWithFormat:@"(categoryid=%@)",objArtistInfo.strArtistid]];
            }
            else
            {
                filterStr = [filterStr stringByAppendingString:[NSString stringWithFormat:@"(artistid=%@)",objArtistInfo.strArtistid]];
            }
            
            if (i < self.selectedFilterArray.count-1)
            {
                filterStr = [filterStr stringByAppendingString:@"OR"];
            }
        }
        
        if (filterStr.length>0)
        {
            NSString  *url = [NSString stringWithFormat:@"%@?api_key=%@&filter=%@", [self getFunctionName], [GlobalClass apiKey], filterStr];
            self.task = [GlobalClass call_tableGETWebURL:url parameters:nil view:nil success:^(id responseObject)
                         {
                             [self cancelTask];

                             NSMutableArray *arrParese = [CurrentAuction parseAuction:responseObject[@"resource"] auctionType:AuctionTypeCurrent];
                             [self setUpAndReloadAuctionDataWithArray:arrParese];
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             
                         }failure:^(NSError *error)
                         {
                             [self cancelTask];
                             
                             [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
                             if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                             {
                                 //exists
                                 [self performSelector:@selector(refreshFilter) withObject:nil afterDelay:10.0];
                             }
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                         } callingCount:0];
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (void)refreshSearch
{
    self.task = [GlobalClass call_procGETWebURL:_searchUrl parameters:nil view:nil success:^(id responseObject)
            {
                [self cancelTask];
                
                NSMutableArray *arrParese = [CurrentAuction parseAuction:responseObject auctionType:AuctionTypeCurrent];
                [self setUpAndReloadAuctionDataWithArray:arrParese];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }failure:^(NSError *error)
            {
                [self cancelTask];
                
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
                if([self.navigationController.visibleViewController isKindOfClass:[self class]])
                {
                    //exists
                    [self performSelector:@selector(refreshSearch) withObject:nil afterDelay:10.0];
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];

            } callingCount:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _clvCurrentAuction)
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _clvCurrentAuction)
    {
        if (indexPath.section==0)
        {
            if (self.isSearch)
            {
                return   CGSizeMake(collectionView.frame.size.width, 140);
            }
            return   CGSizeMake(collectionView.frame.size.width, 180);
        }
        if (indexPath.section==1 || indexPath.section == 3)
        {
            return   CGSizeMake((collectionView.frame.size.width),10);
        }
        else
        {
            if (self.isList)
            {
                return   CGSizeMake((collectionView.frame.size.width) - 16, 160);
            }
            return   CGSizeMake((collectionView.frame.size.width/2) - 12, 355);
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        return CGSizeMake(width, collectionView.frame.size.height);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _clvCurrentAuction)
    {
        if (section==0)
        {
//            if (_isSearch == 0)
//            {
                return 1;
//            }
//            return 0;
        }
        else if (section == 1 || section == 3)
        {
            return 1;
        }
        else
        {
            return  self.currentAuctionArray.count;
        }
    }
    else
    {
        return [self arrBottomMenu].count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (collectionView == self.clvCurrentAuction)
    {
        if (indexPath.section==0)
        {
            CurrentAuction *objCurrentAuction = [self.currentAuctionArray objectAtIndex:0];

            if (self.isSearch)
            {
                AuctionItemTopBannerCollectionViewCell *tcell = [self configureAuctionItemTopBannerCollectionViewCell:collectionView indexPath:indexPath bannerName:@""];
                tcell.delegate = self;
                NSString *strBannerImgUrl = [objCurrentAuction.strauctionBanner stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                tcell.bannerImageView.imageURL = [NSURL URLWithString:strBannerImgUrl];
                cell = tcell;
            }
            else
            {
                CurrentAuctionTopBannerCollectionViewCell *topBannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentTopBannerCell" forIndexPath:indexPath];
                topBannerCell.delegate = self;
                
                
                if (self.isList)
                {
                    [topBannerCell.btnGrid setImage:[UIImage imageNamed:@"icon-Grid-Def"] forState:UIControlStateNormal];
                    [topBannerCell.btnList setImage:[UIImage imageNamed:@"icon-list-sel"] forState:UIControlStateNormal];
                }
                else
                {
                    [topBannerCell.btnGrid setImage:[UIImage imageNamed:@"icon-grid"] forState:UIControlStateNormal];
                    [topBannerCell.btnList setImage:[UIImage imageNamed:@"icon-list"] forState:UIControlStateNormal];
                }
                
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                {
                    topBannerCell.lblCurrency.text=@"USD";
                }
                else
                {
                    topBannerCell.lblCurrency.text=@"INR";
                }
                
                if (self.currentAuctionArray.count>0)
                {
                    NSString *bannerUrl = [[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], objCurrentAuction.strauctionBanner] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    topBannerCell.bannerImageView.imageURL = [NSURL URLWithString:bannerUrl];
                }
                
                NSArray *sortArray = [[NSArray alloc]initWithObjects:@"Lots",@"Latest",@"Significant",@"Popular",@"Closing soon",nil];
                topBannerCell.arrSort = sortArray;
                topBannerCell.clvSortBy.dataSource = topBannerCell;
                topBannerCell.clvSortBy.delegate = topBannerCell;
                
                cell = topBannerCell;
            }
        }
        else if (indexPath.section == 1 || indexPath.section == 3)
        {
            cell = [self configureBlankCell:collectionView indexPath:indexPath];
        }
        else
        {
            CurrentAuction *objCurrentAccution = [self.currentAuctionArray objectAtIndex:indexPath.row];
            if (objCurrentAccution.cellType  == 0)
            {
                cell = [self configureDefalutGridCell:collectionView indexPath:indexPath currentAuction:objCurrentAccution];
            }
            else
            {
                cell = [self configureShortInfoCell:collectionView indexPath:indexPath currentAuction:objCurrentAccution];
            }
            [GlobalClass setBorder:cell cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
        }
    }
    else
    {
        cell = [self configureBottomMenuCell:_clvBottomMenu IndexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView == self.clvBottomMenu)
    {
        [self didSelectBottomMenu:indexPath.row];
    }
}

- (IBAction)ChangeCurrencyPressed:(id)sender
{
    [self didCurrencyChanged:self.clvCurrentAuction];
}

- (IBAction)btnListPressed:(id)sender
{
    self.isList = YES;
    [_clvCurrentAuction reloadData];
}

- (IBAction)btnGriPressed:(id)sender
{
    self.isList = NO;
    [_clvCurrentAuction reloadData];
}

-(void)didBidCancel
{
    [self getSetAuctionData];
}
-(void)didBidConfirm
{
    [self getSetAuctionData];
}
-(void)didProxyBidCancel
{
    [self getSetAuctionData];
}
-(void)didProxyBidConfirm
{
    [self getSetAuctionData];
}

- (IBAction)btnFilterPressed:(UIButton*)sender
{
    [self cancelTask];
    if (self.currentAuctionArray.count > 0)
    {
        CurrentAuction *currentAuction = [self.currentAuctionArray objectAtIndex:0];
        [self showFilter:AuctionTypeCurrent auctionName:currentAuction.strAuctionname auctionID:currentAuction.strOnline delegate:self];
    }
    else
    {
        [GlobalClass showTost:@"No data to filter"];
    }
}

-(void)didCancelClearFilter
{
    _isFilter = NO;
    self.selectedFilterArray = @[];
}

-(void)didFilterWithSelectedArray:(NSArray*)selectedArray
{
    _isFilter = YES;
    self.selectedFilterArray = selectedArray;
}

-(void)cancelTask
{
    [self.task cancel];
    self.task = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self cancelTask];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshCurrentAuction) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshFilter) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshSearch) object:nil];
}

@end
