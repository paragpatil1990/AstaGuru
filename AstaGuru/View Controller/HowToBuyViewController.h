//
//  HowToBuyViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 21/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"
@interface HowToBuyViewController : UIViewController
@property NSUInteger pageIndex;
//@property (strong, nonatomic) IBOutlet STCollapseTableView *tblHowtoBuy;
@property (strong, nonatomic) IBOutlet STCollapseTableView *tblHowtoBuy;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (nonatomic)int isHowTobuy;
@end
