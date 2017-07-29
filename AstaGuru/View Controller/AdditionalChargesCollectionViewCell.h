//
//  AdditionalChargesCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 14/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface AdditionalChargesCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIButton *btnLot;
@property (strong, nonatomic) IBOutlet EGOImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UILabel *lblArtistText;
@property (strong, nonatomic) IBOutlet UILabel *lblArtistName;
@property (strong, nonatomic) IBOutlet UILabel *lblMediumText;
@property (strong, nonatomic) IBOutlet UILabel *lblMedium;
@property (strong, nonatomic) IBOutlet UILabel *lblYearText;
@property (strong, nonatomic) IBOutlet UILabel *lblYear;
@property (strong, nonatomic) IBOutlet UILabel *lblSizeText;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;
@property (strong, nonatomic) IBOutlet UILabel *lblEstimateText;
@property (strong, nonatomic) IBOutlet UILabel *lblEstimation;
@property (strong, nonatomic) IBOutlet UILabel *lblHammerPriceText;
@property (strong, nonatomic) IBOutlet UILabel *lblHammerPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblBuyersPremiumText;
@property (strong, nonatomic) IBOutlet UILabel *lblBuyerPremium;
@property (strong, nonatomic) IBOutlet UILabel *lblVatOnHammerPriceText;
@property (strong, nonatomic) IBOutlet UILabel *lblVatOnHammerPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblGSTOnHammerPriceText;
@property (strong, nonatomic) IBOutlet UILabel *lblGSTOnPremium;
@property (strong, nonatomic) IBOutlet UILabel *lblGrandTotalText;
@property (strong, nonatomic) IBOutlet UILabel *lblGrandTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblNoteText;
@end
