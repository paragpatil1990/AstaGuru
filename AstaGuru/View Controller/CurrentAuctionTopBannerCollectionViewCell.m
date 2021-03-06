//
//  TopStaticCollectionViewCell.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CurrentAuctionTopBannerCollectionViewCell.h"
#import "GlobalClass.h"
//#import "PareseCurrentAuction.h"
//#import "AppDelegate.h"


@implementation CurrentAuctionTopBannerCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *userAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    CGSize textSize = [[_arrSort objectAtIndex:indexPath.row] sizeWithAttributes: userAttributes];
    return CGSizeMake(textSize.width+6, collectionView.frame.size.height);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return  _arrSort.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SortMenuCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
    lblTitle.text=[_arrSort objectAtIndex:indexPath.row];
    
     UIView *viwLineSelected = (UIView *)[cell viewWithTag:21];
    AppDelegate *objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (indexPath.row == objAppDelegate.iSelectedSortInCurrentAuction)
    {
        UILabel *lblline = (UILabel *)[cell viewWithTag:21];
        lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
        
        lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
        viwLineSelected.hidden=NO;
    }
    else
    {
        lblTitle.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
       
        viwLineSelected.hidden=YES;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *objAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    objAppDelegate.iSelectedSortInCurrentAuction = indexPath.row;
    [_delegate didChangeSortOptionWithIndex:objAppDelegate.iSelectedSortInCurrentAuction];
    [_clvSortBy reloadData];
}

@end
