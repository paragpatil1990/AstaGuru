//
//  UpcommingAuctionViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface UpcommingAuctionViewController : BaseViewController

@property NSArray *upcommingAuctionArray;

@property (strong, nonatomic) IBOutlet UICollectionView *clvUpcommingAuction;
@property (strong, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property (strong, nonatomic) IBOutlet UILabel *noRecords_Lbl;

@end
