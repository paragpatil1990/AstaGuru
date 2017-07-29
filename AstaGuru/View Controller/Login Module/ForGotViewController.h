//
//  ForGotViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "BaseViewController.h"
@interface ForGotViewController : BaseViewController

//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
//@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrScreollviw;
@property (weak, nonatomic) IBOutlet UIView *viwInnerview;
@property (strong, nonatomic) IBOutlet UITextField *email_TextField;
@property (strong, nonatomic) IBOutlet UIButton *sendPassword_Btn;

- (IBAction)sendPassword_BtnClick:(UIButton *)sender;

@end
