//
//  BidHistoryViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 13/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsCurrentOccution.h"
@interface BidHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *clsBidHistory;
@property (nonatomic,retain)clsCurrentOccution *objCurrentOuction;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property(nonatomic)int IsSort;
@property(nonatomic)int IsUpcoming;

@end
