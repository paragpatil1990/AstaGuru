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
@property (strong, nonatomic) IBOutlet UIImageView *noAuction_ImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property (strong, nonatomic) IBOutlet UILabel *lblNoRecords;

@property(nonatomic,retain)NSMutableArray *arrSearch;
@property NSString *searchUrl;
@property(nonatomic) BOOL isSearch;
@property(nonatomic) BOOL isFilter;

//@property(nonatomic,retain)NSTimer *currentTimer;
//@property(nonatomic,retain)NSTimer *filterTimer;
//@property(nonatomic,retain)NSTimer *searchResultTimer;

@end
