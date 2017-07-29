//
//  ViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"
#import "YTPlayerView.h"
#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

@property (strong, nonatomic) IBOutlet KASlideShow *bannerView1;
@property (strong, nonatomic) IBOutlet UIPageControl *banner1PageControl;
@property (strong, nonatomic) IBOutlet UILabel *lblUpcomingText;

@property (strong, nonatomic) IBOutlet KASlideShow *bannerView2;
@property (strong, nonatomic) IBOutlet UIPageControl *banner2PageControl;
@property (strong, nonatomic) IBOutlet UIView *recordPriceArtWorkView;
@property (strong, nonatomic) IBOutlet UIImageView *recordPriceArtWorkImageView;
@property (strong, nonatomic) IBOutlet UIButton *recordPriceArtWorkButton;
@property (strong, nonatomic) IBOutlet UICollectionView *clvVideoPlayer;
@property (strong, nonatomic) IBOutlet UIPageControl *videoPageControl;
@property (strong, nonatomic) IBOutlet UILabel *lblVideosText;
@property (strong, nonatomic) IBOutlet UILabel *lblVideosDesc;

@property (strong, nonatomic) IBOutlet UICollectionView *clvBottomMenu;

- (IBAction)recordPriceArtWorkButtonPressed:(UIButton *)sender;

@end

