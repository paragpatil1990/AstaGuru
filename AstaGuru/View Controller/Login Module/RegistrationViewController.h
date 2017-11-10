//
//  RegistrationViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 09/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
- (IBAction)btnAgreePressed:(id)sender;
- (IBAction)btnTermsAndCondition:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckTermsAndCondition;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UIView *fName_View;
@property (weak, nonatomic) IBOutlet UIView *lName_View;
@property (weak, nonatomic) IBOutlet UIView *address_View;
@property (weak, nonatomic) IBOutlet UIView *city_View;
@property (weak, nonatomic) IBOutlet UIView *country_View;
@property (weak, nonatomic) IBOutlet UIView *state_View;
@property (weak, nonatomic) IBOutlet UIView *zip_View;
@property (weak, nonatomic) IBOutlet UIView *mobile_View;
@property (weak, nonatomic) IBOutlet UIView *telephone_View;
@property (weak, nonatomic) IBOutlet UIView *fax_View;
@property (weak, nonatomic) IBOutlet UIView *email_View;
@property (weak, nonatomic) IBOutlet UIView *userName_View;
@property (weak, nonatomic) IBOutlet UIView *password_View;
@property (weak, nonatomic) IBOutlet UIView *confirmPassword_View;

@property (strong, nonatomic) IBOutlet UIButton *btnProceed;


@end
