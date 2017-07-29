//
//  MyAuctionGalleryViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 27/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface MyAuctionGalleryViewController : BaseViewController
@property (nonatomic, assign) AuctionType auctionType;

@property AFHTTPRequestOperation *task;

@property (weak, nonatomic) IBOutlet UICollectionView *clvMyAuctionGallary;
@property (strong, nonatomic) IBOutlet UILabel *lblNoRecords;

@end
