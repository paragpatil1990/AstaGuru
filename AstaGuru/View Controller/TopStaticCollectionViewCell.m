//
//  TopStaticCollectionViewCell.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "TopStaticCollectionViewCell.h"
#import "ClsSetting.h"
#import "parese.h"
#import "AppDelegate.h"

@implementation TopStaticCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    _arrSort=[[NSMutableArray alloc]initWithObjects:@"Lots",@"Latest",@"Significant",@"Popular",@"Closing soon",nil];
    _clvSortBy.dataSource=self;
    _clvSortBy.delegate=self;
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 26)];
    [lbl setFont:[UIFont systemFontOfSize:10]];
    float widthIs = [[_arrSort objectAtIndex:indexPath.row] boundingRectWithSize:lbl.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:lbl.font } context:nil] .size.width;
    
    if (indexPath.row==2 ||indexPath.row==4)
    {
        return CGSizeMake(widthIs+10,26);
    }
    return CGSizeMake(45,26);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return  _arrSort.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Sort";
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
    AppDelegate *objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    objAppDelegate.iSelectedSortInCurrentAuction = (int)indexPath.row;
    [_passSortDataDelegate getCurrentAuctionWithIndex:objAppDelegate.iSelectedSortInCurrentAuction];
    [_clvSortBy reloadData];
}

@end
