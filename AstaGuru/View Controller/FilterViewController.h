//
//  FilterViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 15/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FilterDelegate
-(void)filter:(NSMutableArray *)arrFilterArray selectedArtistArray:(NSMutableArray *)arrSelectedArtist;
-(void)clearCancelFilter;
@end

@interface FilterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvFilter;
@property (weak, nonatomic) IBOutlet UICollectionView *clvBottom;

@property(readwrite)id<FilterDelegate>delegateFilter;
@property(nonatomic,retain)NSMutableArray *arrselectArtist;
@property(nonatomic) int ispast;
@property(nonatomic) int auctionID;
@property(nonatomic) int selectedTab;
@property(nonatomic,retain)NSString *strType;
@property(nonatomic, retain) NSString *auctionName;
@end
