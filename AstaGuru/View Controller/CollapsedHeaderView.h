//
//  HeaderView.h
//  My Ghar Seva
//
//  Created by Sumit on 10/02/16.
//  Copyright © 2016 winjit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollapsedHeaderView : UITableViewHeaderFooterView
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckbox;
@end
