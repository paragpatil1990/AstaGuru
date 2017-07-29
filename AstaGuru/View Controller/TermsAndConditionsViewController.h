//
//  TermsAndConditionsViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/11/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "STCollapseTableView.h"

@interface TermsAndConditionsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet STCollapseTableView *tableTandC;

@end
