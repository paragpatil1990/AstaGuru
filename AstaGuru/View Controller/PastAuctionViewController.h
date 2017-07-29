//
//  PastOccuctionViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface PastAuctionViewController : BaseViewController

@property NSArray *pastAuctionArray;

@property (strong, nonatomic) IBOutlet UICollectionView *clvPastAuction;
@property (strong, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property (strong, nonatomic) IBOutlet UILabel *noRecords_Lbl;

@end
