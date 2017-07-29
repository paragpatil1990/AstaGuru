//
//  BaseViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 6/23/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "BaseViewController.h"
#import "AfterLoginViewController.h"
#import "BeforeLoginViewController.h"
//#import "SearchViewController.h"
#import "ArtistViewController.h"
#import "ProductDetailViewController.h"
#import "BidHistoryViewController.h"
#import "MyAuctionGalleryViewController.h"
#import "VerificationViewController.h"
#import "HomeViewController.h"
#import "CurrentAuctionViewController.h"
#import "UpcommingAuctionViewController.h"
#import "PastAuctionViewController.h"
#import "BidNowViewController.h"
#import "CurrentProxyBidViewController.h"
#import "UpcommingProxyBidViewController.h"
#import "FilterViewController.h"
#import "AdditionalChargesViewController.h"
#import "AlertViewController.h"
#import "ItemOfPastAuctionViewController.h"
#import "ItemOfUpcomingViewController.h"
@interface BaseViewController ()
{
    NSArray *arrOption;
}
@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    SWRevealViewController *revealController = self.revealViewController;
    [revealController tapGestureRecognizer];
    //    [revealController panGestureRecognizer];

    [self setNavigationBarTitleTextAttribut];
    [self setNavigationBarBackButton];
}

-(void)setNavigationBarTitleTextAttribut
{
    [self.navigationController.navigationBar setBackgroundImage:[self imageFromColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageFromColor:[UIColor grayColor]]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:18]}];
}

-(UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 50, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-Back.png"] forState:UIControlStateNormal];
    [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -35, 0, -25)];
    [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -38, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    _backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavigationBarCloseButton
{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"icon-close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(0, 0, 20, 20);
    [closeButton imageView].contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    closeBarButton.tintColor=[UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:closeBarButton];
}

-(void)setNavigationBarSlideButton
{
    _sideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sideButton setImage:[UIImage imageNamed:@"signs"] forState:UIControlStateNormal];
    [_sideButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _sideButton.frame = CGRectMake(0, 0, 20, 16);
    _sideButton.tintColor = [UIColor whiteColor];

    _sideBarButton = [[UIBarButtonItem alloc] initWithCustomView:_sideButton];
    [self.navigationItem setLeftBarButtonItem:_sideBarButton];
}

-(void)setNavigationRightBarButtons
{
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [_searchButton addTarget:self action:@selector(btnSearchPressed) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.frame = CGRectMake(0, 0, 20, 16);
    [_searchButton imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];

    _myAstaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_myAstaButton setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [_myAstaButton addTarget:self action:@selector(btnAstaGuruPressed) forControlEvents:UIControlEventTouchUpInside];
    _myAstaButton.frame = CGRectMake(0, 0, 20, 16);
    [_myAstaButton imageView].contentMode = UIViewContentModeScaleAspectFit;
    
    _myAstaBarButton = [[UIBarButtonItem alloc] initWithCustomView:_myAstaButton];
    _myAstaBarButton.tintColor = [UIColor whiteColor];

    _searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:_searchButton];
    _searchBarButton.tintColor = [UIColor whiteColor];
    
    _rightBarButtonItemArray = [NSArray arrayWithObjects:_searchBarButton, _myAstaBarButton, nil];
    self.navigationItem.rightBarButtonItems = _rightBarButtonItemArray;
}

-(void)closePressed
{
    if (_isCommingFromSideMenu == 1)
    {
        [self showHomeViewController];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)btnAstaGuruPressed
{
    if ([GlobalClass isUserLogin])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        AfterLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AfterLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BeforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BeforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
}
-(void)setupSearchBar
{
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"Search here";
    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor colorWithRed:130.0f/255.0f green:103.0f/255.0f blue:67.0f/255.0f alpha:1];
    
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    searchField.font = [UIFont fontWithName:@"WorkSans-Regular" size:16];
    // To change background color
    searchField.backgroundColor = [UIColor colorWithRed:65.0f/255.0f green:65.0f/255.0f blue:65.0f/255.0f alpha:1];
    // To change text color
    searchField.textColor = [UIColor whiteColor];
    
    [self.searchBar setImage:[UIImage imageNamed:@"icon-search.png"]
            forSearchBarIcon:UISearchBarIconSearch
                       state:UIControlStateNormal];
    
    arrOption = [[NSArray alloc] initWithObjects:@"Browse Current Auctions",@"Browse Upcoming Auctions",@"View past Auction Results", nil];
    
    self.searchTableView = [[TableViewHelper alloc] initWithFrame:CGRectZero];
    self.searchTableView.base = self;
    
    // add the search bar (which will start out hidden).
    _searchTableView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.5 animations:^{
        _searchBar.hidden = 1;
        _sideButton.alpha = 0.0f;
        _searchButton.alpha = 0.0f;
        _myAstaButton.alpha = 0.0f;
        _backButton.alpha = 0.0f;
        self.navigationItem.titleView = _searchBar;
    } completion:^(BOOL finished) {
        
        // remove the slide button
        self.navigationItem.leftBarButtonItem = nil;
        
        // remove the search button
        self.navigationItem.rightBarButtonItems = nil;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _searchBar.hidden = 0;
                             _searchTableView.alpha = 1.0f;
                             [self.searchTableView addSearchTableView];
                             [_searchBar becomeFirstResponder];
                         } completion:^(BOOL finished) {
                         }];
        
    }];
}

// called when cancel button pressed
-(void)removeSearchBar
{
    [UIView animateWithDuration:0.5f animations:^{
        _searchBar.alpha = 0.0f;
        _searchTableView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = nil;
        self.navigationItem.leftBarButtonItem = _backBarButton;
        if (_sideBarButton != nil)
        {
            self.navigationItem.leftBarButtonItem = _sideBarButton;
        }
        
        self.navigationItem.rightBarButtonItems = _rightBarButtonItemArray;
        
        _sideButton.alpha = 0.0; // set this *after* adding it back
        _searchButton.alpha = 0.0;
        _myAstaButton.alpha = 0.0;
        _backButton.alpha = 0.0;
        [UIView animateWithDuration:0.5f animations:^ {
            _searchButton.alpha = 1.0;
            _myAstaButton.alpha = 1.0;
            _sideButton.alpha = 1.0;
            _backButton.alpha = 1.0;
            [self.searchTableView removeFromSuperview];
        }];
    }];
}

-(void)btnSearchPressed
{
    [self setupSearchBar];

    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SearchViewController *VCLikesControll = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
//    [self.navigationController pushViewController:VCLikesControll animated:YES];
}

#pragma mark UISearchBarDelegate methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self removeSearchBar];
}// called when cancel button pressed

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchTableView spSearch:@"Past"];
}

-(void)registerNibCurrentAuctionCollectionView:(UICollectionView*)collectionView
{
    [collectionView registerNib:[UINib nibWithNibName:@"CurrentDefaultGridCell" bundle:nil] forCellWithReuseIdentifier:@"DefaultGridCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"CurrentSelectedGridCell" bundle:nil] forCellWithReuseIdentifier:@"SelectedGridCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"CurrentDefaultListCell" bundle:nil] forCellWithReuseIdentifier:@"DefaultListCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"CurrentSelectedListCell" bundle:nil] forCellWithReuseIdentifier:@"SelectedListCell"];
}

-(void)registerNibUpcomingAuctionCollectionView:(UICollectionView*)collectionView
{
    [collectionView registerNib:[UINib nibWithNibName:@"UpcommingAuctionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UpcomingAuctionCell"];
}

-(void)registerNibUpcomingAuctionItemCollectionView:(UICollectionView*)collectionView
{
    [collectionView registerNib:[UINib nibWithNibName:@"UpcomingDefaultGridCell" bundle:nil] forCellWithReuseIdentifier:@"UpcomingDefaultGridCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"UpcomingSelectedGridCell" bundle:nil] forCellWithReuseIdentifier:@"UpcomingSelectedGridCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"UpcomingDefaultListCell" bundle:nil] forCellWithReuseIdentifier:@"UpcomingDefaultListCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"CurrentSelectedListCell" bundle:nil] forCellWithReuseIdentifier:@"SelectedListCell"];
}

-(void)registerNibPastAuctionCollectionView:(UICollectionView*)collectionView
{
    [collectionView registerNib:[UINib nibWithNibName:@"PastAuctionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PastAuctionCell"];
}

-(void)registerNibPastAuctionItemCollectionView:(UICollectionView*)collectionView
{
    [collectionView registerNib:[UINib nibWithNibName:@"PastDefaultGridCell" bundle:nil] forCellWithReuseIdentifier:@"PastDefaultGridCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"PastSelectedGridCell" bundle:nil] forCellWithReuseIdentifier:@"PastSelectedGridCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"PastDefaultListCell" bundle:nil] forCellWithReuseIdentifier:@"PastDefaultListCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"CurrentSelectedListCell" bundle:nil] forCellWithReuseIdentifier:@"SelectedListCell"];
}

-(CurrentAuctionCollectionViewCell*)configureDefalutGridCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath currentAuction:(CurrentAuction*)currentAuction
{
    CurrentAuctionCollectionViewCell *defaultCell;
    if (self.isList)
    {
        if (currentAuction.auctionType == AuctionTypeCurrent)
        {
            defaultCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"DefaultListCell" forIndexPath:indexPath];
        
            defaultCell.clvAction_Leading.constant =  defaultCell.viewSwip.frame.size.width/4;
            defaultCell.arrAction = @[@{@"image":@"icon-bid-now.png",
                                        @"title":@"Bid\nNow"},
                                      @{@"image":@"icon-proxy-bid.png",
                                        @"title":@"Proxy\nBid"},
                                      @{@"image":@"icon-detail.png",
                                        @"title":@"Lot\nDetail"},
                                      @{@"image":@"icon-bid-history.png",
                                        @"title":@"Bid\nHistory"}];
            
            if (currentAuction.isSwipOn == 1)
            {
                defaultCell.viewSwip.frame = CGRectMake((defaultCell.viewSwip.frame.size.width/4) - defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.origin.y, defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.size.width);
            }
            else
            {
                defaultCell.viewSwip.frame = CGRectMake(5, defaultCell.viewSwip.frame.origin.y, defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.size.width);
            }

        }
        else if (currentAuction.auctionType == AuctionTypeUpcoming)
        {
            defaultCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"UpcomingDefaultListCell" forIndexPath:indexPath];
            
            defaultCell.clvAction_Leading.constant = defaultCell.viewSwip.frame.size.width/2;
            defaultCell.arrAction = @[@{@"image":@"icon-proxy-bid.png",
                                        @"title":@"Proxy\nBid"},
                                      @{@"image":@"icon-detail.png",
                                        @"title":@"Lot\nDetail"}];
            
            if (currentAuction.isSwipOn == 1)
            {
                defaultCell.viewSwip.frame = CGRectMake(-(defaultCell.viewSwip.frame.size.width/2), defaultCell.viewSwip.frame.origin.y, defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.size.width);
            }
            else
            {
                defaultCell.viewSwip.frame = CGRectMake(5, defaultCell.viewSwip.frame.origin.y, defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.size.width);
            }
        }
        else
        {
            defaultCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PastDefaultListCell" forIndexPath:indexPath];
            
            defaultCell.clvAction_Leading.constant = defaultCell.viewSwip.frame.size.width - defaultCell.viewSwip.frame.size.width/4;
            defaultCell.arrAction = @[@{@"image":@"icon-detail.png",
                                        @"title":@"Lot\nDetail"}];

            if (currentAuction.isSwipOn == 1)
            {
                defaultCell.viewSwip.frame = CGRectMake(-(defaultCell.viewSwip.frame.size.width/4), defaultCell.viewSwip.frame.origin.y, defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.size.width);
            }
            else
            {
                defaultCell.viewSwip.frame = CGRectMake(5, defaultCell.viewSwip.frame.origin.y, defaultCell.viewSwip.frame.size.width, defaultCell.viewSwip.frame.size.width);
            }
        }
        
        [defaultCell.clvAction registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellWithReuseIdentifier:@"ActionCell"];
        defaultCell.clvAction.delegate = defaultCell;
        defaultCell.clvAction.dataSource = defaultCell;
        
        [defaultCell setupSwipGesture];
    }
    else
    {
        if (currentAuction.auctionType == AuctionTypeCurrent)
        {
            defaultCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"DefaultGridCell" forIndexPath:indexPath];
        }
        else if (currentAuction.auctionType == AuctionTypeUpcoming)
        {
            defaultCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"UpcomingDefaultGridCell" forIndexPath:indexPath];
        }
        else
        {
            defaultCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PastDefaultGridCell" forIndexPath:indexPath];
        }
    }
    
    defaultCell.currentAuction = currentAuction;
    
    defaultCell.cellIndexPath = indexPath;
    
    defaultCell.cellClv = collectionView;

    defaultCell.delegate = self;
    
    defaultCell.imgProduct.tag = indexPath.row;
    NSString *strImgUrl = [[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], currentAuction.strthumbnail] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    defaultCell.imgProduct.imageURL=[NSURL URLWithString:strImgUrl];
    
    if ([currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
    {
        defaultCell.lblArtistName.text = @"";
        defaultCell.lblArtistName.hidden= YES;
    }
    else
    {
        defaultCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",currentAuction.strFirstName,currentAuction.strLastName];
        defaultCell.lblArtistName.hidden= NO;
    }
    
    defaultCell.lblProductName.text= currentAuction.strtitle;
    
    defaultCell.btnAdd_DeleteGallery.tag=indexPath.row;
    
    if (self.isMyAuctionGallary)
    {
        [defaultCell.btnAdd_DeleteGallery setImage:[UIImage imageNamed:@"icon-remove.png"] forState:UIControlStateNormal];
    }
    else if (currentAuction.auctionType == AuctionTypeUpcoming)
    {
        [defaultCell.btnAdd_DeleteGallery setImage:[UIImage imageNamed:@"icon-add-to-gallery.png"] forState:UIControlStateNormal];
    }

    defaultCell.btnMaximizeImage.tag=indexPath.row;
    defaultCell.btnShortInfo.tag=indexPath.row;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        defaultCell.lblCurrentBid.text = currentAuction.formatedCurrentBidPriceUS;
        defaultCell.lblNextValidBid.text = currentAuction.formatedNextValidBidPriceUS;
        if (currentAuction.auctionType == AuctionTypePast)
        {
            defaultCell.lblCurrentBid.text = currentAuction.formatedWinPriceUS;
        }
    }
    else
    {
        defaultCell.lblCurrentBid.text = currentAuction.formatedCurrentBidPriceRS;
        defaultCell.lblNextValidBid.text = currentAuction.formatedNextValidBidPriceRS;
        if (currentAuction.auctionType == AuctionTypePast)
        {
            defaultCell.lblCurrentBid.text = currentAuction.formatedWinPriceRS;
        }
    }
    
    defaultCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@", currentAuction.strreference];
    [GlobalClass setBorder:defaultCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
    
    if (currentAuction.auctionType == AuctionTypeCurrent)
    {
        if ([GlobalClass isUserLeadingOnLot:[currentAuction.strmyuserid intValue]])
        {
            defaultCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
        }
        else
        {
            defaultCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
        }
        
        if ([GlobalClass isAuctionClosed:currentAuction.strtimeRemains])
        {
            defaultCell.lblCountdown.text = @"Auction Closed";
        }
        else
        {
            defaultCell.lblCountdown.text = currentAuction.formatedBidClosingTime;
        }
    }
    else if (currentAuction.auctionType == AuctionTypePast)
    {
        if ([currentAuction.strpricelow  intValue] > [currentAuction.strBidpricers intValue] )
        {
            defaultCell.lblCurrentBid.text = @"Bought In";
            defaultCell.lblInclusiveStaticText.text = @"";
        }
        else
        {
            defaultCell.lblInclusiveStaticText.text = @"(Inclusive of 15% Buyers Premium)";
        }
    }
    return defaultCell;
}

-(CurrentAuctionCollectionViewCell*)configureShortInfoCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath currentAuction:(CurrentAuction*)currentAuction
{
    CurrentAuctionCollectionViewCell *shortInfoCell;
    
    if (self.isList)
    {
            shortInfoCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectedListCell" forIndexPath:indexPath];

        shortInfoCell.imgProduct.tag = indexPath.row;
        
        NSString *strImgUrl = [[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], currentAuction.strthumbnail] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        shortInfoCell.imgProduct.imageURL = [NSURL URLWithString:strImgUrl];
    }
    else
    {
        if (currentAuction.auctionType == AuctionTypeCurrent)
        {
            shortInfoCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectedGridCell" forIndexPath:indexPath];
        }
        else if (currentAuction.auctionType == AuctionTypeUpcoming)
        {
            shortInfoCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"UpcomingSelectedGridCell" forIndexPath:indexPath];
        }
        else
        {
            shortInfoCell = (CurrentAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PastSelectedGridCell" forIndexPath:indexPath];
        }
    }
    
    shortInfoCell.delegate = self;
    
    shortInfoCell.currentAuction = currentAuction;
    
    shortInfoCell.cellIndexPath = indexPath;
    
    shortInfoCell.cellClv = collectionView;

    shortInfoCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@", currentAuction.strreference];
    [GlobalClass setBorder:shortInfoCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
    
    if ([currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
    {
        shortInfoCell.lblArtistText.text = @"Title:";
        shortInfoCell.lblArtistName.text = currentAuction.strtitle;
    
        shortInfoCell.lblMediumText.text = @"Description";
        shortInfoCell.lblMedium.text= [GlobalClass convertHTMLTextToPlainText:currentAuction.strPrdescription];
        
        shortInfoCell.lblYearText.text = @"";
        shortInfoCell.lblYear.text = @"";
        
        shortInfoCell.lblSize.text = [NSString stringWithFormat:@"%@ in",currentAuction.strproductsize];
    }
    else
    {
        shortInfoCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",currentAuction.strFirstName, currentAuction.strLastName];
        shortInfoCell.lblMedium.text = currentAuction.strmedium;
        shortInfoCell.lblYear.text = currentAuction.strproductdate;
        shortInfoCell.lblSize.text = [NSString stringWithFormat:@"%@ in",currentAuction.strproductsize];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        shortInfoCell.lblEstimate.text = currentAuction.strestamiate;
        shortInfoCell.lblCurrentBid.text = currentAuction.formatedCurrentBidPriceUS;
        shortInfoCell.lblNextValidBid.text = currentAuction.formatedNextValidBidPriceUS;
    }
    else
    {
        shortInfoCell.lblEstimate.text = currentAuction.strcollectors;
        shortInfoCell.lblCurrentBid.text = currentAuction.formatedCurrentBidPriceRS;
        shortInfoCell.lblNextValidBid.text = currentAuction.formatedNextValidBidPriceRS;
    }
    
    shortInfoCell.btnBidNow.tag = indexPath.row;
    shortInfoCell.btnProxy.tag = indexPath.row;
    shortInfoCell.btnDetail.tag = indexPath.row;
    
    
    if (currentAuction.auctionType == AuctionTypeCurrent)
    {
        if (!self.isList)
        {
            if ([GlobalClass isAuctionClosed:currentAuction.strtimeRemains])
            {
                shortInfoCell.lblCountdown.text = @"Auction Closed";
                
                shortInfoCell.btnBidNow.enabled = NO;
                shortInfoCell.btnProxy.enabled = NO;
                
                shortInfoCell.btnBidNow.backgroundColor = [UIColor grayColor];
                shortInfoCell.btnProxy.backgroundColor = [UIColor grayColor];
            }
            else
            {
                shortInfoCell.lblCountdown.text = currentAuction.formatedBidClosingTime;
                
                shortInfoCell.btnBidNow.enabled = YES;
                shortInfoCell.btnProxy.enabled = YES;
                
                shortInfoCell.btnBidNow.backgroundColor = [UIColor blackColor];
                shortInfoCell.btnProxy.backgroundColor = [UIColor blackColor];
            }
        }
        
        if ([GlobalClass isUserLeadingOnLot:[currentAuction.strmyuserid intValue]])
        {
            shortInfoCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
            shortInfoCell.lblLeadingText.hidden = NO;
            if ([GlobalClass isAuctionClosed:currentAuction])
            {
                shortInfoCell.lblLeadingText.text = @"Lot won";
            }
            else
            {
                shortInfoCell.lblLeadingText.text = @"You are currently the highest bidder.";
            }
            shortInfoCell.btnBidNow.hidden = YES;
            shortInfoCell.btnProxy.hidden = YES;
            
        }
        else
        {
            shortInfoCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
            shortInfoCell.lblLeadingText.hidden = YES;
            shortInfoCell.btnBidNow.hidden = NO;
            shortInfoCell.btnProxy.hidden = NO;
        }
    }
    return shortInfoCell;
}
-(UpcommingAuctionCollectionViewCell*)configureUpcomingAuctionCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath upcomingAuction:(UpcommingAuction*)upcommingAuction
{
    UpcommingAuctionCollectionViewCell *upcommingCell = (UpcommingAuctionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"UpcomingAuctionCell" forIndexPath:indexPath];

    [GlobalClass setBorder:upcommingCell cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
    
    NSString *strImgUrl = [[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], upcommingAuction.strImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    upcommingCell.imgProduct.imageURL =  [NSURL URLWithString:strImgUrl];
    
    upcommingCell.lblProductName.text = [GlobalClass convertHTMLTextToPlainText:upcommingAuction.strAuctionname];
    upcommingCell.lblAuctionDate.text = upcommingAuction.strDate;
    return upcommingCell;
}

-(PastAuctionCollectionViewCell*)configurePastAuctionCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath pastAuction:(PastAuction*)pastAuction
{
    PastAuctionCollectionViewCell *pastCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastAuctionCell" forIndexPath:indexPath];
    
    [GlobalClass setBorder:pastCell cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
    
    NSString *strImgUrl = [[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], pastAuction.strImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    pastCell.imgProduct.imageURL =  [NSURL URLWithString:strImgUrl];
    pastCell.lblProductName.text = [GlobalClass convertHTMLTextToPlainText:pastAuction.strAuctiontitle];
    pastCell.lblAuctionDate.text= pastAuction.strAuctiondate;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        pastCell.lblTotlaSaleValue.text = [NSString stringWithFormat:@"$%@",pastAuction.strTotalSaleValueUs];
    }
    else
    {
        pastCell.lblTotlaSaleValue.text=[NSString stringWithFormat:@"₹%@",pastAuction.strTotalSaleValueRs];
    }
    return pastCell;
}

-(AuctionItemTopBannerCollectionViewCell*)configureAuctionItemTopBannerCollectionViewCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath bannerName:(NSString*)bannerName
{
    AuctionItemTopBannerCollectionViewCell *topBannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopBannerCell" forIndexPath:indexPath];
    topBannerCell.cellClv = collectionView;
    if (self.isList)
    {
        [topBannerCell.btnGrid setImage:[UIImage imageNamed:@"icon-Grid-Def"] forState:UIControlStateNormal];
        [topBannerCell.btnList setImage:[UIImage imageNamed:@"icon-list-sel"] forState:UIControlStateNormal];
    }
    else
    {
        [topBannerCell.btnGrid setImage:[UIImage imageNamed:@"icon-grid"] forState:UIControlStateNormal];
        [topBannerCell.btnList setImage:[UIImage imageNamed:@"icon-list"] forState:UIControlStateNormal];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        topBannerCell.lblCurrency.text=@"USD";
    }
    else
    {
        topBannerCell.lblCurrency.text=@"INR";
    }
    
    NSString *strBannerImgUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], bannerName]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    topBannerCell.bannerImageView.imageURL = [NSURL URLWithString:strBannerImgUrl];
    return topBannerCell;
}

-(UICollectionViewCell*)configureBlankCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath
{
    static NSString *identifier = @"blankcell";
    
    UICollectionViewCell *blankcell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return blankcell;
}

-(NSArray*)arrBottomMenu
{
    return [[NSArray alloc] initWithObjects:@"HOME",@"AUCTION",@"UPCOMING",@"PAST", nil];
}

-(BottomMenuCollectionViewCell*)configureBottomMenuCell:(UICollectionView*)collectionView IndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bMenuCell";
    BottomMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.lblMenuName.text = [[self arrBottomMenu] objectAtIndex:indexPath.row];
    cell.btnLive.hidden = YES;
    [GlobalClass setBorder:cell.btnLive cornerRadius:4 borderWidth:1 color:[UIColor clearColor]];
    
    if (indexPath.row == 1)
    {
        cell.btnLive.hidden = NO;
    }
    
    if (indexPath.row == self.selectedBMenu)
    {
        cell.lblMenuName.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
        cell.lblSelectedLine.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
    }
    else
    {
        cell.lblMenuName.textColor=[UIColor blackColor];
        cell.lblSelectedLine.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
    }
    return cell;
}

-(void)didSelectBottomMenu:(NSInteger)selectedMenu
{
    switch (selectedMenu)
    {
        case 0:
        {
            if (![self.navigationController.topViewController isKindOfClass:[HomeViewController class]])
            {
                [self showHomeViewController];
            }
            break;
        }
        case 1:
        {
            if (![self.navigationController.topViewController isKindOfClass:[CurrentAuctionViewController class]])
            {
                [self showCurrentAuctionViewController];
            }
            break;
        }
        case 2:
        {
            if (![self.navigationController.topViewController isKindOfClass:[UpcommingAuctionViewController class]])
            {
                UpcommingAuctionViewController *upcommingAuctionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpcommingAuctionViewController"];
                upcommingAuctionVC.selectedBMenu = 2;
                UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:upcommingAuctionVC];
                [self.revealViewController setFrontViewController:nvc];
                [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];
            }
            break;
        }
        case 3:
        {
            if (![self.navigationController.topViewController isKindOfClass:[PastAuctionViewController class]])
            {
                PastAuctionViewController *pastAuctionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PastAuctionViewController"];
                pastAuctionVC.selectedBMenu = 3;
                UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:pastAuctionVC];
                [self.revealViewController setFrontViewController:nvc];
                [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];
            }
            break;
        }
        default:
            break;
    }
}

-(void)showCurrentAuctionViewController
{
    CurrentAuctionViewController *currentAuctionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentAuctionViewController"];
    currentAuctionVC.selectedBMenu = 1;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:currentAuctionVC];
    [self.revealViewController setFrontViewController:nvc];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];

}

-(void)showHomeViewController
{
    HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self.revealViewController setFrontViewController:nvc];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated: YES];
}

-(UITapGestureRecognizer*)addTapGestureOnView:(UIView*)view
{
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapGesture];
    return tapGesture;
}

-(void)showAlertWithMessage:(NSString*)message
{
    AlertViewController *alertVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    alertVC.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:.5f];
    alertVC.alertText = message;
    [self.navigationController addChildViewController:alertVC];
    [self.navigationController.view addSubview:alertVC.view];
    
//    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:message  preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)zoomImage:(CurrentAuction *)currentAuction fromImageView:(EGOImageView*)imageView
{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], currentAuction.strimage]];
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    imageInfo.referenceContentMode = imageView.contentMode;
    imageInfo.referenceCornerRadius = imageView.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];

}

-(void)showArtistInfo:(CurrentAuction*)currentAuction
{
    ArtistViewController *objArtistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
    objArtistViewController.currentAuction = currentAuction;
    [self.navigationController pushViewController:objArtistViewController animated:YES];
}

-(void)showProductDetail:(CurrentAuction*)currentAuction
{
    ProductDetailViewController *productDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    productDetailVC.currentAuction = currentAuction;
    [self.navigationController pushViewController:productDetailVC animated:YES];

}

-(void)showBidHistory:(CurrentAuction*)currentAuction
{
    if ([GlobalClass isAuctionClosed:currentAuction.strtimeRemains])
    {
        [self showAlertWithMessage:@"Sorry! This auction is closed"];
    }
    else
    {
        BidHistoryViewController *bidHistoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
        bidHistoryVC.currentAuction = currentAuction;
        [self.navigationController pushViewController:bidHistoryVC animated:YES];
    }
}

-(void)showAdditionalCharges:(CurrentAuction*)currentAuction
{
    AdditionalChargesViewController *objAdditionalChargesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditionalChargesViewController"];
    objAdditionalChargesViewController.currentAuction = currentAuction;
    [self.navigationController pushViewController:objAdditionalChargesViewController animated:YES];
}
-(void)gotoLoginVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    BeforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BeforeLoginViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

-(void)gotoVerificationVC
{
    [GlobalClass showTost:@"Your are not Verified"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
    rootViewController.isRegistration = NO;
    [self.navigationController pushViewController:rootViewController animated:YES];
}

-(void)didSelectListGrid:(UICollectionView*)collectionView
{
    if (self.isList == 0)
    {
        self.isList = 1;
    }
    else
    {
        self.isList = 0;
    }
    [collectionView reloadData];
}

-(void)didCurrencyChanged:(UICollectionView*)collectionView
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUSD"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isUSD"];
    }
    [collectionView reloadData];
}

-(void)bidNow:(CurrentAuction*)currentAuction bidDelegate:(id)delegate
{
    if ([GlobalClass isAuctionClosed:currentAuction.strtimeRemains])
    {
        [self showAlertWithMessage:@"Sorry! This auction is closed"];
    }
    else if ([GlobalClass isUserLogin])
    {
        if ([GlobalClass isUserVerified])
        {
            if ([GlobalClass isUserBidAccess])
            {
                if ([[GlobalClass getUserID] intValue] == [currentAuction.strmyuserid intValue])
                {
                    [self showAlertWithMessage:@"You are currently the highest bidder on this lot."];
                }
                else
                {
                    BidNowViewController *bidNowVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BidNowViewController"];
                    bidNowVC.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:.5f];
                    bidNowVC.currentAuction = currentAuction;
                    bidNowVC.delegate = delegate;
                    [self.navigationController addChildViewController:bidNowVC];
                    [self.navigationController.view addSubview:bidNowVC.view];
                }
            }
            else
            {
                [self showAlertWithMessage:@"You don't have access to Bid. Please contact Astaguru"];
            }
        }
        else
        {
            [self gotoVerificationVC];
        }
    }
    else
    {
        [self gotoLoginVC];
    }
}

-(void)currentProxyBid:(CurrentAuction*)currentAuction bidDelegate:(id)delegate
{
    if ([GlobalClass isAuctionClosed:currentAuction.strtimeRemains])
    {
        [self showAlertWithMessage:@"Sorry! This auction is closed"];
    }
    else if ([GlobalClass isUserLogin])
    {
        if ([GlobalClass isUserVerified])
        {
            if ([GlobalClass isUserBidAccess])
            {
                if ([[GlobalClass getUserID] intValue] == [currentAuction.strmyuserid intValue])
                {
                    [self showAlertWithMessage:@"You are currently the highest bidder on this lot."];
                }
                else
                {
                    CurrentProxyBidViewController *proxyBidVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentProxyBidViewController"];
                    proxyBidVC.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:.5f];
                    proxyBidVC.currentAuction = currentAuction;
                    proxyBidVC.delegate = delegate;
                    [self.navigationController addChildViewController:proxyBidVC];
                    [self.navigationController.view addSubview:proxyBidVC.view];
                }
            }
            else
            {
                [self showAlertWithMessage:@"You don't have access to Bid. Please contact Astaguru"];
            }
        }
        else
        {
            [self gotoVerificationVC];
        }
    }
    else
    {
        [self gotoLoginVC];
    }
}

-(void)upcomingProxyBid:(CurrentAuction*)currentAuction bidDelegate:(id)delegate;
{
    if ([GlobalClass isUserLogin])
    {
        if ([GlobalClass isUserVerified])
        {
            if ([GlobalClass isUserBidAccess])
            {
                if ([[GlobalClass getUserID] intValue] == [currentAuction.strmyuserid intValue])
                {
                    [self showAlertWithMessage:@"You are currently the highest bidder on this lot."];
                }
                else
                {
                    UpcommingProxyBidViewController *upcomingProxyBidVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UpcommingProxyBidViewController"];
                    upcomingProxyBidVC.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:.5f];
                    upcomingProxyBidVC.currentAuction = currentAuction;
                    upcomingProxyBidVC.delegate = delegate;
                    [self.navigationController addChildViewController:upcomingProxyBidVC];
                    [self.navigationController.view addSubview:upcomingProxyBidVC.view];
                }
            }
            else
            {
                [self showAlertWithMessage:@"You don't have access to Bid. Please contact Astaguru"];
            }
        }
        else
        {
            [self gotoVerificationVC];
        }
    }
    else
    {
        [self gotoLoginVC];
    }
}

-(void)showFilter:(AuctionType)auctionType auctionName:(NSString*)auctionName auctionID:(NSString*)auctionID delegate:(id)delegate;
{
    FilterViewController *objFilterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    objFilterViewController.delegate = delegate;
    objFilterViewController.auctionType = auctionType;
    objFilterViewController.strAuctionName = auctionName;
    objFilterViewController.strAuctionId = auctionID;
    objFilterViewController.selectedBMenu = self.selectedBMenu;
    objFilterViewController.selecteArtistArray = [self.selectedFilterArray mutableCopy];
    [self.navigationController pushViewController:objFilterViewController animated:YES];
}

-(void)insertItemToMyAuctionGallery:(CurrentAuction*)currentAuction
{
    if ([GlobalClass isUserLogin])
    {
        NSString *strUrl = [NSString stringWithFormat:@"spAddToGallery(%@,%@)",currentAuction.strproductid, [GlobalClass getUserID]];
        [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject){
            [GlobalClass showTost:@"Item added to your auction gallery"];
            MyAuctionGalleryViewController *myAuctionGalleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
            [self.navigationController pushViewController:myAuctionGalleryVC animated:YES];
        }failure:^(NSError *error) {
            [GlobalClass showTost:error.localizedDescription];
        } callingCount:0];
    }
    else
    {
        [self gotoLoginVC];
    }
}

-(void)getAuctionByID:(CurrentAuction*)currentAuction view:(UIView*)view auction:(void (^)(CurrentAuction *currentAuction))auction 
{
    NSString  *url = [NSString stringWithFormat:@"defaultlots?api_key=%@&filter=productid=%@", [GlobalClass apiKey], currentAuction.strproductid];
    [GlobalClass call_tableGETWebURL:url parameters:nil view:view success:^(id responseObject){
        NSMutableArray *arrParese = [CurrentAuction parseAuction: responseObject[@"resource"] auctionType:currentAuction.auctionType];
        if (arrParese.count > 0)
        {
            auction(arrParese[0]);
        }
    } failure:^(NSError *error){} callingCount:0];
}

-(void)getUserProfile:(void (^)(NSDictionary *userProfile))profile
{
    NSString *url = [NSString stringWithFormat:@"users/?api_key=%@&filter=userid=%@", [GlobalClass apiKey], [GlobalClass getUserID]];
    
    [GlobalClass call_tableGETWebURL:url parameters:nil view:self.view success:^(NSDictionary *responseObject)
     {
         NSMutableArray *resourceArray = responseObject[@"resource"];
         if (resourceArray.count > 0)
         {
             NSDictionary *userDic = [GlobalClass removeNullOnly:[resourceArray objectAtIndex:0]];
             profile(userDic);
         }
         else
         {
             [GlobalClass showTost:@"User profile not found"];
         }
     }failure:^(NSError *error)
     {
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
