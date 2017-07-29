//
//  TOPCollectionViewCell.h
//  AstaGuru
//
//  Created by Aarya Tech on 01/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CurrentAuction.h"
@interface AuctionItemTopBannerCollectionViewCell : UICollectionViewCell

//@property (nonatomic, retain) CurrentAuction *currentAuction;
@property (nonatomic, retain) id delegate;
@property (nonatomic, strong) UICollectionView *cellClv;

@property (strong, nonatomic) IBOutlet EGOImageView *bannerImageView;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrency;
@property (strong, nonatomic) IBOutlet UIButton *btnCurrency;
@property (strong, nonatomic) IBOutlet UIButton *btnGrid;
@property (strong, nonatomic) IBOutlet UIButton *btnList;
@property (strong, nonatomic) IBOutlet UIView *lineView;

//Current,Upcoming,Past auction
@property (strong, nonatomic) IBOutlet UIButton *btnFilter;

//Past auction
@property (strong, nonatomic) IBOutlet UIButton *btnAuctionAnalysis;
@property (strong, nonatomic) IBOutlet UILabel *lblLineAnalysis;


//MyAuctionGallaryViewController
@property (strong, nonatomic) IBOutlet UIButton *btnCurrentAuction;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentAuctionSelectedLine;
@property (strong, nonatomic) IBOutlet UIButton *btnUpcomingAuction;
@property (strong, nonatomic) IBOutlet UILabel *lblUpcommingAuctionSelectedLine;

//Artist View controller
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgeArtist_Height;
@property (strong, nonatomic) IBOutlet EGOImageView *imgArtist;
@property (strong, nonatomic) IBOutlet UILabel *lblArtistName;
@property (strong, nonatomic) IBOutlet UILabel *lblArtistProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnMore;
@property (strong, nonatomic) IBOutlet UIButton *btnPastAuction;
@property (strong, nonatomic) IBOutlet UILabel *lblPastAuctionSelectedLine;

//- (IBAction)btnFilterPressed:(UIButton *)sender;
- (IBAction)btnAuctionAnalysisPressed:(UIButton *)sender;
- (IBAction)btnCurrencyPressed:(UIButton *)sender;
- (IBAction)btnGridPressed:(UIButton *)sender;
- (IBAction)btnListPressed:(UIButton *)sender;
- (IBAction)btnCurrentAuctionPressed:(UIButton *)sender;
- (IBAction)btnUpcomingAuctionPressed:(UIButton *)sender;
- (IBAction)btnPastAuctionPressed:(UIButton *)sender;
- (IBAction)btnReadMorePressed:(UIButton*)sender;

@end
