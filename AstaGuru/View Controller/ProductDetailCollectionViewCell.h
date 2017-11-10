//
//  ProductDetailCollectionViewCell.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/11/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface ProductDetailCollectionViewCell : UICollectionViewCell

// Artist Image Cell
//artistImageCell
@property (strong, nonatomic) IBOutlet EGOImageView *artistImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *artistImage_Height;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArtistTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ProductTitle;
@property (strong, nonatomic) IBOutlet UIView *lineView;

// Current auction bid price cell
//currentBidPriceCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_CurrentBidText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_CurrentBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NextValidBidText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NextValidBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Countdown;
@property (strong, nonatomic) IBOutlet UILabel *lbl_CountdownValue;

// Upcomming/Past bid value cell
//upcommingPastBidPriceCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_WinningBidText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_BidPrice;
@property (strong, nonatomic) IBOutlet UILabel *lbl_InclusiveText;

// Current/Upcomming auction bid button cell
//currentBidButtonCell
//upcommingBidButtonCell
@property (strong, nonatomic) IBOutlet UIButton *btn_ViewImage;
@property (strong, nonatomic) IBOutlet UIButton *btn_AddMyAuctionGallary;
@property (strong, nonatomic) IBOutlet UILabel *lbl_LeadingText;
@property (strong, nonatomic) IBOutlet UIButton *btn_BidNow;
@property (strong, nonatomic) IBOutlet UIButton *bnt_Proxybid;
@property (strong, nonatomic) IBOutlet UIView *lineView1;
@property (strong, nonatomic) IBOutlet UIView *lineView2;

// Lot Description cell
//lotDescriptionCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_LotDescriptionText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArtistText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArtistName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_MediumText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Medium;
@property (strong, nonatomic) IBOutlet UILabel *lbl_YearText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Year;
@property (strong, nonatomic) IBOutlet UILabel *lbl_SizeText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Size;
@property (strong, nonatomic) IBOutlet UILabel *lbl_EstimateText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Estimate;

// View additional charges button cell
//viewAdditionalChargesBtnCell
@property (strong, nonatomic) IBOutlet UIButton *btn_ViewAdditionalCharges;

// AdditionalInfo Cell
//AdditionalInfoCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_AdditionalInfoText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_AdditionalInfo;

// Art Work Size Cell
//artWorkSizeCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArtWorkSizeText;
@property (strong, nonatomic) IBOutlet EGOImageView *artWorkImage;
@property (strong, nonatomic) IBOutlet UILabel *lbl_artWorkSize;

// About artist cell
//aboutArtistCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_AboutArtistText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_aboutArtist;
@property (strong, nonatomic) IBOutlet UIButton *btn_ReadMore_ReadLess;

// Bid History Button Cell
//bidHistoryBtnCell
@property (strong, nonatomic) IBOutlet UIButton *btn_BidHistory;

@end
