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


@property (weak, nonatomic) IBOutlet EGOImageView *imgPastAuction;
@property (weak, nonatomic) IBOutlet UILabel *lblPastAuctionTitle;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *lblTotlaSaleValue;
@property (weak, nonatomic) IBOutlet UILabel *lblPastAuctionDate;

@end
