//
//  ViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "YTPlayerView.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet iCarousel *vwCarousel;
@property (weak, nonatomic) IBOutlet UICollectionView *clvUpcommingAuction;
@property (weak, nonatomic) IBOutlet UICollectionView *clvFeaturedAuction;
@property (strong, nonatomic) IBOutlet UIPageControl *pgControl;
@property (strong, nonatomic) IBOutlet UIPageControl *pgControlUpcommingAuction;
@property (weak, nonatomic) IBOutlet UICollectionView *clsFullImage;
@property (weak, nonatomic) IBOutlet UICollectionView *clvVideo;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UICollectionView *clvBottomMenu;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *htVideoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *htVideoViews;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *videoflowlayout;
@property (weak, nonatomic) IBOutlet YTPlayerView *viwplayer;
@property (weak, nonatomic) IBOutlet UIImageView *imgVideo;
@property (weak, nonatomic) IBOutlet UIPageControl *pgVideo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *htvideoPLayer;

@end

