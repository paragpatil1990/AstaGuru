//
//  HeaderView.h
//  My Ghar Seva
//
//  Created by Sumit on 10/02/16.
//  Copyright © 2016 winjit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain)NSString *strService;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckbox;

@end
