//
//  PrivacyPoliceViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyPoliceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property(nonatomic)BOOL isPrivacyPolice;
@property (weak, nonatomic) IBOutlet UITextView *txt;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
