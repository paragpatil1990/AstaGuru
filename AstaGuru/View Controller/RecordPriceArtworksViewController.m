//
//  RecordPriceArtworksViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/6/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "RecordPriceArtworksViewController.h"

@interface RecordPriceArtworksViewController ()

@end

@implementation RecordPriceArtworksViewController

-(void)setUpNavigationItem
{
    
    self.navigationItem.title = @"Record Price Artworks";
   
    [self setNavigationBarBackButton];
    [self setNavigationRightBarButtons];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    [self getRecordPriceArtworks];
    
    [self registerNibPastAuctionItemCollectionView:self.clvRecordPriceArtwork];
}

-(void)getRecordPriceArtworks
{
    NSString  *strUrl=[NSString stringWithFormat:@"recordPriceArtworks?api_key=%@",[GlobalClass apiKey]];    
    [GlobalClass call_tableGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         NSMutableArray *auctionArray = (NSMutableArray*)responseObject[@"resource"];
//         if (auctionArray.count > 0)
//         {
             NSArray *parseArray = [CurrentAuction parseAuction:auctionArray auctionType:AuctionTypePast];
             self.recordPriceArtworkArray = parseArray;
             
             if (self.recordPriceArtworkArray.count == 0)
             {
                 self.clvRecordPriceArtwork.hidden = YES;
                 _noRecords_Lbl.hidden = NO;
                 _noRecords_Lbl.text = @"There is no any past auction still yet.";
             }
             else
             {
                 self.clvRecordPriceArtwork.hidden = NO;
                 _noRecords_Lbl.hidden = YES;
             }
             [self.clvRecordPriceArtwork reloadData];
//         }
     } failure:^(NSError *error){[GlobalClass showTost:error.localizedDescription];} callingCount:0];
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
        return   CGSizeMake((collectionView.frame.size.width/2) - 12, 300);
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
        return  self.recordPriceArtworkArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.section==0)
    {
        CurrentAuction *objCurrentAccution = [self.recordPriceArtworkArray objectAtIndex:0];
        AuctionItemTopBannerCollectionViewCell *tcell = [self configureAuctionItemTopBannerCollectionViewCell:collectionView indexPath:indexPath bannerName:objCurrentAccution.strauctionBanner];
        tcell.delegate = self;
        cell = tcell;
    }
    else if (indexPath.section == 1 || indexPath.section == 3)
    {
        cell = [self configureBlankCell:collectionView indexPath:indexPath];
    }
    else
    {
        CurrentAuction *objCurrentAccution = [self.recordPriceArtworkArray objectAtIndex:indexPath.row];
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
