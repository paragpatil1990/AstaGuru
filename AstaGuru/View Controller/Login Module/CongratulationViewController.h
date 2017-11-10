//
//  CongratulationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 10/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CongratulationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UIButton *btnViewconnentAuctions;
@property(nonatomic,retain)NSString *strname;
@property(nonatomic,retain)NSString *strEmail;//,*strEmialCode,*strSMSCode,*strMobile;
@property(nonatomic,retain)NSMutableDictionary *dict;

@end
