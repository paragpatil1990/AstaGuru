//
//  NotificationTableViewCell.h
//  AstaGuru
//
//  Created by Amrit Singh on 2/18/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *mTime_Lbl;
@property (strong, nonatomic) IBOutlet UILabel *notiMsg_Lbl;

@end
