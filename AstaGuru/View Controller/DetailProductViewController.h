//
//  DetailProductViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 03/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsCurrentOccution.h"
@interface DetailProductViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *lblNextValidBuid;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentvalidbuild;
@property (nonatomic,retain) clsCurrentOccution *objCurrentOccution;
@property (nonatomic)int iscurrencyInDollar;
@property(nonatomic)int IsSort;
@end
