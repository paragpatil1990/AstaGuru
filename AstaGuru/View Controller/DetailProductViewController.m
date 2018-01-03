//
//  DetailProductViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 03/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "DetailProductViewController.h"
#import "SWRevealViewController.h"
#import "EGOImageView.h"
#import "ClsSetting.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "AuctionItemBidViewController.h"
#import "MyAuctionGalleryViewController.h"
#import "BidHistoryViewController.h"
#import "AdditionalChargesViewController.h"
#import "BforeLoginViewController.h"
#import "VerificationViewController.h"
#import "ProductDetailTableViewCell.h"

#define artistImage_Height 240;
#define font [UIFont fontWithName:@"WorkSans-Regular" size:16]

@interface DetailProductViewController ()<UIGestureRecognizerDelegate, AuctionItemBidViewControllerDelegate, PassResepose>
{
//    NSMutableArray *arrDescription;
    int ISMore;
    NSTimer *countDownTimer;
//    int IsAuctionClosed;
}
@end

@implementation DetailProductViewController

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    
    ISMore = 0;

    self.productDetail_TableView.estimatedRowHeight = 500.0;
    self.productDetail_TableView.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

//- (void)configureBackButton
//{
//    //Yogesh
//    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [btnBack setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
//    [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
//    self.navigationItem.leftBarButtonItem = barButtonItem;
//}

- (void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
    
    self.navigationItem.title=[NSString stringWithFormat:@"Lot %@",_objCurrentOccution.strReference];
    
    if (_IsCurrent == 1 || _IsMyAuctionGallary == 1)
    {
        countDownTimer =[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(getBidPrice) userInfo:nil repeats:YES];
    }
    [self.productDetail_TableView reloadData];
    //[self checkMore];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.backItem.title = @"Back";
}

-(void)refreshBidPrice
{
    [self getBidPrice];
}

-(void)cancelAuctionItemBidViewController
{
    
}
// Here we refresh the bid vslue
-(void)getBidPrice
{
    @try {
        
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetBidPrice(%@)?api_key=%@",[ClsSetting procedureURL],_objCurrentOccution.strproductid,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableDictionary *priceDic = [ClsSetting RemoveNull:dict[0]];// dict[0];
             NSLog(@"price = %@",priceDic);
        
             _objCurrentOccution.strpricers = priceDic[@"pricers"];;
             _objCurrentOccution.strpriceus = priceDic[@"priceus"];;
             _objCurrentOccution.strBidclosingtime = priceDic[@"Bidclosingtime"];
             _objCurrentOccution.strCurrentDate = priceDic[@"currentDate"];
             _objCurrentOccution.strmyuserid = priceDic[@"MyUserID"];
             NSString *closeingTime = priceDic[@"myBidClosingTime"];
             
             NSArray *timeArray = [closeingTime componentsSeparatedByString:@" "];
             
             NSString *dateString = [timeArray lastObject];//@"13:17:34.674194";
             NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
             dateFormatter.dateFormat = @"HH:mm:ss:SS";
             NSDate *yourDate = [dateFormatter dateFromString:dateString];
             dateFormatter.dateFormat = @"HH:mm:ss";
             _objCurrentOccution.strmyBidClosingTime = [NSString stringWithFormat:@"%@ %@", [timeArray objectAtIndex:0],[dateFormatter stringFromDate:yourDate]];
             _objCurrentOccution.strtimeRemains = priceDic[@"timeRemains"];
             
             [self.productDetail_TableView reloadData];
            // [self checkMore];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];
             }];
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}


-(void)setUpNavigationItem
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    

    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, -20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    
    UIButton *btnBack1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, -20)];
    [btnBack1 setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [btnBack1 addTarget:self action:@selector(myastaguru) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnBack1];
    UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -12;
    UIBarButtonItem *spaceFix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -8;
    [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem,spaceFix1, barButtonItem1]];
}

-(void)searchPressed
{
    [ClsSetting Searchpage:self.navigationController];
}
-(void)myastaguru
{
    [ClsSetting myAstaGuru:self.navigationController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [countDownTimer invalidate];
    countDownTimer = nil;
}

#pragma mark - Convenience =
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reload
{
    [self.productDetail_TableView reloadData];
    //[self checkMore];
}

- (void)checkMore
{
    if(ISMore)
    {
        NSInteger lastRowNumber = [self.productDetail_TableView numberOfRowsInSection:0] - 1;
        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.productDetail_TableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    else
    {
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_IsCurrent == 1)
    {
//        NSString *timeStr = [self timercount:_objCurrentOccution.strBidclosingtime fromDate:_objCurrentOccution.strCurrentDate];
        if ([_objCurrentOccution.strtimeRemains intValue] < 0)
        {
            return 7;
        }
        else
        {
            return 8;
        }
    }
    else if (_IsUpcomming == 1)
    {
        return 7;
    }
    else if (_IsPast == 1 || _IsArtwork == 1)
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"artistImageCell" forIndexPath:indexPath];
    }
    else if (indexPath.row == 1)
    {
        if (_IsCurrent == 1 || _IsMyAuctionGallary == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"currentBidPriceCell" forIndexPath:indexPath];

        }
        else if (_IsUpcomming == 1 || _IsPast == 1 || _IsArtwork == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"upcommingPastBidPriceCell" forIndexPath:indexPath];

        }
    }
    else if (indexPath.row == 2)
    {
        if (_IsCurrent == 1 || _IsMyAuctionGallary == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"currentBidButtonCell" forIndexPath:indexPath];
            
        }
        else if (_IsUpcomming == 1 || _IsPast == 1 || _IsArtwork == 1)
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
            //artistImageCell
            pcell.productImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], _objCurrentOccution.strimage]];
            pcell.productImage.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
            
            tapGesture1.numberOfTapsRequired = 1;
            
            [tapGesture1 setDelegate:self];
            
            [pcell.productImage addGestureRecognizer:tapGesture1];
            
        }
        else if (indexPath.row == 1)
        {
            // currentBidPriceCell or upcommingPastBidPriceCell
            
            pcell.lbl_ProductTitle.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strtitle];
            
           // if ([_objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
            if ([_objCurrentOccution.auctionType intValue] != 1)
            {
                pcell.lbl_ArtistTitle.text = @"";
            }
            else
            {
                pcell.lbl_ArtistTitle.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
            }
            
            NSString *strPriceUS = [NSString stringWithFormat:@"%@",_objCurrentOccution.strpriceus];
            NSInteger priceUS = [strPriceUS integerValue];
            
            NSString *strPriceRS = [NSString stringWithFormat:@"%@",_objCurrentOccution.strpricers];
            NSInteger priceRS = [strPriceRS integerValue];
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter setMaximumFractionDigits:0];
            
            NSString *strCurrentBidPrice;
            NSString *strNextValidBidPrice;
            NSString *strWinBidPrice;
            
            NSInteger currentBidPrice = 0;
            NSInteger nextValidBidPrice = 0;
            NSInteger winBidPrice = 0;
            
            NSInteger priceIncreaseRate = 0;
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                currentBidPrice = priceUS;
            }
            else
            {
                numberFormatter.currencyCode = @"INR";
                currentBidPrice = priceRS;
            }
            
            if (_IsCurrent == 1 || _IsMyAuctionGallary)
            {
                if (priceRS > 10000000)
                {
                    priceIncreaseRate = (currentBidPrice*5)/100;
                }
                else
                {
                    priceIncreaseRate = (currentBidPrice*10)/100;
                }
                
                nextValidBidPrice = currentBidPrice + priceIncreaseRate;
                
                strCurrentBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBidPrice]];
                
                pcell.lbl_CurrentBidPrice.text= strCurrentBidPrice;
                
                strNextValidBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:nextValidBidPrice]];
                pcell.lbl_NextValidBidPrice.text = strNextValidBidPrice;
                
//                NSString *timeStr=[self timercount:_objCurrentOccution.strBidclosingtime fromDate:_objCurrentOccution.strCurrentDate];
                if ([_objCurrentOccution.strtimeRemains intValue] < 0)
                {
                    pcell.lbl_CountdownValue.text = @"Auction Closed";
                }
                else
                {
                    pcell.lbl_CountdownValue.text = _objCurrentOccution.strmyBidClosingTime;
                }
            }
            else if (_IsUpcomming == 1)
            {
                pcell.lbl_WinningBidText.text = @"Opening Bid";//@"Start Price";
                
                strCurrentBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBidPrice]];
                pcell.lbl_WinningBidPrice.text= strCurrentBidPrice;
                
                pcell.lbl_InclusiveText.text = @"";
            }
            else if (_IsPast == 1 || _IsArtwork)
            {
                if ([_objCurrentOccution.strpricelow  intValue] > priceRS)
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
                        priceIncreaseRate = (priceUS*15)/100;
                        winBidPrice = priceUS + priceIncreaseRate;
                    }
                    else
                    {
                        priceIncreaseRate = (priceRS*15)/100;
                        winBidPrice = priceRS + priceIncreaseRate;
                    }
                    strWinBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:winBidPrice]];
                    pcell.lbl_WinningBidPrice.text = strWinBidPrice;
                }
            }
        }
        else if (indexPath.row == 2)
        {
            // currentBidButtonCell or upcommingBidButtonCell
            if (_IsCurrent == 1)
            {
//                NSString *timeStr=[self timercount:_objCurrentOccution.strBidclosingtime fromDate:_objCurrentOccution.strCurrentDate];
                if ([_objCurrentOccution.strtimeRemains intValue] < 0)
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
                
                if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] > 0) )
                {
                    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [_objCurrentOccution.strmyuserid intValue])
                    {
                        pcell.btn_BidNow.hidden = YES;
                        pcell.bnt_Proxybid.hidden = YES;
                        pcell.lbl_LeadingText.hidden = NO;
                        if ([_objCurrentOccution.strtimeRemains intValue] < 0)
                        {
                            pcell.lbl_LeadingText.text = @"Lot won";
                        }
                        else
                        {
                            pcell.lbl_LeadingText.text = @"You are currently the highest bidder.";
                        }
                    }
                    else
                    {
                        pcell.btn_BidNow.hidden = NO;
                        pcell.bnt_Proxybid.hidden = NO;
                        pcell.lbl_LeadingText.hidden = YES;
                    }
                }
            }
            else if (_IsPast == 1 || _IsArtwork == 1)
            {
                pcell.bnt_Proxybid.hidden = YES;
                pcell.btn_AddMyAuctionGallary.hidden = YES;
            }
        }
        else if (indexPath.row == 3)
        {
            //            lotDescriptionCell
            //if ([_objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
            if ([_objCurrentOccution.auctionType intValue] != 1)
            {
                pcell.lbl_ArtistText.text = @"";
                pcell.lbl_ArtistName.text = @"";
                
                NSString *strDesc = [ClsSetting getAttributedStringFormHtmlString:_objCurrentOccution.strPrdescription];
                pcell.lbl_Description.text = strDesc;
                
                pcell.lbl_MediumText.text = @"";
                pcell.lbl_Medium.text = @"";
                
                pcell.lbl_YearText.text = @"";
                pcell.lbl_Year.text = @"";
                
                pcell.lbl_Size.text = [NSString stringWithFormat:@"%@ in",_objCurrentOccution.strproductsize];
            }
            else
            {
                pcell.lbl_ArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
                
                pcell.lbl_DescriptionText.text = @"";
                pcell.lbl_Description.text = @"";
                
                pcell.lbl_Medium.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strmedium];
                pcell.lbl_Year.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strproductdate];
                pcell.lbl_Size.text=[NSString stringWithFormat:@"%@ in",_objCurrentOccution.strproductsize];
            }
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
            {
                pcell.lbl_Estimate.text=_objCurrentOccution.strestamiate;
            }
            else
            {
                pcell.lbl_Estimate.text=_objCurrentOccution.strcollectors;
            }
            
            [ClsSetting SetBorder:pcell.btn_BidHistory cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
            
            if (_IsPast == 1 || _IsArtwork == 1)
            {
                pcell.btn_ViewAdditionalCharges.hidden= YES;
                pcell.btn_ViewAdditionalCharges_Height.constant = 0;
            }
        }
        else if (indexPath.row == 4)
        {
            //AdditionalInfoCell
            NSString *strAdditionalInfo = _objCurrentOccution.strdescription;
            NSDictionary *dictAttribute = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.alignment                = NSTextAlignmentJustified;
            
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithData:[strAdditionalInfo dataUsingEncoding:NSUTF8StringEncoding] options:dictAttribute documentAttributes:nil error:nil];
            [attributedStr beginEditing];
            [attributedStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
             {
                 if (value)
                 {
                     /*----- Remove old font attribute -----*/
                     [attributedStr removeAttribute:NSFontAttributeName range:range];
                     //replace your font with new.
                     /*----- Add new font attribute -----*/
                     [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                     [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
                     [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
                 }
             }];
            [attributedStr endEditing];
            pcell.lbl_AdditionalInfo.attributedText = attributedStr;
        }
        else if (indexPath.row == 5)
        {
            // artWorkSizeCell
            pcell.artWorkImage.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], _objCurrentOccution.strhumanFigure]];
            pcell.lbl_artWorkSize.text = _objCurrentOccution.strproductsize;
        }
        else if (indexPath.row == 6)
        {
            //aboutArtistCell
            NSString *strAboutArtist = _objCurrentOccution.strArtistProfile;
            NSDictionary *dictAttribute = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.alignment                = NSTextAlignmentJustified;
            
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithData:[strAboutArtist dataUsingEncoding:NSUTF8StringEncoding] options:dictAttribute documentAttributes:nil error:nil];
            [attributedStr beginEditing];
            [attributedStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
             {
                 if (value)
                 {
                     /*----- Remove old font attribute -----*/
                     [attributedStr removeAttribute:NSFontAttributeName range:range];
                     //replace your font with new.
                     /*----- Add new font attribute -----*/
                     [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                     [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
                     
                     [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
                 }
             }];
            [attributedStr endEditing];
            pcell.lbl_aboutArtist.attributedText = attributedStr;
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
            [ClsSetting SetBorder:pcell.btn_BidHistory cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
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

/*-(NSString*)timercount:(NSString*)dateStr fromDate:(NSString*)fromdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *closingDate = [dateFormatter dateFromString:dateStr];
    
    NSDate *currentDate = [dateFormatter dateFromString:fromdate];
    
    NSTimeInterval secondsBetween = [closingDate timeIntervalSinceDate:currentDate];
    
    int numberOfDays = secondsBetween / 86400;
    
    secondsBetween = (long)secondsBetween % 86400;
    
    int numberOfHours = secondsBetween / 3600;
    
    secondsBetween = (long)secondsBetween % 3600;
    
    int numberOfMinutes = secondsBetween / 60;
    
    secondsBetween = (long)secondsBetween % 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%dD %d:%d:%ld",numberOfDays,numberOfHours,numberOfMinutes,(long)secondsBetween];
    
    if (secondsBetween == 0)
        return @"";
    else if (secondsBetween < 0)
        return @"";
    else
        return timeStr;

}*/

- (IBAction)btnBidNowPressed:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.delegate = self;
                objAuctionItemBidViewController.objCurrentOuction=_objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=1;
                [self addChildViewController:objAuctionItemBidViewController];
                
                
//                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=0;
//                }
                
//                if (_IsSort == 0)
//                {
//                    objAuctionItemBidViewController.IsSort = 1;
//                }
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have access to Bid. Please contact Astaguru"  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            [ClsSetting ValidationPromt:@"Your are not Verified"];
            
            NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
            VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
            rootViewController.dict=dict;
            rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
            rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
            rootViewController.strname=dict[@"t_firstname"];
            rootViewController.strSMSCode=strSMSCode;
            rootViewController.strEmialCode=strEmailCode;
            rootViewController.isRegistration = NO;
            rootViewController.IsCommingFromLoging = 0;
            [self.navigationController pushViewController:rootViewController animated:YES];
            
        }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
    
}

- (IBAction)btnProxyBidpressed:(id)sender
{
   
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=_objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=FALSE;
                objAuctionItemBidViewController.IsUpcoming = _IsUpcomming;
                objAuctionItemBidViewController.Auction_id = _Auction_id;
                objAuctionItemBidViewController.isBidNow=0;
//                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar = 1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar = 0;
//                }
                
//                if (_IsSort == 0)
//                {
//                    objAuctionItemBidViewController.IsSort = 1;
//                }
                
                [self addChildViewController:objAuctionItemBidViewController];
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have access to Bid. Please contact Astaguru"  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            [ClsSetting ValidationPromt:@"Your are not Verified"];
            
            NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
            VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
            rootViewController.dict=dict;
            rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
            rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
            rootViewController.strname=dict[@"t_firstname"];
            rootViewController.strSMSCode=strSMSCode;
            rootViewController.strEmialCode=strEmailCode;
            rootViewController.isRegistration = NO;
            rootViewController.IsCommingFromLoging = 0;
            [self.navigationController pushViewController:rootViewController animated:YES];
            
        }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
}

- (IBAction)btnMaximizepressed:(id)sender
{
    [self zoomImage];
}

- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    [self zoomImage];
}

-(void)zoomImage
{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL],_objCurrentOccution.strimage]];
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (IBAction)btnMyAuctionGalleryPressed:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        [self insertItemToAuctionGallery:_objCurrentOccution];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
}
- (IBAction)btnBidHistoryPressed:(id)sender
{
    BidHistoryViewController *objBidHistoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
    objBidHistoryViewController.objCurrentOuction=_objCurrentOccution;
//    objBidHistoryViewController.IsSort=_IsSort;
    objBidHistoryViewController.IsUpcoming = _IsUpcomming;
//    objBidHistoryViewController.IsAuctionClosed = IsAuctionClosed;
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}
- (IBAction)btnViewAdditionalChargesPressed:(id)sender
{
    AdditionalChargesViewController *objAdditionalChargesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditionalChargesViewController"];
    objAdditionalChargesViewController.objCurrentOuction=_objCurrentOccution;
//    objAdditionalChargesViewController.IsSort=_IsSort;
    [self.navigationController pushViewController:objAdditionalChargesViewController animated:YES];
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

-(void)insertItemToAuctionGallery:(clsCurrentOccution*)_objCurrentOuction
{
    NSString *str;
    NSString *strUserid;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
    {
        str=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    }
    else
    {
        str=@"abhi123";
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_id] != nil)
    {
        strUserid=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    }
    else
    {
        strUserid=@"1972";
    }
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
       
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spAddToGallery(%@,%@)?api_key=%@",[ClsSetting procedureURL],_objCurrentOuction.strproductid,strUserid,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict);
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [ClsSetting ValidationPromt:@"Item added to your auction gallery"];
             [self myAuctionGallery];
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];
             }];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
    //[self myAuctionGallery];
}
-(void)passReseposeData1:(id)str
{
    [self myAuctionGallery];
}
-(void)myAuctionGallery
{
    
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    
    MyAuctionGalleryViewController *objMyAuctionGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    if (_IsCurrent)
    {
        objMyAuctionGalleryViewController.isCurrent = 1;
    }
    else if (_IsUpcomming)
    {
        objMyAuctionGalleryViewController.isCurrent = 0;
    }
    [navcontroll pushViewController:objMyAuctionGalleryViewController animated:YES];
}

@end
