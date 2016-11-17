//
//  GetInTouchViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 21/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "CustomTextfied.h"
@interface GetInTouchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UIButton *btncategory;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtEmail;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtname;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtPhone;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtCategory;
@property (weak, nonatomic) IBOutlet CustomTextfied *txtMessage;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedmenu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
