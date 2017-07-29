//
//  ItemOfUpcomingViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/6/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ItemOfUpcomingViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UICollectionView *clvUpcomingAuctionItem;
@property (strong, nonatomic) IBOutlet UILabel *noRecords_Lbl;

@property (nonatomic,retain) UpcommingAuction *upcomingAuction;

@property BOOL isSearch;
@property (nonatomic) BOOL isFilter;

//@property NSArray *arrSearch;
//@property NSString *searchUrl;

@property NSArray *upcomingAuctionItemArray;

@end
