//
//  ItemOfPastAuctionViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 17/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsPastAuctionData.h"
@interface ItemOfPastAuctionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *ClvItemOfPastAuction;
@property(nonatomic,retain)clsPastAuctionData *objPast;
@property(nonatomic)int IsUpcomming;
@property(nonatomic)int IsPast;
@property(nonatomic)BOOL isSearch;
@property(nonatomic)BOOL isWorkArt;

@property(nonatomic,retain)NSMutableArray *arrSearch;

@end
