//
//  MyPurchaseViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/6/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface MyPurchaseViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UICollectionView *clvMyPurchase;
@property (strong, nonatomic) IBOutlet UILabel *noRecords_Lbl;

//@property(nonatomic,retain) PastAuction *pastAuction;
@property NSArray *myPurchaseArray;

@end
