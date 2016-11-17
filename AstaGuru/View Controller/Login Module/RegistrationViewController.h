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
@end
