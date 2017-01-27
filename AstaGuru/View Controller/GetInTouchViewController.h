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
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtname;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;

@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UIView *phone_view;
@property (strong, nonatomic) IBOutlet UIView *category_view;
@property (strong, nonatomic) IBOutlet UIView *message_view;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedmenu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
