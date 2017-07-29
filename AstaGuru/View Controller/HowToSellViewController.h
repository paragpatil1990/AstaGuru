//
//  HowToSellViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/11/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "STCollapseTableView.h"

@interface HowToSellViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet STCollapseTableView *tableHowToSell;

- (IBAction)btnSubmitDetailPressed:(UIButton*)sender;


@end
