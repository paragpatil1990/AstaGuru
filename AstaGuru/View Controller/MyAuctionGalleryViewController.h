//
//  MyAuctionGalleryViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 27/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAuctionGalleryViewController : UIViewController

@property int isCurrent;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvMyAuctionGallery;
@property (strong, nonatomic) IBOutlet UILabel *lblNoRecords;
@property (strong, nonatomic) IBOutlet UIButton *btnCurrent;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentLine;
@property (strong, nonatomic) IBOutlet UIButton *btnUpcomming;
@property (strong, nonatomic) IBOutlet UILabel *lblUpcommingLine;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrencyText;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrency;
@property (strong, nonatomic) IBOutlet UIButton *btnCurrency;

- (IBAction)btnCurrentAuctionPressed:(UIButton *)sender;
- (IBAction)btnUpcommingAuctionPressed:(UIButton *)sender;
- (IBAction)btnCurrencyPressed:(UIButton *)sender;

@end
