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


@property (weak, nonatomic) IBOutlet EGOImageView *imgProduct;

@property (weak, nonatomic) IBOutlet UILabel *lblArtistName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (weak, nonatomic) IBOutlet UILabel *lblMedium;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *lblSize;
@property (weak, nonatomic) IBOutlet UILabel *lblEstimation;
//@property (weak, nonatomic) IBOutlet UILabel *lblByyerPremium;
//@property (weak, nonatomic) IBOutlet UILabel *lblServiceTaxOnPremium;
//@property (weak, nonatomic) IBOutlet UILabel *lblVatOnHammerPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnLot;

@property (weak, nonatomic) IBOutlet UILabel *lbl_hammerPriceTxt;
@property (weak, nonatomic) IBOutlet UILabel *lbl_hammerPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_marginTxt;
@property (weak, nonatomic) IBOutlet UILabel *lbl_margin;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gstOnArtworkTxt;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gstOnArtwork;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gstOnBuyersPremiumTxt;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gstOnBuyersPremium;

@property (weak, nonatomic) IBOutlet UILabel *lbl_GrandTotal;

@end
