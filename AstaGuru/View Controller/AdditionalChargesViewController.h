//
//  AdditionalChargesViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 13/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AdditionalChargesViewController : BaseViewController

@property (nonatomic,retain)CurrentAuction *currentAuction;

@property (weak, nonatomic) IBOutlet UICollectionView *clvViewAdditionalCgharges;
//@property(nonatomic)int IsSort;
@end
