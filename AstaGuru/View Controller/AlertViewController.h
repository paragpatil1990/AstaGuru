//
//  AlertViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/19/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIViewController

@property (retain, nonatomic) NSString *alertText;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *lblAlert;
@property (strong, nonatomic) IBOutlet UIButton *btnOk;

- (IBAction)btnOkPressed:(UIButton *)sender;



@end
