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
@interface DetailProductViewController ()<UIGestureRecognizerDelegate, AuctionItemBidViewControllerDelegaet, PassResepose>
{
    NSMutableArray *arrDescription;
    int ISMore;
    NSTimer *countDownTimer;
}
@end

@implementation DetailProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ self setUpNavigationItem];
    
    arrDescription=[[NSMutableArray alloc]init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"Additional Information" forKey:@"Title"];
    [dict setValue:_objCurrentOccution.strdescription forKey:@"Description"];
    [arrDescription addObject:dict];
    
    NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
    [dict1 setValue:@"ArtWork Size" forKey:@"Title"];
    [dict1 setValue:[NSString stringWithFormat:@"%@ in",_objCurrentOccution.strproductsize] forKey:@"Description"];
    [arrDescription addObject:dict1];
    
    if (_IsSort==0)
    {
        NSMutableDictionary *dict2=[[NSMutableDictionary alloc]init];
        [dict2 setValue:@"About Artist" forKey:@"Title"];
        [dict2 setValue:_objCurrentOccution.objArtistInfo.strProfile  forKey:@"Description"];
        [arrDescription addObject:dict2];
    }
    else
    {
        NSMutableDictionary *dict2=[[NSMutableDictionary alloc]init];
        [dict2 setValue:@"About Artist" forKey:@"Title"];
        [dict2 setValue:_objCurrentOccution.strArtistProfile  forKey:@"Description"];
        [arrDescription addObject:dict2];
    }

    // Do any additional setup after loading the view.
}
- (void)configureBackButton { //Yogesh
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    
}
- (void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
   self.navigationItem.title=[NSString stringWithFormat:@"Lot %@",_objCurrentOccution.strReference];
}
-(void)viewDidAppear:(BOOL)animated
{
   /* self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];*/
      self.navigationController.navigationBar.backItem.title = @"Back";
   // self.title=[NSString stringWithFormat:@"Lot %@",_objCurrentOccution.strReference];
    self.navigationItem.title=[NSString stringWithFormat:@"Lot %@",_objCurrentOccution.strReference];
    
    countDownTimer =[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(reloadCall) userInfo:nil repeats:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [countDownTimer invalidate];
}
-(void)reloadCall
{
    [self refreshData];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
//    [self.productDetail_CollectionView reloadItemsAtIndexPaths: arrindexpath];

//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//    [self.collectionView reloadItemsAtIndexPaths: indexpathArray];

//    [_clvCurrentOccution reloadData];
}

-(NSString*)timercount:(NSString*)dateStr fromDate:(NSString*)fromdate
{
//    NSString *dateString = dateStr; //@"12-12-2015";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSDate *dateStr_Date = [[NSDate alloc] init];
//    
//    dateStr_Date = [dateFormatter dateFromString:dateString];
//    
//    NSString *fromdateString = fromdate; //@"12-12-2015";
//    NSDateFormatter *fromdateFormatter = [[NSDateFormatter alloc] init];
//    [fromdateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSDate *dateFromString = [[NSDate alloc] init];
//    dateFromString = [fromdateFormatter dateFromString:fromdateString];
//    
//    //    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSDateComponents *componentsHours = [calendar components:NSCalendarUnitHour fromDate:dateFromString];
//    NSDateComponents *componentMint = [calendar components:NSCalendarUnitMinute fromDate:dateFromString];
//    NSDateComponents *componentSec = [calendar components:NSCalendarUnitSecond fromDate:dateFromString];
//    
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *componentsDaysDiff = [gregorianCalendar components:NSCalendarUnitDay
//                                                                fromDate:dateFromString
//                                                                  toDate:dateStr_Date
//                                                                 options:0];
//    
//    long day = (long)componentsDaysDiff.day;
//    long hours = (long)(24-componentsHours.hour);
//    long minutes = (long)(60-componentMint.minute);
//    long sec = (long)(60-componentSec.second);
//    
//    //    NSString *strForday = [NSString stringWithFormat:@"%02ld",day];
//    //    NSString *strForhours = [NSString stringWithFormat:@"%02ld",hours];
//    //    NSString *strForminutes = [NSString stringWithFormat:@"%02ld",minutes];
//    //    NSString *strForsec = [NSString stringWithFormat:@"%02ld",sec];
//    //    NSLog(@"%@ %@ %@ %@ ",strForday,strForhours,strForminutes,strForsec);
//    NSString *timeStr = [NSString stringWithFormat:@"%ldD %02ld:%02ld:%02ld",day,hours,minutes,sec];
//    return timeStr;
//    //    if (day == 0 && hours == 0 && minutes == 0 && sec == 0) {
//    //        [myTimer invalidate];
//    //    }
    
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

}


-(void)setUpNavigationItem
{
   
    //self.title=[NSString stringWithFormat:@"Lot %@",_objCurrentOccution.strReference];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return   CGSizeMake(collectionView1.frame.size.width,246);
    }
    else if (indexPath.section==1)
    {
        return   CGSizeMake(collectionView1.frame.size.width,380);
    }
    else if (indexPath.section==3)
    {
        NSString *strStatus=[[NSUserDefaults standardUserDefaults]valueForKey:@"CurrentAuctionID"];
        if ([_objCurrentOccution.strOnline intValue]<[strStatus intValue])
        {
            return   CGSizeMake(collectionView1.frame.size.width,0);
        }
        else
        {
            return   CGSizeMake(collectionView1.frame.size.width,55);
        }
    }
    else
    {
        NSMutableDictionary *dict=[arrDescription objectAtIndex:indexPath.row];
        CGSize maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-20, FLT_MAX);
        UIFont *font=[UIFont systemFontOfSize:17];
        float labelRect=[ClsSetting heightOfTextForString:[ClsSetting getAttributedStringFormHtmlString:[dict objectForKey:@"Description"]] andFont:font maxSize:maximumLabelSize];
        int numberofline=(labelRect / font.lineHeight);
        if ([[dict objectForKey:@"Title"] isEqualToString:@"About Artist"])
        {
            if (numberofline>4)
            {
                if(ISMore==1)
                {
                    return   CGSizeMake(collectionView1.frame.size.width,labelRect+80);
                }
                else
                {
                    return CGSizeMake(collectionView1.frame.size.width, (font.lineHeight*3)+80);
                }
            }
            return   CGSizeMake(collectionView1.frame.size.width,labelRect+40);
        }
        else if ([[dict valueForKey:@"Title"] isEqualToString:@"ArtWork Size"])
        {
            return CGSizeMake(collectionView1.frame.size.width,180);
        }
        return   CGSizeMake(collectionView1.frame.size.width,labelRect+40);
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else  if (section==1)
    {
        return 1;
    }
    else  if (section==3)
    {
        return 1;
    }
    else
       return arrDescription.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell1;
   
    if (indexPath.section==0)
    {
       
        static NSString *identifier = @"ImageCell";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
        imgServices.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOccution.strimage]];
        
        imgServices.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
        
        tapGesture1.numberOfTapsRequired = 1;
        
        [tapGesture1 setDelegate:self];
       
        [imgServices addGestureRecognizer:tapGesture1];
        
       
        cell1 = cell;
    }
    else if (indexPath.section==1)
    {
        
        static NSString *identifier = @"DetailCell";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (_IsSort==1)
        {
            UILabel *lblArtistName = (UILabel *)[cell viewWithTag:11];
            lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
            UILabel *lblArtistName1 = (UILabel *)[cell viewWithTag:19];
            lblArtistName1.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
        }
        else
        {
            UILabel *lblArtistName = (UILabel *)[cell viewWithTag:11];
            lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.objArtistInfo.strFirstName,_objCurrentOccution.objArtistInfo.strLastName];
            UILabel *lblArtistName1 = (UILabel *)[cell viewWithTag:19];
            lblArtistName1.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.objArtistInfo.strFirstName,_objCurrentOccution.objArtistInfo.strLastName];
        }
        
        
        UILabel *lblProductName = (UILabel *)[cell viewWithTag:12];
        lblProductName.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strtitle];
        NSString *strStatus=[[NSUserDefaults standardUserDefaults]valueForKey:@"CurrentAuctionID"];
        
        UILabel *lblCounDown = (UILabel *)[cell viewWithTag:13];
        UILabel *lblEstimate = (UILabel *)[cell viewWithTag:15];
        
        UIButton *btnAddTogallary = (UIButton *)[cell viewWithTag:61];
//        UIButton *btnmaximize = (UIButton *)[cell viewWithTag:62];
        UIButton *btnbidnow = (UIButton *)[cell viewWithTag:63];
        UIButton *btnproxybid = (UIButton *)[cell viewWithTag:64];
        
        lblEstimate.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strestamiate];
        
         UILabel *lblnextValidBid = (UILabel *)[cell viewWithTag:51];
         UILabel *lblCurrentbid = (UILabel *)[cell viewWithTag:52];
         UILabel *lblWinnigbidPricePastValue = (UILabel *)[cell viewWithTag:110];
        UILabel *lblInclusive = (UILabel *)[cell viewWithTag:120];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
       [numberFormatter setMaximumFractionDigits:0];
        
        if ([_objCurrentOccution.strpricers intValue] > 10000000) // 10000000
        {
            if (_iscurrencyInDollar==1)
            {
                numberFormatter.currencyCode = @"USD";
                
                int price =[_objCurrentOccution.strpriceus intValue];
                
                NSNumber *num = [NSNumber numberWithInt:price];
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                lblCurrentbid.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                
                //            int price =[_objCurrentOccution.strpriceus intValue];
                int priceIncreaserete=(price*5)/100;
                int pricePastWinningBid=(price*15)/100;
                
                int FinalPrice=price+priceIncreaserete;
                int FinalPastWinningBid=price+pricePastWinningBid;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                NSString *strPastWinningBid = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPastWinningBid]];
                
                lblnextValidBid.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                lblWinnigbidPricePastValue.text=[NSString stringWithFormat:@"%@",strPastWinningBid];
                
            }
            else
            {
                numberFormatter.currencyCode = @"INR";
                int price =[_objCurrentOccution.strpricers intValue];
                
                NSNumber *num = [NSNumber numberWithInt:price];
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                
                lblCurrentbid.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int priceIncreaserete=(price*5)/100;
                int pricePastWinningBid=(price*15)/100;
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                lblnextValidBid.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                
                int FinalPastWinningBid=price+pricePastWinningBid;
                NSString *strPastWinningBid = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPastWinningBid]];
                lblWinnigbidPricePastValue.text=[NSString stringWithFormat:@"%@",strPastWinningBid];
                
                NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                NSArray *subStrings = [_objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
                if (subStrings.count>1)
                {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.numberStyle = NSNumberFormatterDecimalStyle;
                    NSString *strFromRangeString = [[subStrings objectAtIndex:0] stringByTrimmingCharactersInSet:nonNumbersSet];
                    NSString *strToRangeString = [[subStrings objectAtIndex:1] stringByTrimmingCharactersInSet:nonNumbersSet];
                    
                    float Fromnumber = [[formatter numberFromString:strFromRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                    
                    float Tonumber = [[formatter numberFromString:strToRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                    
                    NSString *strFromRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Fromnumber]];
                    NSString *strToRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Tonumber]];
                    
                    lblEstimate.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                    
                }
            }
        }
        else{
            if (_iscurrencyInDollar==1)
            {
                numberFormatter.currencyCode = @"USD";
                
                int price =[_objCurrentOccution.strpriceus intValue];
                
                NSNumber *num = [NSNumber numberWithInt:price];
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                
                lblCurrentbid.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                int priceIncreaserete=(price*10)/100;
                int pricePastWinningBid=(price*15)/100;
                
                int FinalPrice=price+priceIncreaserete;
                int FinalPastWinningBid=price+pricePastWinningBid;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                NSString *strPastWinningBid = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPastWinningBid]];
                
                lblnextValidBid.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                lblWinnigbidPricePastValue.text=[NSString stringWithFormat:@"%@",strPastWinningBid];
                
            }
            else
            {
                numberFormatter.currencyCode = @"INR";
                int price =[_objCurrentOccution.strpricers intValue];
                
                NSNumber *num = [NSNumber numberWithInt:price];
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                
                lblCurrentbid.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int priceIncreaserete=(price*10)/100;
                int pricePastWinningBid=(price*15)/100;
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                lblnextValidBid.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                
                int FinalPastWinningBid=price+pricePastWinningBid;
                NSString *strPastWinningBid = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPastWinningBid]];
                lblWinnigbidPricePastValue.text=[NSString stringWithFormat:@"%@",strPastWinningBid];
                
                NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                NSArray *subStrings = [_objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
                if (subStrings.count>1)
                {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.numberStyle = NSNumberFormatterDecimalStyle;
                    NSString *strFromRangeString = [[subStrings objectAtIndex:0] stringByTrimmingCharactersInSet:nonNumbersSet];
                    NSString *strToRangeString = [[subStrings objectAtIndex:1] stringByTrimmingCharactersInSet:nonNumbersSet];
                    
                    float Fromnumber = [[formatter numberFromString:strFromRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                    
                    float Tonumber = [[formatter numberFromString:strToRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                    
                    NSString *strFromRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Fromnumber]];
                    NSString *strToRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Tonumber]];
                    
                    lblEstimate.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                    
                }
            }

        }
        
        lblCounDown.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strtitle];
        UILabel *lblSize = (UILabel *)[cell viewWithTag:14];
        lblSize.text=[NSString stringWithFormat:@"%@ in",_objCurrentOccution.strproductsize];
        if (_IsSort==1)
        {
            UILabel *lblCategory = (UILabel *)[cell viewWithTag:16];
            lblCategory.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strcategory];
            UILabel *lblMedium = (UILabel *)[cell viewWithTag:17];
            lblMedium.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strmedium];
            
        }
        else
        {
            UILabel *lblCategory = (UILabel *)[cell viewWithTag:16];
            lblCategory.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.objCategoryInfo.strCategoryName];
            UILabel *lblMedium = (UILabel *)[cell viewWithTag:17];
            lblMedium.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.objMediaInfo.strMediumName];
        }
        UILabel *lblYear = (UILabel *)[cell viewWithTag:18];
        lblYear.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strproductdate];
    
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *timeStr=[self timercount:_objCurrentOccution.strBidclosingtime fromDate:_objCurrentOccution.strCurrentDate];
        if ([timeStr isEqualToString:@""])
        {
            btnbidnow.enabled = NO;
            btnproxybid.enabled = NO;
            btnbidnow.backgroundColor = [UIColor grayColor];
            btnproxybid.backgroundColor = [UIColor grayColor];
            lblCounDown.text=@"Auction Closed";
        }
        else
        {
            btnbidnow.enabled = YES;
            btnproxybid.enabled = YES;
            btnbidnow.backgroundColor = [UIColor blackColor];
            btnproxybid.backgroundColor = [UIColor blackColor];
            lblCounDown.text=timeStr;
        }
        if ([_objCurrentOccution.strOnline intValue]<[strStatus intValue])
        {
            lblCounDown.hidden=YES;
            lblCurrentbid.hidden=YES;
            lblnextValidBid.hidden=YES;
            btnbidnow.hidden=YES;
            btnAddTogallary.hidden=YES;
            btnproxybid.hidden=YES;
            UILabel *lblNextVlidBuildTitle = (UILabel *)[cell viewWithTag:108];
            lblNextVlidBuildTitle.hidden=YES;
            UILabel *lblWinnigPricePastTitle = (UILabel *)[cell viewWithTag:109];
            
            lblWinnigPricePastTitle.hidden=NO;
            lblWinnigbidPricePastValue.hidden=NO;
            lblInclusive.hidden = NO;
            UIView *viwDivider = (UIView *)[cell viewWithTag:1111];
            UILabel *lblCurrentBidTitle = (UILabel *)[cell viewWithTag:112];
            UILabel *lblCoutDownTitle = (UILabel *)[cell viewWithTag:113];
            viwDivider.hidden=YES;
            lblCurrentBidTitle.hidden=YES;
            lblCoutDownTitle.hidden=YES;
            
        }
        else if ([_objCurrentOccution.strOnline intValue]>[strStatus intValue])
          
        {
            UILabel *lblCoutDownTitle = (UILabel *)[cell viewWithTag:113];
            lblCoutDownTitle.hidden=YES;
            lblCounDown.hidden=YES;
//            lblCurrentbid.hidden=YES;
            btnbidnow.hidden=YES;
            btnAddTogallary.hidden=YES;
            
        
        }
        
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [_objCurrentOccution.strmyuserid intValue])
            {
                btnbidnow.hidden = YES;
                btnproxybid.hidden = YES;
                UILabel *leading_Lbl = (UILabel *)[cell viewWithTag:111];
                leading_Lbl.hidden = NO;
            }
            else
            {
                btnbidnow.hidden = NO;
                btnproxybid.hidden = NO;
                UILabel *leading_Lbl = (UILabel *)[cell viewWithTag:111];
                leading_Lbl.hidden = YES;
            }
        }
        
        if (_IsUpcomming == 1)
        {
            btnbidnow.hidden = YES;
        }
        
        if (_IsPast == 1)
        {
            btnbidnow.hidden = YES;
            btnproxybid.hidden = YES;
        }
        cell1 = cell;
    }
  else  if (indexPath.section==3)
    {
        
        static NSString *identifier = @"BidHistory";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
          UIButton *btnConditionReport = (UIButton *)[cell viewWithTag:41];
        
         UIButton *btnBidHistory = (UIButton *)[cell viewWithTag:42];
        
        btnConditionReport.layer.borderWidth=1;
        btnConditionReport.layer.cornerRadius=2;
        btnConditionReport.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        
        btnBidHistory.layer.borderWidth=1;
        btnBidHistory.layer.cornerRadius=2;
        btnBidHistory.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        
        cell1 = cell;
    }
    else
    {
        NSMutableDictionary *dict=[arrDescription objectAtIndex:indexPath.row];

        if ([[dict valueForKey:@"Title"] isEqualToString:@"ArtWork Size"])
        {
            static NSString *identifier = @"WorkImageCell";
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            UILabel *lblTitle = (UILabel *)[cell viewWithTag:24];
            UILabel *lblDescription = (UILabel *)[cell viewWithTag:26];
            EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:25];
            imgServices.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOccution.strhumanFigure]];
            lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Title"]];
            lblDescription.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Description"]];
            cell1 = cell;
        }
        else
        {
            static NSString *identifier = @"DescriptionCell";
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            UILabel *lblTitle = (UILabel *)[cell viewWithTag:21];
            UIButton *btnMore = (UIButton *)[cell viewWithTag:23];
            lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Title"]];
            UILabel *lblDescription = (UILabel *)[cell viewWithTag:22];
            CGSize maximumLabelSize = CGSizeMake(collectionView.frame.size.width-16, FLT_MAX);
            UIFont *font= [UIFont fontWithName:@"WorkSans-Regular" size:15];//[UIFont systemFontOfSize:16];
            float labelRect=[ClsSetting heightOfTextForString:[dict objectForKey:@"Description"] andFont:font maxSize:maximumLabelSize];
            int numberofline=(labelRect / font.lineHeight);
            NSString *stringTojustify                = [dict objectForKey:@"Description"];
            lblDescription.numberOfLines              = 0;
            NSDictionary *dictAttrib = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.alignment                = NSTextAlignmentJustified;
            
            NSMutableAttributedString *attrib = [[NSMutableAttributedString alloc]initWithData:[stringTojustify dataUsingEncoding:NSUTF8StringEncoding] options:dictAttrib documentAttributes:nil error:nil];
            [attrib beginEditing];
            [attrib enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attrib.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
            {
                if (value)
                {
//                    UIFont *oldFont = (UIFont *)value;
//                    NSLog(@"%@",oldFont.fontName);
                    /*----- Remove old font attribute -----*/
                    [attrib removeAttribute:NSFontAttributeName range:range];
                    //replace your font with new.
                    /*----- Add new font attribute -----*/
                    [attrib addAttribute:NSFontAttributeName value:font range:range];
                    [attrib addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
                    [attrib addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
                }
            }];
            [attrib endEditing];
            lblDescription.attributedText             = attrib;
            if ([[dict objectForKey:@"Title"] isEqualToString:@"About Artist"])
            {
                if (numberofline>4)
                {
                    btnMore.hidden=NO;
                }
                else
                {
                    btnMore.hidden=YES;
                    
                }
                if(ISMore)
                {
                    lblDescription.numberOfLines = numberofline;
                    [btnMore setTitle:@"Read Less" forState:UIControlStateNormal];
                }
                else
                {
                    lblDescription.numberOfLines = 3;
                    [btnMore setTitle:@"Read More" forState:UIControlStateNormal];
                }
//                lblDescription.attributedText = attrib;
            }
            else
            {
                btnMore.hidden=YES;
            }
            cell1 = cell;

        }
    }
    
    return cell1;
    
}
-(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate
{
    NSDateComponents *components;
    NSInteger days;
    NSInteger hour;
    NSInteger minutes;
    NSString *durationString;
    
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate: startDate toDate: endDate options: 0];
    
    days = [components day];
    hour = [components hour];
    minutes = [components minute];
    
    if(days>0)
    {
        if(days>1)
            durationString=[NSString stringWithFormat:@"%ld days",(long)days];
        else
            durationString=[NSString stringWithFormat:@"%ld day",(long)days];
        return durationString;
    }
    if(hour>0)
    {
        if(hour>1)
            durationString=[NSString stringWithFormat:@"%ld hours",(long)hour];
        else
            durationString=[NSString stringWithFormat:@"%ld hour",(long)hour];
        return durationString;
    }
    if(minutes>0)
    {
        if(minutes>1)
            durationString = [NSString stringWithFormat:@"%ld minutes",(long)minutes];
        else
            durationString = [NSString stringWithFormat:@"%ld minute",(long)minutes];
        
        return durationString;
    }
    NSString *strDate=[NSString stringWithFormat:@"%ld day %ld:%ld",(long)days,(long)hour,(long)minutes];
    return strDate;
}
- (IBAction)btnBidnowPredded:(id)sender
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
                //        objAuctionItemBidViewController.IsUpcoming = _IsUpcomming;
                //        objAuctionItemBidViewController.Auction_id = _Auction_id;
                [self addChildViewController:objAuctionItemBidViewController];
                
                
                if (_iscurrencyInDollar)
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
                }
                
                if (_IsSort==0)
                {
                    objAuctionItemBidViewController.IsSort=1;
                }
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
                if (_iscurrencyInDollar)
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
                }
                
                if (_IsSort==0)
                {
                    objAuctionItemBidViewController.IsSort=1;
                }
                
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
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],_objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
    
    // CurrentDefultGridCollectionViewCell *cell1= (CurrentDefultGridCollectionViewCell*)cell;
    
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}
- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],_objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
    
    // CurrentDefultGridCollectionViewCell *cell1= (CurrentDefultGridCollectionViewCell*)cell;
    
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}
- (IBAction)btnMyAuctionGallery:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
//        clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
//        objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
        [self insertItemToAuctionGallery:_objCurrentOccution];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }

//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
//    {
//    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
//    
//    MyAuctionGalleryViewController *objAfterLoginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
//    [navcontroll pushViewController:objAfterLoginViewController animated:YES];
//    }
//    else
//    {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
//    BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
//    [self.navigationController pushViewController:rootViewController animated:YES];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnBidHistoryPredded:(id)sender
{
    BidHistoryViewController *objBidHistoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
    objBidHistoryViewController.objCurrentOuction=_objCurrentOccution;
    objBidHistoryViewController.IsSort=_IsSort;
    objBidHistoryViewController.IsUpcoming = _IsUpcomming;
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}
- (IBAction)btnViewAdditionalChargesPressed:(id)sender
{
    AdditionalChargesViewController *objAdditionalChargesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditionalChargesViewController"];
    objAdditionalChargesViewController.objCurrentOuction=_objCurrentOccution;
    objAdditionalChargesViewController.IsSort=_IsSort;
    [self.navigationController pushViewController:objAdditionalChargesViewController animated:YES];
}


//// Here we refresh the view after bid submited;

-(void)refreshData
{
    ClsSetting *objSetting=[[ClsSetting alloc]init];
      @try {
        
//        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetBidPrice(%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objSetting UrlProcedure],_objCurrentOccution.strproductid];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
//             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSDictionary *priceDic = dict[0];
             NSLog(@"price = %@",priceDic);
             NSNumber *strpricers = priceDic[@"pricers"];
             NSNumber *strpriceus = priceDic[@"priceus"];
             
//             clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
             _objCurrentOccution.strpricers=strpricers;
             _objCurrentOccution.strpriceus=strpriceus;
             _objCurrentOccution.strBidclosingtime = priceDic[@"Bidclosingtime"];
             _objCurrentOccution.strCurrentDate = priceDic[@"currentDate"];
             
             NSLog(@" strpricers = %@ \n  strpriceus = %@", _objCurrentOccution.strpricers,_objCurrentOccution.strpriceus);
             [self.productDetail_CollectionView reloadData];             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];

//                 if ([operation.response statusCode]==404)
//                 {
//                     [ClsSetting ValidationPromt:@"No Record Found"];
//                     
//                 }
//                 else
//                 {
//                     [ClsSetting internetConnectionPromt];
//                     
//                 }
             }];
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
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
    [_productDetail_CollectionView reloadData];
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
    /* NSDictionary *params = @{
     
     @"AuctionId":[[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentAuctionID"],
     @"Bidpricers":_objCurrentOuction.strpricers,
     @"Bidpriceus":_objCurrentOuction.strpriceus,
     @"Firstname":_objCurrentOuction.strFirstName,
     @"Lastname":_objCurrentOuction.strLastName,
     @"Reference":_objCurrentOuction.strReference,
     @"Thumbnail":_objCurrentOuction.strthumbnail,
     @"UserId":strUserid,
     @"Username":str,
     @"anoname":@"",
     @"currentbid":@"0",
     @"daterec":@"",
     @"earlyproxy":@"",
     @"productid":_objCurrentOuction.strproductid,
     @"proxy":@"",
     @"recentbid":@"",
     @"validbidpricers":@"",
     @"validbidpriceus":@"",
     @"Bidrecordid":@""
     
     };
     
     NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
     
     NSDictionary *pardsams = @{@"resource": arr};
     
     
     
     ClsSetting *objClssetting=[[ClsSetting alloc] init];
     // objClssetting.PassReseposeDatadelegate=self;
     objClssetting.PassReseposeDatadelegate=self;
     [objClssetting calllPostWeb:pardsams url:[NSString stringWithFormat:@"%@mygallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[objClssetting Url],str] view:self.view];*/
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spAddToGallery(%@,%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting UrlProcedure],_objCurrentOuction.strproductid,strUserid];
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

//                 if ([operation.response statusCode]==404)
//                 {
//                     [ClsSetting ValidationPromt:@"No Record Found"];
//                     
//                 }
//                 else
//                 {
//                     [ClsSetting internetConnectionPromt];
//                     
//                 }
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
    
    MyAuctionGalleryViewController *objAfterLoginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    [navcontroll pushViewController:objAfterLoginViewController animated:YES];
}

@end
