//
//  BidNowViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentAuction.h"
#import "BaseViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@protocol BidNowViewControllerDelegate<NSObject>
@optional
-(void)didBidConfirm;
-(void)didBidCancel;
@end

@interface BidNowViewController : BaseViewController

@property (nonatomic, assign) id <BidNowViewControllerDelegate>delegate;
@property (nonatomic, retain) CurrentAuction *currentAuction;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollKeyboard;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *lblAlert;
@property (strong, nonatomic) IBOutlet UIView *bidNowView;
@property (strong, nonatomic) IBOutlet UILabel *lblLot;
@property (strong, nonatomic) IBOutlet UILabel *lblBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblNextValidBidText;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;

- (IBAction)btnCancelPressed:(UIButton *)sender;
- (IBAction)btnConfirmPressed:(UIButton *)sender;

@end
