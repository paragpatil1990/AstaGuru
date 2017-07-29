//
//  UpcommingAuctionCollectionViewCell.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/3/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface UpcommingAuctionCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet EGOImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet UILabel *lblAuctionDate;

@end
