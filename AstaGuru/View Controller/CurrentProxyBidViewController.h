//
//  CurrentProxyBidViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentAuction.h"
#import "BaseViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@protocol ProxyBidViewControllerDelegate<NSObject>
@optional
-(void)didProxyBidConfirm;
-(void)didProxyBidCancel;
@end

@interface CurrentProxyBidViewController : BaseViewController

@property(nonatomic, assign) id <ProxyBidViewControllerDelegate>delegate;
@property (nonatomic, retain) CurrentAuction *currentAuction;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollKeyboard;

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
