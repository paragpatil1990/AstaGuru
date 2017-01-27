//
//  TOPCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 01/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnList;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrency;
@property (weak, nonatomic) IBOutlet UIButton *btnGrid;
@property (weak, nonatomic) IBOutlet UIButton *btnAuctionAnalist;
//@property(readwrite)id<SortCurrentAuction> passSortDataDelegate;
@property (strong, nonatomic) IBOutlet UIButton *btnFilter;
@property (strong, nonatomic) IBOutlet UILabel *lblFilter;
@property (strong, nonatomic) IBOutlet UIImageView *iconDropdown;
@end
