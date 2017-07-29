//
//  AlertViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/19/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "AlertViewController.h"
#import "GlobalClass.h"
@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GlobalClass setBorder:self.contentView cornerRadius:8 borderWidth:1 color:[UIColor whiteColor]];

}

-(void)setAlertText:(NSString *)alertText
{
    _alertText = alertText;
    self.lblAlert.text = alertText;
}

- (IBAction)btnOkPressed:(UIButton *)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
