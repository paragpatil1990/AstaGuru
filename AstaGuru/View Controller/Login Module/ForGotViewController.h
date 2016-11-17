//
//  ForGotViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface ForGotViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrScreollviw;
@property (weak, nonatomic) IBOutlet UIView *viwInnerview;

@end
