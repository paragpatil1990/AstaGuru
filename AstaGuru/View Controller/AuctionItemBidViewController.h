//
//  AuctionItemBidViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 28/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsCurrentOccution.h"
#import "CustomTextfied.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface AuctionItemBidViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viwContentview;
@property (weak, nonatomic) IBOutlet UIButton *btnLot;
@property (weak, nonatomic) IBOutlet UILabel *lblBeadValue;
@property (nonatomic, retain)clsCurrentOccution *objCurrentOuction;
- (IBAction)btnCancelPressed:(id)sender;
- (IBAction)btnConfirmPressed:(id)sender;
@property (nonatomic)BOOL isBidNow;
@property (nonatomic)int iscurrencyInDollar;
@property (weak, nonatomic) IBOutlet UIView *viwProxyBid;
@property (weak, nonatomic) IBOutlet UIView *viwBidNow;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentBidValue;

@property (weak, nonatomic) IBOutlet CustomTextfied *txtProxyBid;
@property (weak, nonatomic) IBOutlet UIButton *btnLodId;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrKeytboard;
@property (weak, nonatomic) IBOutlet UIView *viwProxyBidConfarmation;


@end
