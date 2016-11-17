//
//  CustomTableViewCell.h
//  SwipeTableCell
//
//  Created by Simon on 4/5/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface CustomTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *patternImageView;
@property (weak, nonatomic) IBOutlet UILabel *patternLabel;

@end
