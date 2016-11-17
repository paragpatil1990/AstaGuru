//
//  FilterViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 15/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Filter
-(void)filter:(NSMutableArray *)arrFilterArray;
@end
@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *clvFilter;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvBottom;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property(nonatomic,retain)NSMutableArray *arrFilter;
@property(readwrite)id<Filter> DelegateFilter;
@end
