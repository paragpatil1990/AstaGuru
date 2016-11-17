//
//  CurrentOccutionViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentOccutionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *clvCurrentOccution;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblCurrency1;

@property (weak, nonatomic) IBOutlet UICollectionView *clvBottomMenu;

@property(nonatomic)int iISFeatured;
@end
