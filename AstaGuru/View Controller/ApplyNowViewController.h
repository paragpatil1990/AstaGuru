//
//  ClientRelationViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

//@protocol CareersDelegate
//-(void)reloadDataTable;
//@end

@interface ApplyNowViewController : BaseViewController

@property(nonatomic,retain)NSMutableArray *arrJobTitle;
@property(nonatomic,retain)NSArray *arrSelectSource;
//@property (readwrite) id<CareersDelegate> careersDelegate;

//@property NSString *jobTitle;

@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UIView *job_view;
@property (strong, nonatomic) IBOutlet UIView *choosefile_view;
@property (strong, nonatomic) IBOutlet UIView *message_view;
@property (strong, nonatomic) IBOutlet UIView *aboutus_view;

@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;

@property (strong, nonatomic) IBOutlet UITextField *txtJobTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtUploadResume;
@property (strong, nonatomic) IBOutlet UITextField *txtMessage;
@property (strong, nonatomic) IBOutlet UITextField *txtEmailId;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtSelectSource;

@property (strong, nonatomic) IBOutlet UIButton *chooseFile_Btn;
@property (strong, nonatomic) IBOutlet UIButton *selectSource_Btn;

- (IBAction)BtnSelectSource_Click:(UIButton *)sender;

@end
