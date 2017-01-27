//
//  ClientRelationViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextfied.h"
@protocol CareersDelegate
-(void)reloadDataTable;
@end
@interface ClientRelationViewController : UIViewController
@property(nonatomic,retain)NSMutableArray *arrJobTotle;
@property(nonatomic,retain)NSArray *arrSelectSource;
@property (readwrite) id<CareersDelegate> careersDelegate;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedMenu;
@property (weak, nonatomic) IBOutlet UITextField *txtJobTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtUploadResume;
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectSource;
@property (weak, nonatomic) IBOutlet UIButton *chooseFile_Btn;
@property (weak, nonatomic) IBOutlet UIButton *selectSource_Btn;
- (IBAction)BtnSelectSource_Click:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UIView *job_view;
@property (strong, nonatomic) IBOutlet UIView *choosefile_view;
@property (strong, nonatomic) IBOutlet UIView *message_view;
@property (strong, nonatomic) IBOutlet UIView *aboutus_view;

@end
