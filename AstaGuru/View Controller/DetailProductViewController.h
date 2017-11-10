//
//  DetailProductViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 03/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsCurrentOccution.h"
@interface DetailProductViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *productDetail_TableView;


//@property (strong, nonatomic) IBOutlet UICollectionView *productDetail_CollectionView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (weak, nonatomic) IBOutlet UILabel *lblNextValidBuid;
//@property (weak, nonatomic) IBOutlet UILabel *lblCurrentvalidbuild;
@property (nonatomic,retain) clsCurrentOccution *objCurrentOccution;
//@property (nonatomic)int iscurrencyInDollar;
@property(nonatomic)int IsCurrent;
@property(nonatomic)int IsUpcomming;
@property(nonatomic)int IsPast;
@property(nonatomic)int IsArtwork;
@property(nonatomic)int IsArtistDetail;
@property(nonatomic)int IsMyAuctionGallary;

//@property(nonatomic)int noOfRows;

@property(nonatomic, retain)NSString *Auction_id;
@end
