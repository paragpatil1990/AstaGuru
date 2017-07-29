//
//  UpcommingProxyBidViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/1/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@protocol UpcommingProxyBidViewControllerDelegate<NSObject>
@optional
-(void)didUpcommingProxyBidConfirm;
-(void)didUpcommingProxyBidCancel;
@end

@interface UpcommingProxyBidViewController : BaseViewController

@property (nonatomic, assign) id <UpcommingProxyBidViewControllerDelegate>delegate;
@property (nonatomic, retain) CurrentAuction *currentAuction;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollKeyboard;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *lblAlert;
@property (strong, nonatomic) IBOutlet UIView *proxyBidView;
@property (strong, nonatomic) IBOutlet UILabel *lblLot;
@property (strong, nonatomic) IBOutlet UILabel *lblBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblBidText;
@property (strong, nonatomic) IBOutlet UILabel *lblProxyBidText;
@property (strong, nonatomic) IBOutlet UITextField *txtProxyBid;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;

- (IBAction)btnCancelPressed:(UIButton *)sender;
- (IBAction)btnConfirmPressed:(UIButton *)sender;

@end
