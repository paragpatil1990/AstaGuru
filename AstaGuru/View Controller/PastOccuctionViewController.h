//
//  PastOccuctionViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface PastOccuctionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *clvPastAuction;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property ( nonatomic)int iIsUpcomming;

@end
