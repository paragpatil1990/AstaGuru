//
//  HowToSellViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 1/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface HowToSellSubmitDetailViewController : BaseViewController

@property(nonatomic,retain)NSArray *arrSelectSource;

@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UIView *subject_view;
@property (strong, nonatomic) IBOutlet UIView *description_View;
@property (strong, nonatomic) IBOutlet UIView *choosefile_view;
@property (strong, nonatomic) IBOutlet UIView *contact_view;
@property (strong, nonatomic) IBOutlet UIView *note_View;
@property (strong, nonatomic) IBOutlet UIView *aboutus_view;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmailId;
@property (strong, nonatomic) IBOutlet UITextField *txtSubject;
@property (strong, nonatomic) IBOutlet UITextField *txtDescription;
@property (strong, nonatomic) IBOutlet UITextField *txtUploadFile;
@property (strong, nonatomic) IBOutlet UITextField *txtContact;
@property (strong, nonatomic) IBOutlet UITextField *txtNote;
@property (strong, nonatomic) IBOutlet UITextField *txtSelectSource;

@property (strong, nonatomic) IBOutlet UIButton *chooseFile_Btn;
@property (strong, nonatomic) IBOutlet UIButton *selectSource_Btn;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)btnSubmit_Click:(UIButton *)sender;
- (IBAction)BtnSelectSource_Click:(UIButton *)sender;

@end
