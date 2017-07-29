//
//  DetailProductViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 03/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "AdditionalChargesViewController.h"
#import "ProductDetailTableViewCell.h"
#import "BidNowViewController.h"
#import "CurrentProxyBidViewController.h"
#import "UpcommingProxyBidViewController.h"

#define artistImage_Height 240;
#define font [UIFont fontWithName:@"WorkSans-Regular" size:16]

@interface ProductDetailViewController ()<UIGestureRecognizerDelegate, BidNowViewControllerDelegate, ProxyBidViewControllerDelegate, UpcommingProxyBidViewControllerDelegate>
{
    int ISMore;
    NSTimer *timer;
}
@end

@implementation ProductDetailViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title=[NSString stringWithFormat:@"Lot %@", self.currentAuction.strreference];
//    [self setNavigationBarBackButton];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    
    [ self setUpNavigationItem];
    
    ISMore = 0;

    self.productDetail_TableView.estimatedRowHeight = 100.0;
    self.productDetail_TableView.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.currentAuction.auctionType == AuctionTypeCurrent)
    {
        timer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(getBidPrice) userInfo:nil repeats:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

// Here we refresh the bid vslue
-(void)getBidPrice
{
    [self getAuctionByID:self.currentAuction view:nil auction:^(CurrentAuction *currentAuction){
        self.currentAuction = currentAuction;
        [self.productDetail_TableView reloadData];
    }];

//    NSString  *strUrl = [NSString stringWithFormat:@"spGetBidPrice(%@)",self.currentAuction.strproductid];
//    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
//     {
//         NSMutableArray *auctionArray = (NSMutableArray*)responseObject;
//         if (auctionArray.count > 0)
//         {
//             NSDictionary *priceDic = auctionArray[0];
//             self.currentAuction.strpricers = priceDic[@"pricers"];
//             self.currentAuction.strpriceus = priceDic[@"priceus"];
//             self.currentAuction.strBidclosingtime = priceDic[@"Bidclosingtime"];
//             self.currentAuction.strCurrentDate = priceDic[@"currentDate"];
//             self.currentAuction.strmyuserid = priceDic[@"MyUserID"];
//             [self.productDetail_TableView reloadData];
//         }
//     } failure:^(NSError *error){
//         [GlobalClass showTost:error.localizedDescription];
//     }];
    
}

//-(void)searchPressed
//{
//    [ClsSetting Searchpage:self.navigationController];
//}
//-(void)myastaguru
//{
//    [ClsSetting myAstaGuru:self.navigationController];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [timer invalidate];
    timer = nil;
}

#pragma mark - Convenience =
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reload
{
    [self.productDetail_TableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentAuction.auctionType == AuctionTypeCurrent)
    {
        if ([GlobalClass isAuctionClosed:self.currentAuction.strtimeRemains])
        {
            return 7;
        }
        else
        {
            return 8;
        }
    }
    else if (self.currentAuction.auctionType == AuctionTypeUpcoming || self.currentAuction.auctionType == AuctionTypePast)
    {
        return 7;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProductImageCell" forIndexPath:indexPath];
    }
    else if (indexPath.row == 1)
    {
        if (self.currentAuction.auctionType == AuctionTypeCurrent)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"currentBidPriceCell" forIndexPath:indexPath];

        }
        else if (self.currentAuction.auctionType == AuctionTypeUpcoming || self.currentAuction.auctionType == AuctionTypePast)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"upcommingPastBidPriceCell" forIndexPath:indexPath];

        }
    }
    else if (indexPath.row == 2)
    {
        if (self.currentAuction.auctionType == AuctionTypeCurrent)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"currentBidButtonCell" forIndexPath:indexPath];
            
        }
        else if (self.currentAuction.auctionType == AuctionTypeUpcoming || self.currentAuction.auctionType == AuctionTypePast)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"upcommingBidButtonCell" forIndexPath:indexPath];
            
        }
    }
    else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"lotDescriptionCell" forIndexPath:indexPath];

    }
    else if (indexPath.row == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AdditionalInfoCell" forIndexPath:indexPath];
    }
    else if (indexPath.row == 5)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"artWorkSizeCell" forIndexPath:indexPath];
    }
    else if (indexPath.row == 6)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"aboutArtistCell" forIndexPath:indexPath];
    }
    else if (indexPath.row == 7)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"bidHistoryBtnCell" forIndexPath:indexPath];
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[ProductDetailTableViewCell class]])
    {
        ProductDetailTableViewCell *pcell = (ProductDetailTableViewCell*)cell;

        if (indexPath.row == 0)
        {
            //ProductImageCell
            pcell.productImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], self.currentAuction.strimage]];
            pcell.productImage.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
            
            tapGesture1.numberOfTapsRequired = 1;
            
            [tapGesture1 setDelegate:self];
            
            [pcell.productImage addGestureRecognizer:tapGesture1];
            
        }
        else if (indexPath.row == 1)
        {
            // currentBidPriceCell or upcommingPastBidPriceCell
            
            pcell.lbl_ProductTitle.text=[NSString stringWithFormat:@"%@",self.currentAuction.strtitle];
            
            if ([self.currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
            {
                pcell.lbl_ArtistTitle.text = @"";
            }
            else
            {
                pcell.lbl_ArtistTitle.text=[NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName,self.currentAuction.strLastName];
            }
            
//            NSString *strPriceUS = [NSString stringWithFormat:@"%@",self.currentAuction.strpriceus];
//            int priceUS = [strPriceUS intValue];
//            
//            NSString *strPriceRS = [NSString stringWithFormat:@"%@",self.currentAuction.strpricers];
//            
//            int priceRS = [strPriceRS intValue];
//            
//            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
//            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
//            [numberFormatter setMaximumFractionDigits:0];
//            
//            NSString *strCurrentBidPrice;
//            NSString *strNextValidBidPrice;
//            NSString *strWinBidPrice;
//
//            int currentBidPrice = 0;
//            int nextValidBidPrice = 0;
//            int winBidPrice = 0;
//
//            int priceIncreaseRate = 0;
//            
//            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
//            {
//                numberFormatter.currencyCode = @"USD";
//                currentBidPrice = priceUS;
//            }
//            else
//            {
//                numberFormatter.currencyCode = @"INR";
//                currentBidPrice = priceRS;
//            }
            
            if (self.currentAuction.auctionType == AuctionTypeCurrent)
            {
//                if (priceRS > 10000000)
//                {
//                    priceIncreaseRate = (currentBidPrice * 5)/100;
//                }
//                else
//                {
//                    priceIncreaseRate = (currentBidPrice * 10)/100;
//                }
//                
//                nextValidBidPrice = currentBidPrice + priceIncreaseRate;
//                
//                strCurrentBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:currentBidPrice]];
                
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                {
                    pcell.lbl_CurrentBidPrice.text = self.currentAuction.formatedCurrentBidPriceUS;
                    pcell.lbl_NextValidBidPrice.text = self.currentAuction.formatedNextValidBidPriceUS;
                }
                else
                {
                    pcell.lbl_CurrentBidPrice.text = self.currentAuction.formatedCurrentBidPriceRS;
                    pcell.lbl_NextValidBidPrice.text = self.currentAuction.formatedNextValidBidPriceRS;
                }
                
//                strNextValidBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:nextValidBidPrice]];
                
//                NSString *timeStr=[self timercount:self.currentAuction.strBidclosingtime fromDate:self.currentAuction.strCurrentDate];
                
                if ([GlobalClass isAuctionClosed:self.currentAuction.strtimeRemains])
                {
                    pcell.lbl_CountdownValue.text = @"Auction Closed";
                }
                else
                {
                    pcell.lbl_CountdownValue.text = self.currentAuction.formatedBidClosingTime;
                }
            }
            else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
            {
                pcell.lbl_WinningBidText.text = @"Start Price";
                
//                strCurrentBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:currentBidPrice]];
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                {
                    pcell.lbl_WinningBidPrice.text= self.currentAuction.formatedCurrentBidPriceRS;
                }
                else
                {
                    pcell.lbl_WinningBidPrice.text= self.currentAuction.formatedCurrentBidPriceUS;
                }
                
                pcell.lbl_InclusiveText.text = @"";
            }
            else if (self.currentAuction.auctionType == AuctionTypePast)
            {
                if ([self.currentAuction.strpricelow  integerValue] > [self.currentAuction.strBidpricers integerValue])
                {
                    pcell.lbl_WinningBidText.text = @"";
                    pcell.lbl_WinningBidPrice.text = @"Bought In";
                    pcell.lbl_InclusiveText.text = @"";
                }
                else
                {
                    pcell.lbl_WinningBidText.text = @"Winning Price";
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        pcell.lbl_WinningBidPrice.text = self.currentAuction.formatedWinPriceUS;
                    }
                    else
                    {
                        pcell.lbl_WinningBidPrice.text = self.currentAuction.formatedWinPriceRS;
                    }
                }
            }
        }
        else if (indexPath.row == 2)
        {
            // currentBidButtonCell or upcommingBidButtonCell
            if (self.currentAuction.auctionType == AuctionTypeCurrent)
            {
//                NSString *timeStr=[self timercount:self.currentAuction.strBidclosingtime fromDate:self.currentAuction.strCurrentDate];
                if ([GlobalClass isAuctionClosed:self.currentAuction.strtimeRemains])
                {
                    pcell.btn_BidNow.enabled = NO;
                    pcell.bnt_Proxybid.enabled = NO;
                    pcell.btn_BidNow.backgroundColor = [UIColor grayColor];
                    pcell.bnt_Proxybid.backgroundColor = [UIColor grayColor];
                }
                else
                {
                    pcell.btn_BidNow.enabled = YES;
                    pcell.bnt_Proxybid.enabled = YES;
                    pcell.btn_BidNow.backgroundColor = [UIColor blackColor];
                    pcell.bnt_Proxybid.backgroundColor = [UIColor blackColor];
                }
                
                if ([GlobalClass isUserLogin])
                {
                    if ([[GlobalClass getUserID] integerValue] == [self.currentAuction.strmyuserid integerValue])
                    {
                        pcell.btn_BidNow.hidden = YES;
                        pcell.bnt_Proxybid.hidden = YES;
                        pcell.lbl_LeadingText.hidden = NO;
                    }
                    else
                    {
                        pcell.btn_BidNow.hidden = NO;
                        pcell.bnt_Proxybid.hidden = NO;
                        pcell.lbl_LeadingText.hidden = YES;
                    }
                }
            }
            else if (self.currentAuction.auctionType == AuctionTypePast)
            {
                pcell.btn_AddMyAuctionGallary.hidden = YES;
                pcell.bnt_Proxybid.hidden = YES;
            }
        }
        else if (indexPath.row == 3)
        {
            //            lotDescriptionCell
            if ([self.currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
            {
                pcell.lbl_ArtistText.text = @"";
                pcell.lbl_ArtistName.text = @"";
                
                NSString *strDesc = [GlobalClass convertHTMLTextToPlainText:self.currentAuction.strPrdescription];
                pcell.lbl_Description.text = strDesc;
                
                pcell.lbl_MediumText.text = @"";
                pcell.lbl_Medium.text = @"";
                
                pcell.lbl_YearText.text = @"";
                pcell.lbl_Year.text = @"";
                
                pcell.lbl_Size.text = [NSString stringWithFormat:@"%@ in",self.currentAuction.strproductsize];
            }
            else
            {
                pcell.lbl_ArtistName.text=[NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName,self.currentAuction.strLastName];
                
                pcell.lbl_DescriptionText.text = @"";
                pcell.lbl_Description.text = @"";
                
                pcell.lbl_Medium.text=[NSString stringWithFormat:@"%@",self.currentAuction.strmedium];
                pcell.lbl_Year.text=[NSString stringWithFormat:@"%@",self.currentAuction.strproductdate];
                pcell.lbl_Size.text=[NSString stringWithFormat:@"%@ in",self.currentAuction.strproductsize];
            }
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
            {
                pcell.lbl_Estimate.text=self.currentAuction.strestamiate;
            }
            else
            {
                pcell.lbl_Estimate.text=self.currentAuction.strcollectors;
            }
            
            [GlobalClass setBorder:pcell.btn_BidHistory cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
            
            if (self.currentAuction.auctionType == AuctionTypePast)
            {
                pcell.btn_ViewAdditionalCharges.hidden= YES;
                pcell.btn_ViewAdditionalCharges_Height.constant = 0;
            }
        }
        else if (indexPath.row == 4)
        {
            //AdditionalInfoCell
            /*NSString *strAdditionalInfo = self.currentAuction.strdescription;
            NSDictionary *dictAttribute = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.alignment                = NSTextAlignmentJustified;
            
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithData:[strAdditionalInfo dataUsingEncoding:NSUTF8StringEncoding] options:dictAttribute documentAttributes:nil error:nil];
            [attributedStr beginEditing];
            [attributedStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
             {
                 if (value)
                 {
                     //Remove old font attribute
                     [attributedStr removeAttribute:NSFontAttributeName range:range];
                     //replace your font with new.
                     // Add new font attribute
                     [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                     [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
                     [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
                 }
             }];
            [attributedStr endEditing];*/
            pcell.lbl_AdditionalInfo.attributedText = [GlobalClass getAttributedString:self.currentAuction.strdescription havingFont:font];
        }
        else if (indexPath.row == 5)
        {
            // artWorkSizeCell
            pcell.artWorkImage.imageURL=[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], self.currentAuction.strHumanFigure] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            pcell.lbl_artWorkSize.text = self.currentAuction.strproductsize;
        }
        else if (indexPath.row == 6)
        {
            //aboutArtistCell
            /*NSString *strAboutArtist = self.currentAuction.strProfile;
            NSDictionary *dictAttribute = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.alignment                = NSTextAlignmentJustified;
            
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithData:[strAboutArtist dataUsingEncoding:NSUTF8StringEncoding] options:dictAttribute documentAttributes:nil error:nil];
            [attributedStr beginEditing];
            [attributedStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
             {
                 if (value)
                 {
                     //Remove old font attribute
                     [attributedStr removeAttribute:NSFontAttributeName range:range];
                     //replace your font with new.
                     //Add new font attribute
                     [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                     [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
                     
                     [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
                 }
             }];
            [attributedStr endEditing];*/
            pcell.lbl_aboutArtist.attributedText = [GlobalClass getAttributedString:self.currentAuction.strProfile havingFont:font];
            if(ISMore)
            {
                pcell.lbl_aboutArtist.numberOfLines = 0;
                [pcell.btn_ReadMore_ReadLess setTitle:@"Read Less" forState:UIControlStateNormal];
            }
            else
            {
                pcell.lbl_aboutArtist.numberOfLines = 3;
                [pcell.btn_ReadMore_ReadLess setTitle:@"Read More" forState:UIControlStateNormal];
            }
        }
        else
        {
            //bidHistoryBtnCell
            [GlobalClass setBorder:pcell.btn_BidHistory cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    v.backgroundColor=[UIColor clearColor];
    return v;
}

- (IBAction)btnBidNowPressed:(id)sender
{
    [self bidNow:self.currentAuction bidDelegate:self];
}

- (IBAction)btnProxyBidpressed:(id)sender
{
    if (self.currentAuction.auctionType == AuctionTypeCurrent)
    {
        [self currentProxyBid:self.currentAuction bidDelegate:self];
    }
    else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
    {
        [self upcomingProxyBid:self.currentAuction bidDelegate:self];
    }
    else
    {
    }
}

- (IBAction)btnMaximizepressed:(UIButton*)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ProductDetailTableViewCell *cell = [self.productDetail_TableView cellForRowAtIndexPath:indexPath];
    [self zoomImage:self.currentAuction fromImageView:cell.productImage];
}

- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    [self zoomImage:self.currentAuction fromImageView:(EGOImageView*)tapGesture.view];
}

- (IBAction)btnMyAuctionGalleryPressed:(id)sender
{
    [self insertItemToMyAuctionGallery:self.currentAuction];
}

- (IBAction)btnBidHistoryPressed:(id)sender
{
    [self showBidHistory:self.currentAuction];
}

- (IBAction)btnViewAdditionalChargesPressed:(id)sender
{
    [self showAdditionalCharges:self.currentAuction];
}

- (IBAction)btnReadmorepressed:(id)sender
{
    if (ISMore==0)
    {
        ISMore=1;
    }
    else
    {
        ISMore=0;
    }
    [_productDetail_TableView reloadData];
}

-(void)didBidCancel
{
    
}
-(void)didBidConfirm
{
    
}
-(void)didProxyBidCancel
{
    
}
-(void)didProxyBidConfirm
{
    
}
-(void)didUpcommingProxyBidCancel
{
    
}
-(void)didUpcommingProxyBidConfirm
{
    
}

@end
