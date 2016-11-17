//
//  SectionHeaderReusableView.h
//  TMKOC
//
//  Created by Aarya Tech on 11/07/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SectionHeaderReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
