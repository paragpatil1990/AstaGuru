//
//  CongratulationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface CongratulationViewController : BaseViewController
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;
@property (weak, nonatomic) IBOutlet UIButton *btnViewCurrentAuctions;

- (IBAction)btnViewCurrentAuctionPressed:(UIButton *)sender;

//@property(nonatomic,retain)NSString *strname;
//@property(nonatomic,retain)NSString *strEmail;//,*strEmialCode,*strSMSCode,*strMobile;
//@property(nonatomic,retain)NSMutableDictionary *dict;

@end
