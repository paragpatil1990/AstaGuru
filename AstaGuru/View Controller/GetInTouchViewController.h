//
//  GetInTouchViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 21/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GetInTouchViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UIView *phone_view;
@property (strong, nonatomic) IBOutlet UIView *category_view;
@property (strong, nonatomic) IBOutlet UIView *message_view;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtname;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtCategory;
@property (strong, nonatomic) IBOutlet UITextField *txtMessage;

@property (strong, nonatomic) IBOutlet UIButton *btncategory;

@end
