//
//  FilterViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 15/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ArtistInfo.h"

@protocol FilterViewControllerDelegate
-(void)didFilterWithSelectedArray:(NSArray*)selectedArray;
-(void)didCancelClearFilter;
@end

@interface FilterViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) IBOutlet UICollectionView *clvBottom;

@property (nonatomic, retain) id<FilterViewControllerDelegate>delegate;
@property (nonatomic, retain) NSString *strAuctionName;
@property (nonatomic, retain) NSString *strAuctionId;
@property  AuctionType auctionType;
@property (nonatomic, retain) NSMutableArray *selecteArtistArray;
@property (nonatomic, retain) NSArray *artistArray;
//@property (nonatomic, retain) CurrentAuction *currentAuction;

@end
