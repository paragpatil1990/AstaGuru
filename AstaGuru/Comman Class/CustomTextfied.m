//
//  CustomTextfied.m
//  Crown Capital
//
//  Created by Aarya Tech on 18/04/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CustomTextfied.h"
#import <QuartzCore/QuartzCore.h>
@implementation CustomTextfied

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) drawPlaceholderInRect:(CGRect)rect
{
    
    [[UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:1.0] setFill];
    UIFont* italicFont;
    if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
    {
        italicFont =[UIFont fontWithName:@"WorkSans-Regular" size:12];;
    }
    else
    {
         italicFont =[UIFont fontWithName:@"WorkSans-Regular" size:9];;
    }
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    self.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [[self placeholder] drawInRect:rect withFont:italicFont];
    [[self text] drawInRect:rect withFont:italicFont];
   
    /*[[NSAttributedString alloc] initWithString:self.placeholder
                                    attributes:@{
                                                 NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : [UIFont systemFontOfSize:25]
                                                 }
     ];*/
}
@end
