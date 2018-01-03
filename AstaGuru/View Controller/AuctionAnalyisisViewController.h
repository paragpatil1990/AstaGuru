//
//  AuctionAnalyisisViewController.h
//  AstaGuru
//
//  Created by Apple.Inc on 16/12/17.
//  Copyright © 2017 4Fox Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsCurrentOccution.h"

@interface AuctionAnalyisisViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UITableView *table_AuctionAnalysis;

@property (nonatomic,retain)clsCurrentOccution *objCurrentOuction;

@end
