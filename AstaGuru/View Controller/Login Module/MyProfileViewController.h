//
//  MyProfileViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 15/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIView *fName_View;
@property (weak, nonatomic) IBOutlet UIView *lName_View;
@property (weak, nonatomic) IBOutlet UIView *mobile_View;
@property (weak, nonatomic) IBOutlet UIView *telephone_View;
@property (weak, nonatomic) IBOutlet UIView *email_View;
@property (strong, nonatomic) IBOutlet UIView *bname_View;
@property (weak, nonatomic) IBOutlet UIView *baddress_View;
@property (weak, nonatomic) IBOutlet UIView *bcity_View;
@property (weak, nonatomic) IBOutlet UIView *bcountry_View;
@property (weak, nonatomic) IBOutlet UIView *bstate_View;
@property (weak, nonatomic) IBOutlet UIView *bzip_View;
@property (weak, nonatomic) IBOutlet UIView *btelephone_View;

@property (weak, nonatomic) IBOutlet UIView *userName_View;
@property (weak, nonatomic) IBOutlet UIView *password_View;
@property (weak, nonatomic) IBOutlet UIView *nikname_View;

@end
