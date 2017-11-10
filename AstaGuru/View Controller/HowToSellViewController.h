//
//  HowToSellViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 1/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToSellViewController : UIViewController
@property(nonatomic,retain)NSMutableArray *arrJobTitle;
@property(nonatomic,retain)NSArray *arrSelectSource;
//@property (readwrite) id<CareersDelegate> careersDelegate;

@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lbl_TitleHeight;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;
@property (weak, nonatomic) IBOutlet UITextField *txtSubject;
@property (strong, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UIButton *chooseFile_Btn;
@property (weak, nonatomic) IBOutlet UITextField *txtUploadFile;
@property (weak, nonatomic) IBOutlet UITextField *txtContact;
@property (strong, nonatomic) IBOutlet UITextField *txtNote;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectSource;
@property (weak, nonatomic) IBOutlet UIButton *selectSource_Btn;
@property (strong, nonatomic) IBOutlet UIView *name_view;
@property (strong, nonatomic) IBOutlet UIView *email_view;
@property (strong, nonatomic) IBOutlet UIView *subject_view;
@property (strong, nonatomic) IBOutlet UIView *description_View;
@property (strong, nonatomic) IBOutlet UIView *choosefile_view;
@property (strong, nonatomic) IBOutlet UIView *contact_view;
@property (strong, nonatomic) IBOutlet UIView *note_View;
@property (strong, nonatomic) IBOutlet UIView *aboutus_view;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmit_Click:(UIButton *)sender;
- (IBAction)BtnSelectSource_Click:(UIButton *)sender;

@end
