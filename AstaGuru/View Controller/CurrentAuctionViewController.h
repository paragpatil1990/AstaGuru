//
//  CurrentOccutionViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CurrentAuctionViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UICollectionView *clvCurrentAuction;
@property (strong, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property (strong, nonatomic) IBOutlet UIImageView *noAuction_ImageView;
@property (strong, nonatomic) IBOutlet UILabel *lblNoRecords;

@property NSArray *currentAuctionArray;
@property NSMutableArray *arrSearch;
@property NSString *searchUrl;
@property BOOL isSearch;
@property BOOL isFilter;

@property AFHTTPRequestOperation *task;

-(void)getSetAuctionData;

@end
