//
//  BaseViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/23/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GlobalClass.h"
//#import "JTSImageInfo.h"
//#import "EGOImageView.h"
//#import "JTSImageViewController.h"
#import "CurrentAuctionCollectionViewCell.h"
#import "PastAuctionCollectionViewCell.h"
#import "BottomMenuCollectionViewCell.h"
#import "UpcommingAuctionCollectionViewCell.h"
#import "AuctionItemTopBannerCollectionViewCell.h"
#import "SWRevealViewController.h"
#import "TableViewHelper.h"
#import "UpcommingAuction.h"
#import "PastAuction.h"

@interface BaseViewController : UIViewController<UISearchBarDelegate>

@property (nonatomic, strong) UIButton *sideButton;
@property (nonatomic, strong) UIBarButtonItem *sideBarButton;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIBarButtonItem *backBarButton;

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIBarButtonItem *searchBarButton;

@property (nonatomic, strong) UIButton *myAstaButton;
@property (nonatomic, strong) UIBarButtonItem *myAstaBarButton;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, retain)TableViewHelper *searchTableView;

@property (nonatomic, retain) NSArray *rightBarButtonItemArray;

@property NSArray *selectedFilterArray;

@property NSInteger selectedBMenu;

@property NSInteger isCommingFromSideMenu;

@property BOOL isList;
@property BOOL isMyAuctionGallary;


-(void)setNavigationBarTitleTextAttribut;

-(void)setNavigationBarBackButton;

-(void)setNavigationBarCloseButton;

-(void)setNavigationBarSlideButton;

-(void)setNavigationRightBarButtons;

-(void)setupSearchBar;

-(void)removeSearchBar;

-(NSArray*)arrBottomMenu;

-(UITapGestureRecognizer*)addTapGestureOnView:(UIView*)view;

-(void)registerNibCurrentAuctionCollectionView:(UICollectionView*)collectionView;

-(void)registerNibUpcomingAuctionCollectionView:(UICollectionView*)collectionView;

-(void)registerNibPastAuctionCollectionView:(UICollectionView*)collectionView;

-(void)registerNibUpcomingAuctionItemCollectionView:(UICollectionView*)collectionView;

-(void)registerNibPastAuctionItemCollectionView:(UICollectionView*)collectionView;

-(CurrentAuctionCollectionViewCell*)configureDefalutGridCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath currentAuction:(CurrentAuction*)currentAuction;

-(CurrentAuctionCollectionViewCell*)configureShortInfoCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath currentAuction:(CurrentAuction*)currentAuction;

-(PastAuctionCollectionViewCell*)configurePastAuctionCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath pastAuction:(PastAuction*)pastAuction;

-(UpcommingAuctionCollectionViewCell*)configureUpcomingAuctionCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath upcomingAuction:(UpcommingAuction*)upcomingAuction;

-(AuctionItemTopBannerCollectionViewCell*)configureAuctionItemTopBannerCollectionViewCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath bannerName:(NSString*)bannerName;

-(UICollectionViewCell*)configureBlankCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;

-(BottomMenuCollectionViewCell*)configureBottomMenuCell:(UICollectionView*)collectionView IndexPath:(NSIndexPath *)indexPath;

-(void)didSelectBottomMenu:(NSInteger)selectedMenu;

-(void)showAlertWithMessage:(NSString*)message;

-(void)gotoLoginVC;

-(void)gotoVerificationVC;

-(void)didSelectListGrid:(UICollectionView*)collectionView;

-(void)didCurrencyChanged:(UICollectionView*)collectionView;

-(void)zoomImage:(CurrentAuction *)currentAuction fromImageView:(EGOImageView*)imageView;

-(void)showCurrentAuctionViewController;

-(void)showHomeViewController;

-(void)showArtistInfo:(CurrentAuction*)currentAuction;

-(void)showProductDetail:(CurrentAuction*)currentAuction;

-(void)showBidHistory:(CurrentAuction*)currentAuction;

-(void)showAdditionalCharges:(CurrentAuction*)currentAuction;

-(void)insertItemToMyAuctionGallery:(CurrentAuction*)currentAuction;

-(void)bidNow:(CurrentAuction*)currentAuction bidDelegate:(id)delegate;

-(void)currentProxyBid:(CurrentAuction*)currentAuction bidDelegate:(id)delegate;

-(void)upcomingProxyBid:(CurrentAuction*)currentAuction bidDelegate:(id)delegate;

-(void)showFilter:(AuctionType)auctionType auctionName:(NSString*)auctionName auctionID:(NSString*)auctionID delegate:(id)delegate;

-(void)getAuctionByID:(CurrentAuction*)currentAuction view:(UIView*)view auction:(void (^)(CurrentAuction *currentAuction))auction;

-(void)getUserProfile:(void (^)(NSDictionary *userProfile))profile;

@end
