//
//  AboutUsCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutUs.h"
//#import <MessageUI/MFMailComposeViewController.h>
//#import <MessageUI/MessageUI.h>
@protocol AboutUsDelegate
-(void)didSendEmail:(AboutUs*)aboutus;
@end
@interface AboutUsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblDesignation;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIImageView *imgEmail;

@property (nonatomic, retain) id<AboutUsDelegate> delegate;
@property(nonatomic,retain)AboutUs *objAboutUs;

@end
