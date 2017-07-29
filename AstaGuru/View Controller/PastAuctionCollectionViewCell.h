//
//  PastAuctionCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface PastAuctionCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet EGOImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalSaleValueText;
@property (strong, nonatomic) IBOutlet UILabel *lblTotlaSaleValue;
@property (strong, nonatomic) IBOutlet UILabel *lblAuctionDate;
@end
