//
//  NotificationViewController.h
//  Tokative
//
//  Created by Amrit Singh on 12/13/16.
//  Copyright © 2016 FoxSolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NotificationViewController : BaseViewController

@property NSDictionary *noti_Dic;
@property (strong, nonatomic) IBOutlet UITableView *notification_TableView;
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UILabel *msg_Lbl;
@end
