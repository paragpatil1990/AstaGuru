//
//  UserInfoCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 21/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblBillingName;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingCity;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingState;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingZip;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblBillingPhone;

@end
