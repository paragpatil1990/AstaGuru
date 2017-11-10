//
//  TopStaticCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClsSetting.h"
#import "AppDelegate.h"
@protocol SortCurrentAuction

-(void)getCurrentAuctionWithIndex:(int)index;

//-(void)CurrentAuctionSortData:(NSMutableArray*)arrSordData iSelectedntdex:(int)iSelectedntdex;
@end

@interface TopStaticCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegate,PassResepose>

@property (weak, nonatomic) IBOutlet UICollectionView *clvSortBy;

@property (nonatomic, retain)  NSMutableArray *arrSort;

//@property (nonatomic)  int iSelectedIndex;

@property (weak, nonatomic) IBOutlet UIView *viwLineSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnList;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrency;
@property (weak, nonatomic) IBOutlet UIButton *btnGrid;
//@property(nonatomic,retain)UIView *mainView;
//@property(nonatomic)int iSelected;
//@property(nonatomic)int isRefreshstart;
//@property(nonatomic)int isFiterApplystart;
//@property(nonatomic,retain)NSTimer *timer;
//@property(nonatomic,retain)NSTimer *countDownTimer;

//-(void)Refresh;
@property (weak, nonatomic) IBOutlet UIButton *btnAuctionAnalist;
@property(readwrite)id<SortCurrentAuction> passSortDataDelegate;
@end
