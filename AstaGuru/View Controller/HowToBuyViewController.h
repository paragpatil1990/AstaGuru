//
//  HowToBuyViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/10/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "STCollapseTableView.h"
@interface HowToBuyViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet STCollapseTableView *tableHowToBuy;

@end
