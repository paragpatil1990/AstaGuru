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
@end
