//
//  CategoryListSidePageViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 05/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryListSidePageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvCategoryList;
@end
