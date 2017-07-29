//
//  TopStaticCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalClass.h"
#import "EGOImageView.h"

@protocol CurrentAuctionTopBannerCollectionViewCellDelegate<NSObject>

-(void)didChangeSortOptionWithIndex:(NSInteger)index;

@end

@interface CurrentAuctionTopBannerCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet EGOImageView *bannerImageView;
@property (strong, nonatomic) IBOutlet UIButton *btnFilter;
@property (strong, nonatomic) IBOutlet UIButton *btnList;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrency;
@property (strong, nonatomic) IBOutlet UIButton *btnGrid;
@property (strong, nonatomic) IBOutlet UIButton *btnCurrency;
@property (strong, nonatomic) IBOutlet UICollectionView *clvSortBy;

@property (nonatomic, retain)  NSArray *arrSort;

@property (nonatomic, retain) id<CurrentAuctionTopBannerCollectionViewCellDelegate>delegate;

@end

