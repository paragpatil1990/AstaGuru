//
//  CurrentDefultGridCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "clsCurrentOccution.h"
#import "clsMyAuctionGallery.h"
@protocol CurrentOccution
@optional
-(void)btnShotinfoPressed:(int)iSelectedIndex;
-(void)ListSwipeOptionpressed:(int)option currentCellIndex:(int)index;
@end

@interface CurrentDefultGridCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnArtist;
@property (weak, nonatomic) IBOutlet EGOImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UIButton *btnLot;
@property (strong, nonatomic) IBOutlet UILabel *lblLot;
@property (weak, nonatomic) IBOutlet UIButton *btnShortInfo;
- (IBAction)btnShortInfoPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblArtistName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblCoundown;
@property (nonatomic,retain)clsCurrentOccution *objCurrentOccution;
@property (nonatomic,retain)clsMyAuctionGallery *objMyAuctionGallery;
@property (readwrite) id<CurrentOccution> CurrentOccutiondelegate;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (weak, nonatomic) IBOutlet UILabel *lblMedium;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
- (IBAction)btnClosePressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblSize;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblEstimation;
@property (nonatomic)  int iSelectedIndex;
@property (weak, nonatomic) IBOutlet UIView *viwSwap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *clvAction_Leading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *clvAction_Tralling;

@property (weak, nonatomic) IBOutlet UICollectionView *clvAction;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *htlblArtistName;
@property (weak, nonatomic) IBOutlet UIButton *btnbidNow;
@property (nonatomic) int isMyAuctionGallery;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentBuild;
@property (weak, nonatomic) IBOutlet UIButton *btnproxy;
@property (weak, nonatomic) IBOutlet UIButton *btnGridSelectedDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblNextValidBuild;

@property (weak, nonatomic) IBOutlet UILabel *lblcurrentbid;
@property (weak, nonatomic) IBOutlet UIButton *btnMaximizeImage;
@property(nonatomic)int isCommingFromPast;
@property(nonatomic)int isCommingFromUpcoming;

//- (IBAction)btnMaximizeImageClicked:(id)sender;
//- (IBAction)btnMyAuctionGallery:(id)sender;
//- (IBAction)btnBidNow:(id)sender;
//- (IBAction)btnProxyBid:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBidHistory;
@property (weak, nonatomic) IBOutlet UIButton *btnMyGallery;

@property (strong, nonatomic) IBOutlet UILabel *lbl_startPriceText;

@property (weak, nonatomic) IBOutlet UILabel *pastStatictext;
@property (weak, nonatomic) IBOutlet UIView *nextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnMyGallery_width;

-(void)setuparray;
-(void)setupGesture;

@end
