//
//  ItemOfUpcomingViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/6/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "ItemOfUpcomingViewController.h"
#import "UpcommingProxyBidViewController.h"
#import "FilterViewController.h"
@interface ItemOfUpcomingViewController ()<UpcommingProxyBidViewControllerDelegate, FilterViewControllerDelegate>

@end

@implementation ItemOfUpcomingViewController

-(void)setUpNavigationItem
{
    if (self.isSearch)
    {
        self.navigationItem.title = @"Upcomming Auctions";
    }
    else
    {
        self.title=[NSString stringWithFormat:@"%@",[GlobalClass convertHTMLTextToPlainText:self.upcomingAuction.strAuctiontitle]];
    }
    
    [self setNavigationBarBackButton];
    [self setNavigationRightBarButtons];
    
    [self registerNibUpcomingAuctionItemCollectionView:self.clvUpcomingAuctionItem];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNavigationItem];
    [self registerNibUpcomingAuctionItemCollectionView:self.clvUpcomingAuctionItem];
    
    if (self.isSearch == 0)
    {
        [self getUpcomingAuctionItem];
    }
    
    self.selectedFilterArray = @[];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUpcomingAuctionItem
{
    NSString *strAtrtistId = @"";
    NSString *strType = @"P";
    if (self.isFilter)
    {
        if (self.selectedFilterArray.count>0)
        {
            for (int i=0; i<self.selectedFilterArray.count; i++)
            {
                ArtistInfo *objArtistInfo = [self.selectedFilterArray objectAtIndex:i];
                strAtrtistId = [strAtrtistId stringByAppendingString:[NSString stringWithFormat:@"%@%@",objArtistInfo.strArtistid,@"K"]];
            }
        }
    }
    else
    {
        strAtrtistId = @" ";
    }
    
    if ([[GlobalClass trimWhiteSpaceAndNewLine:self.upcomingAuction.strAuctionname] isEqualToString:@"Collectibles Auction"])
    {
        strType = @"C";
    }

    NSString *strUrl = [NSString stringWithFormat:@"spPastAuction(%@,%@,%@)", self.upcomingAuction.strAuctionId, strType, strAtrtistId];

    //NSString *strUrl = [NSString stringWithFormat:@"spPastAuction(%@,%@,%s)", self.upcomingAuction.strAuctionId, @"U", " "];
    
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         NSMutableArray *auctionArray = (NSMutableArray*)responseObject;
         
         NSArray *parseArray = [CurrentAuction parseAuction:auctionArray auctionType:AuctionTypeUpcoming];
         self.upcomingAuctionItemArray = parseArray;
         if (self.upcomingAuctionItemArray.count == 0)
         {
             self.clvUpcomingAuctionItem.hidden = YES;
             _noRecords_Lbl.text = @"There is no Upcoming Auction. We will notify you whenever any Upcoming Auction is live.";
             if (self.isFilter)
             {
                 self.clvUpcomingAuctionItem.hidden = NO;
                 _noRecords_Lbl.text = @"No record found, please try some other filtration options.";
             }
             _noRecords_Lbl.hidden = NO;
         }
         else
         {
             self.clvUpcomingAuctionItem.hidden = NO;
             _noRecords_Lbl.hidden = YES;
         }
         [self.clvUpcomingAuctionItem reloadData];
         
     } failure:^(NSError *error){
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
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
    if (indexPath.section==0)
    {
        return   CGSizeMake(collectionView.frame.size.width,142);
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
        return   CGSizeMake((collectionView.frame.size.width/2) - 12, 290);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section == 1 || section == 3)
    {
        return 1;
    }
    else
    {
        return  self.upcomingAuctionItemArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.section==0)
    {
        AuctionItemTopBannerCollectionViewCell *tcell = [self configureAuctionItemTopBannerCollectionViewCell:collectionView indexPath:indexPath bannerName:self.upcomingAuction.strAuctionBanner];
        tcell.delegate = self;
        if (self.isSearch)
        {
            CurrentAuction *objCurrentAuction = [self.upcomingAuctionItemArray objectAtIndex:0];
            NSString *strBannerImgUrl = [objCurrentAuction.strauctionBanner stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            tcell.bannerImageView.imageURL = [NSURL URLWithString:strBannerImgUrl];
            tcell.btnFilter.hidden=YES;
        }
        cell = tcell;

    }
    else if (indexPath.section == 1 || indexPath.section == 3)
    {
        cell = [self configureBlankCell:collectionView indexPath:indexPath];
    }
    else
    {
        CurrentAuction *objCurrentAccution = [self.upcomingAuctionItemArray objectAtIndex:indexPath.row];
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
    return cell;
}

- (IBAction)btnFilterPressed:(UIButton*)sender
{
    [self showFilter:AuctionTypeUpcoming auctionName:self.upcomingAuction.strAuctionname auctionID:self.upcomingAuction.strAuctionId delegate:self];
}

-(void)didCancelClearFilter
{
    _isFilter = NO;
    self.selectedFilterArray = @[];
    [self getUpcomingAuctionItem];
}

-(void)didFilterWithSelectedArray:(NSArray*)selectedArray
{
    _isFilter = YES;
    self.selectedFilterArray = [selectedArray mutableCopy];
    [self getUpcomingAuctionItem];
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

@end
