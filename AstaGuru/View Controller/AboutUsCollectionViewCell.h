//
//  AboutUsCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsAboutUs.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
@protocol AboutUs
-(void)btnEmail:(clsAboutUs*)objAboutUS;
//-(void)ListSwipeOptionpressed:(int)option currentCellIndex:(int)index;
@end
@interface AboutUsCollectionViewCell : UICollectionViewCell<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblDesignation;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (readwrite) id<AboutUs> AboutUsdelegate;
@property(nonatomic,retain)clsAboutUs *objAboutUs;
@end
