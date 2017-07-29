//
//  DetailProductViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 03/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ProductDetailViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *productDetail_TableView;

@property (nonatomic,retain) CurrentAuction *currentAuction;

//@property NSInteger isCurrent;
//@property NSInteger isUpcomming;
//@property NSInteger isPast;

@end
