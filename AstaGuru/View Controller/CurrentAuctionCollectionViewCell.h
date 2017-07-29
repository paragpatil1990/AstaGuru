//
//  CurrentAuctionCollectionViewCell.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/4/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentAuction.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "EGOImageView.h"
#import "GlobalClass.h"

@interface CurrentAuctionCollectionViewCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic,retain) NSArray *arrAction;
//@property (nonatomic,retain) NSArray *arrActionImages;

@property (nonatomic,retain) UICollectionView *cellClv;
@property (nonatomic,retain) NSIndexPath *cellIndexPath;

@property (nonatomic,retain) CurrentAuction *currentAuction;

@property (nonatomic, retain) id delegate;

@property (strong, nonatomic) IBOutlet EGOImageView *imgProduct;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *productImgGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *artistNameGesture;

@property (strong, nonatomic) IBOutlet UILabel *lblLot;

@property (strong, nonatomic) IBOutlet UIButton *btnMaximizeImage;

@property (strong, nonatomic) IBOutlet UIButton *btnAdd_DeleteGallery;

@property (strong, nonatomic) IBOutlet UIButton *btnShortInfo;

@property (strong, nonatomic) IBOutlet UILabel *lblArtistName;

@property (strong, nonatomic) IBOutlet UILabel *lblProductName;

@property (strong, nonatomic) IBOutlet UIImageView *imgCurrentBid;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentBidText;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentBid;

@property (strong, nonatomic) IBOutlet UIImageView *imgNextValidBid;
@property (strong, nonatomic) IBOutlet UILabel *lblNextValidText;
@property (strong, nonatomic) IBOutlet UILabel *lblNextValidBid;

@property (strong, nonatomic) IBOutlet UILabel *lblCountdownText;
@property (strong, nonatomic) IBOutlet UILabel *lblCountdown;

@property (strong, nonatomic) IBOutlet UIButton *btnClose;

@property (strong, nonatomic) IBOutlet UILabel *lblArtistText;

@property (strong, nonatomic) IBOutlet UILabel *lblMediumText;
@property (strong, nonatomic) IBOutlet UILabel *lblMedium;

@property (strong, nonatomic) IBOutlet UILabel *lblYearText;
@property (strong, nonatomic) IBOutlet UILabel *lblYear;

@property (strong, nonatomic) IBOutlet UILabel *lblSizeText;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;

@property (strong, nonatomic) IBOutlet UILabel *lblEstimateText;
@property (strong, nonatomic) IBOutlet UILabel *lblEstimate;

@property (strong, nonatomic) IBOutlet UILabel *lblLeadingText;

@property (strong, nonatomic) IBOutlet UIButton *btnBidNow;
@property (strong, nonatomic) IBOutlet UIButton *btnProxy;

@property (strong, nonatomic) IBOutlet UIButton *btnDetail;

@property (strong, nonatomic) IBOutlet UIView *viewAction;
@property (strong, nonatomic) IBOutlet UICollectionView *clvAction;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *clvAction_Leading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *clvAction_Tralling;

@property (strong, nonatomic) IBOutlet UIView *viewSwip;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *viewSwipPanGesture;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *viewSwipLeftGesture;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *viewSwipRightGesture;

//upcoming cell
@property (strong, nonatomic) IBOutlet UILabel *lbStartPriceText;

//Past cell
@property (strong, nonatomic) IBOutlet UILabel *lblInclusiveStaticText;

- (IBAction)imgProductPressed:(UITapGestureRecognizer *)sender;
- (IBAction)lblArtistNamePressed:(UITapGestureRecognizer *)sender;
- (IBAction)viewSwipLeft:(UISwipeGestureRecognizer *)sender;
- (IBAction)viewSwipRight:(UISwipeGestureRecognizer *)sender;
- (IBAction)btnLotPressed:(UIButton *)sender;
- (IBAction)btnMaximizeImagePressed:(UIButton *)sender;
- (IBAction)btnAdd_DeleteGalleryPressed:(UIButton *)sender;
- (IBAction)btnShortInfoPressed:(UIButton *)sender;
- (IBAction)btnClosePressed:(UIButton *)sender;
- (IBAction)btnBidNowPressed:(UIButton *)sender;
- (IBAction)btnProxyBidPressed:(UIButton *)sender;
- (IBAction)btnDetailPressed:(UIButton *)sender;

//-(void)setupActionArray;
-(void)setupSwipGesture;

@end
