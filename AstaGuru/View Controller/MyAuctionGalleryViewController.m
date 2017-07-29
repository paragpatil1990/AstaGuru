//
//  MyAuctionGalleryViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 27/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "MyAuctionGalleryViewController.h"
#import "BidNowViewController.h"
#import "CurrentProxyBidViewController.h"
#import "UpcommingProxyBidViewController.h"

@interface MyAuctionGalleryViewController ()<UIGestureRecognizerDelegate, BidNowViewControllerDelegate, ProxyBidViewControllerDelegate, UpcommingProxyBidViewControllerDelegate>
{
    NSArray *arrMyAuctionGallary;
    NSArray *arrGallaryItem;
    
    NSTimer *timer; // timer to refresh current auction data after 10 sec.
}
@end

@implementation MyAuctionGalleryViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"My Auction Gallery";
    [self setNavigationBarBackButton];
    //[self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    
    [self registerNibCurrentAuctionCollectionView:self.clvMyAuctionGallary];
    [self registerNibUpcomingAuctionItemCollectionView:self.clvMyAuctionGallary];
    
    self.isMyAuctionGallary = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"loading";
    [self getMyAuctionGallery];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.task cancel];
    self.task = nil;
    [timer invalidate];
    timer = nil;
}

-(void)getMyAuctionGallery
{
    NSString  *strUrl=[NSString stringWithFormat:@"getMyGallery?api_key=%@&filter=(userid=%@)",[GlobalClass apiKey], [GlobalClass getUserID]];
    self.task = [GlobalClass call_tableGETWebURL:strUrl parameters:nil view:nil success:^(id responseObject)
                 {
                     arrGallaryItem = responseObject[@"resource"];
                     [self reloadData:arrGallaryItem];
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                 } failure:^(NSError *error){[MBProgressHUD hideHUDForView:self.view animated:YES];} callingCount:0];
}

-(void)reloadData:(NSArray*)auctionArray
{
    if (self.auctionType == AuctionTypeCurrent)
    {
        arrMyAuctionGallary = [self getCurrentAuctionArray:auctionArray];
        if (timer == nil)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(getMyAuctionGallery) userInfo:nil repeats:YES];
        }
    }
    else
    {
        arrMyAuctionGallary = [self getUpcomingAuctionArray:auctionArray];
    }
    if (arrMyAuctionGallary.count == 0)
    {
        _lblNoRecords.hidden = NO;
        if (self.auctionType == AuctionTypeCurrent)
        {
            _lblNoRecords.text = @"You haven’t added anything to the Current Auction gallery.";
        }
        else
        {
            _lblNoRecords.text = @"You haven’t added anything to the Upcoming Auction gallery.";
        }
        [self.view bringSubviewToFront:_lblNoRecords];
        _clvMyAuctionGallary.hidden=NO;
        [timer invalidate];
        timer = nil;
    }
    else
    {
        _lblNoRecords.hidden = YES;
        _clvMyAuctionGallary.hidden=NO;
    }
    [_clvMyAuctionGallary reloadData];
}

-(NSArray*)getCurrentAuctionArray:(NSArray*)auctionArray
{
    NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
    for (int i=0; i<auctionArray.count ; i++)
    {
        NSDictionary *objAuction = [GlobalClass removeNullOnly:[auctionArray objectAtIndex:i]];
        
        if ([objAuction[@"status"] isEqualToString:@"Current"])
        {
            [arrCurrentAuction addObject:objAuction];
        }
    }
    NSArray *parseArray = [CurrentAuction parseAuction:arrCurrentAuction auctionType:AuctionTypeCurrent];
    
    return parseArray;
}

-(NSArray*)getUpcomingAuctionArray:(NSArray*)auctionArray
{
    NSMutableArray *arrUpcommingAuction = [[NSMutableArray alloc]init];
    for (int i=0; i<auctionArray.count ; i++)
    {
        NSDictionary *objAuction = [GlobalClass removeNullOnly:[auctionArray objectAtIndex:i]];
        
        if ([objAuction[@"status"] isEqualToString:@"Upcomming"])
        {
            [arrUpcommingAuction addObject:objAuction];
        }
    }
    NSArray *parseArray = [CurrentAuction parseAuction:arrUpcommingAuction auctionType:AuctionTypeUpcoming];
    return parseArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == self.clvMyAuctionGallary)
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
    if (collectionView == self.clvMyAuctionGallary)
    {
        if (indexPath.section==0)
        {
            CGFloat dHeight = 8+35+10+30+2+1;
            return   CGSizeMake(collectionView.frame.size.width, dHeight);
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
            else if (self.auctionType == AuctionTypeUpcoming)
            {
                return   CGSizeMake((collectionView.frame.size.width/2) - 12, 290);
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
    if (collectionView == self.clvMyAuctionGallary)
    {
        if (section==0)
        {
//            if (arrMyAuctionGallary.count > 0)
//            {
//                return 1;
//            }
            return 1;
        }
        else if (section == 1 || section == 3)
        {
            return 1;
        }
        else
        {
            return  arrMyAuctionGallary.count;
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
    if (collectionView == self.clvMyAuctionGallary)
    {
        if (indexPath.section==0)
        {
            AuctionItemTopBannerCollectionViewCell *tcell = [self configureAuctionItemTopBannerCollectionViewCell:collectionView indexPath:indexPath bannerName:@""];
            tcell.delegate = self;
            
            if (self.auctionType == AuctionTypeCurrent)
            {
                tcell.btnCurrentAuction.selected = YES;
                tcell.btnUpcomingAuction.selected = NO;
                tcell.lblCurrentAuctionSelectedLine.hidden = NO;
                tcell.lblUpcommingAuctionSelectedLine.hidden = YES;
            }
            else
            {
                tcell.btnCurrentAuction.selected = NO;
                tcell.btnUpcomingAuction.selected = YES;
                tcell.lblCurrentAuctionSelectedLine.hidden = YES;
                tcell.lblUpcommingAuctionSelectedLine.hidden = NO;
            }
            cell = tcell;
        }
        else if (indexPath.section == 1 || indexPath.section == 3)
        {
            cell = [self configureBlankCell:collectionView indexPath:indexPath];
        }
        else
        {
            CurrentAuction *objCurrentAccution = [arrMyAuctionGallary objectAtIndex:indexPath.row];
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
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
}

-(void)didChangedAuctionType
{
    if (self.auctionType == AuctionTypeCurrent)
    {
        self.auctionType = AuctionTypeUpcoming;
    }
    else
    {
        self.auctionType = AuctionTypeCurrent;
    }
    [self reloadData:arrGallaryItem];
}

-(void)didBidCancel
{
    
}
-(void)didBidConfirm
{
    
}
-(void)didProxyBidCancel
{
    
}
-(void)didProxyBidConfirm
{
    
}
-(void)didUpcommingProxyBidCancel
{
    
}
-(void)didUpcommingProxyBidConfirm
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
@end
