//
//  NotificationDetailViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 4/17/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailViewController : UIViewController

@property NSDictionary *record;
@property (strong, nonatomic) IBOutlet UILabel *message_Lbl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;

@end
