//
//  MyAuctionGalleryViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 27/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "MyAuctionGalleryViewController.h"
#import "ClsSetting.h"
#import "SWRevealViewController.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "AppDelegate.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "DetailProductViewController.h"
#import "AuctionItemBidViewController.h"
#import "BforeLoginViewController.h"
#import "BidHistoryViewController.h"
#import "ArtistViewController.h"
#import "VerificationViewController.h"
@interface MyAuctionGalleryViewController ()<PassResepose,CurrentOccution,UIGestureRecognizerDelegate>
{
    NSMutableArray *arrMyAuctionGallery;
    NSMutableArray *arrItemCount;
    
    int WebserviceCount;
    NSTimer *timer;
}
@end

@implementation MyAuctionGalleryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    arrItemCount=[[NSMutableArray alloc]init];
    arrMyAuctionGallery=[[NSMutableArray alloc]init];

    [self getMyOccttionGallery];
    [self setUpNavigationItem];
    
    if (_isCurrent == 1)
    {
        self.lblCurrentLine.backgroundColor = [UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1];
        self.lblUpcommingLine.backgroundColor = [UIColor grayColor];
        self.lblUpcommingLine.hidden = YES;
    }
    else
    {
        self.lblCurrentLine.backgroundColor = [UIColor grayColor];
        self.lblCurrentLine.hidden = YES;
        self.lblUpcommingLine.backgroundColor = [UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        self.lblCurrency.text = @"USD";
    }
    else
    {
        self.lblCurrency.text = @"INR";
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    timer=[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(RefreshMyGallery) userInfo:nil repeats:YES];

    self.navigationItem.title=@"My Auction Gallery";
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [timer invalidate];
    timer = nil;
}
-(void)getMyOccttionGallery
{
    //USE LIMIT 10
    WebserviceCount = 1;
    NSString *str;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
    {
        str=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    }
    else
    {
       [[NSUserDefaults standardUserDefaults]setObject:@"abhi123" forKey:USER_NAME];
    }
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"getMyGallery?api_key=%@&filter=(userid=%@)",[ClsSetting apiKey],strUserName] view:self.view Post:NO];
    
}

-(void)passReseposeData1:(id)str
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavigationItem
{
    self.navigationItem.title=@"My Auction Gallery";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
-(void)closePressed
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    if (WebserviceCount == 1)
    {
        [arrItemCount removeAllObjects];
        arrItemCount = [parese parseSortCurrentAuction:[dict1 valueForKey:@"resource"]];
        
        NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
        NSMutableArray *arrUpcommingAuction = [[NSMutableArray alloc]init];
        
        for (int i=0; i<arrItemCount.count ; i++)
        {
            clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
            
            if ([objCurrentOccution.strStatus isEqualToString:@"Current"])
            {
                [arrCurrentAuction addObject:objCurrentOccution];
            }
            else
            {
                [arrUpcommingAuction addObject:objCurrentOccution];
            }
        }
        
        if (self.isCurrent == 1)
        {
            for (int i=0; i<arrMyAuctionGallery.count; i++)
            {
                clsCurrentOccution *objacution = [arrMyAuctionGallery objectAtIndex:i];
                for (int j=0; j<arrCurrentAuction.count; j++)
                {
                    clsCurrentOccution *objFilterResult = [arrCurrentAuction objectAtIndex:j];
                    if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                    {
                        objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                        break;
                    }
                }
            }
            [arrMyAuctionGallery removeAllObjects];
            arrMyAuctionGallery = arrCurrentAuction;
        }
        else
        {
            for (int i=0; i<arrMyAuctionGallery.count; i++)
            {
                clsCurrentOccution *objacution=[arrMyAuctionGallery objectAtIndex:i];
                for (int j=0; j<arrUpcommingAuction.count; j++)
                {
                    clsCurrentOccution *objFilterResult=[arrUpcommingAuction objectAtIndex:j];
                    if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                    {
                        objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                        break;
                    }
                }
            }
            [arrMyAuctionGallery removeAllObjects];
            arrMyAuctionGallery = arrUpcommingAuction;
        }

        if (arrMyAuctionGallery.count == 0)
        {
            _lblNoRecords.hidden = NO;
            _lblNoRecords.text = @"You haven’t added anything to the gallery.";
            _clvMyAuctionGallery.hidden=YES;
            [timer invalidate];
            timer = nil;
        }
        else
        {
            _lblNoRecords.hidden = YES;
            _clvMyAuctionGallery.hidden=NO;
        }
        [_clvMyAuctionGallery reloadData];
    }
    else
    {
        [self getMyOccttionGallery];
    }
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}


- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
       return   CGSizeMake((collectionView1.frame.size.width), 12);
    }
    else
    {
        if (_isCurrent == 1)
        {
            return   CGSizeMake((collectionView1.frame.size.width/2) - 12, 350);
        }
        else
        {
            return   CGSizeMake((collectionView1.frame.size.width/2)-12, 290);
        }
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return  arrMyAuctionGallery.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    UICollectionViewCell *cell;
    CurrentDefultGridCollectionViewCell *currentDefultGridCell;
    CurrentDefultGridCollectionViewCell *currentSelectedGridCell;
    
    if (indexPath.section==0)
    {
        static NSString *identifier = @"blankcell";
        UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell = cell2;
    }
    else
    {
         clsCurrentOccution *objCurrentOccution=[arrMyAuctionGallery objectAtIndex:indexPath.row];
        
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
                if (_isCurrent == 1)
                {
                    currentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                }
                else
                {
                    currentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpcommingSelected" forIndexPath:indexPath];
                }
               
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                
                NSInteger currentBid;
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    currentBid = [objCurrentOccution.strpriceus integerValue];
                    currentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    currentBid = [objCurrentOccution.strpricers integerValue];
                    currentSelectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                }
                
                currentSelectedGridCell.lblCurrentBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                
                NSInteger incresedPrice;
                if ([objCurrentOccution.strpricers intValue] >= 10000000)
                {
                    NSInteger incresedRate = (currentBid*5)/100;
                    incresedPrice = currentBid + incresedRate;
                }
                else
                {
                    NSInteger incresedRate = (currentBid*10)/100;
                    incresedPrice = currentBid + incresedRate;
                }
                if (_isCurrent == 1)
                {
                    currentSelectedGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
                }
                else
                {
                    currentSelectedGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                }

                if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                {
                    UILabel *Lbl_1 = (UILabel *)[currentSelectedGridCell viewWithTag:1];
                    Lbl_1.text = @"Title: ";
                    UILabel *Lbl_2 = (UILabel *)[currentSelectedGridCell viewWithTag:2];
                    Lbl_2.text = @"Description: ";
                    UILabel *Lbl_3 = (UILabel *)[currentSelectedGridCell viewWithTag:3];
                    Lbl_3.text = @"";
                    
                    currentSelectedGridCell.lblArtistName.text=objCurrentOccution.strtitle;
                    NSString *ht = [ClsSetting getAttributedStringFormHtmlString:objCurrentOccution.strPrdescription];
                    currentSelectedGridCell.lblMedium.text= ht;
                    currentSelectedGridCell.lblYear.text= @"";
                    currentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                    
                }
                else
                {
                    currentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                    currentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                    currentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                    currentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    currentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                }

                
                currentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                currentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                currentSelectedGridCell.CurrentOccutiondelegate=self;
                currentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                currentSelectedGridCell.btnbidNow.tag=indexPath.row;
                currentSelectedGridCell.btnproxy.tag=indexPath.row;
                currentSelectedGridCell.btnBidHistory.tag=indexPath.row;
                currentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                currentSelectedGridCell.CurrentOccutiondelegate=self;
                
                currentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                [ClsSetting SetBorder:currentSelectedGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]]
                ;
                if (![objCurrentOccution.strStatus isEqualToString:@"Current"])
                {
                    currentSelectedGridCell.btnbidNow.hidden = YES;
                    currentSelectedGridCell.btnproxy.hidden=NO;
                    currentSelectedGridCell.btnproxy.tag=indexPath.row;
                    UILabel *countdowntitle_Lbl = (UILabel *)[currentSelectedGridCell viewWithTag:113];
                    countdowntitle_Lbl.hidden = YES;
                    currentSelectedGridCell.lblCoundown.hidden = YES;
                    currentSelectedGridCell.btnproxy.enabled = YES;
                    currentSelectedGridCell.btnbidNow.backgroundColor = [UIColor blackColor];
                    UILabel *lineview = (UILabel *)[currentSelectedGridCell viewWithTag:112];
                    lineview.hidden = YES;
                }
                else
                {
//                    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                    if ([objCurrentOccution.strtimeRemains intValue] < 0)
                    {
                        currentSelectedGridCell.btnbidNow.enabled = NO;
                        currentSelectedGridCell.btnproxy.enabled = NO;
                        currentSelectedGridCell.btnbidNow.backgroundColor = [UIColor grayColor];
                        currentSelectedGridCell.btnproxy.backgroundColor = [UIColor grayColor];
                        currentSelectedGridCell.lblCoundown.text=@"Auction Closed";
                    }
                    else
                    {
                        currentSelectedGridCell.btnbidNow.enabled = YES;
                        currentSelectedGridCell.btnproxy.enabled = YES;
                        currentSelectedGridCell.btnbidNow.backgroundColor = [UIColor blackColor];
                        currentSelectedGridCell.btnproxy.backgroundColor = [UIColor blackColor];
                        currentSelectedGridCell.lblCoundown.text=objCurrentOccution.strmyBidClosingTime;
                    }

                    UILabel *lineview = (UILabel *)[currentSelectedGridCell viewWithTag:112];
                    lineview.hidden = NO;
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            currentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                            currentSelectedGridCell.btnbidNow.hidden = YES;
                            currentSelectedGridCell.btnproxy.hidden = YES;
                            UILabel *leading_Lbl = (UILabel *)[currentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = NO;
                            if ([objCurrentOccution.strtimeRemains intValue] < 0)
                            {
                                leading_Lbl.text = @"Lot won";
                            }
                            else
                            {
                                leading_Lbl.text = @"You are currently the highest bidder.";
                            }
                        }
                        else
                        {
                            currentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                            currentSelectedGridCell.btnbidNow.hidden = NO;
                            currentSelectedGridCell.btnproxy.hidden = NO;
                            UILabel *leading_Lbl = (UILabel *)[currentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = YES;
                        }
                    }
                }
                cell = currentSelectedGridCell;
            }
            else
            {
                if (_isCurrent == 1)
                {
                    currentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                }
                else
                {
                    currentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpcommingDefult" forIndexPath:indexPath];

                }
                currentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
                
                [self addTapGestureOnProductimage:currentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                
                NSInteger currentBid;
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    currentBid = [objCurrentOccution.strpriceus integerValue];
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    currentBid = [objCurrentOccution.strpricers integerValue];
                }
                
                currentDefultGridCell.lblCurrentBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                
                NSInteger incresedPrice;
                if ([objCurrentOccution.strpricers intValue] >= 10000000)
                {
                    NSInteger incresedRate = (currentBid*5)/100;
                    incresedPrice = currentBid + incresedRate;
                }
                else
                {
                    NSInteger incresedRate = (currentBid*10)/100;
                    incresedPrice = currentBid + incresedRate;
                }
                
                if (_isCurrent == 1)
                {
                    currentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
                }
                else
                {
                    currentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                }
                
                if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                {
                    currentDefultGridCell.btnArtist.hidden= YES;
                    currentDefultGridCell.lblArtistName.hidden= YES;
                }
                else
                {
                    currentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                    
                }
                
                currentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                
                currentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                [ClsSetting SetBorder:currentDefultGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                
                currentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                currentDefultGridCell.btnMyGallery.tag=indexPath.row;
                currentDefultGridCell.btnDetail.tag=indexPath.row;
                currentDefultGridCell.btnArtist.tag=indexPath.row;
                currentDefultGridCell.objCurrentOccution=objCurrentOccution;
                currentDefultGridCell.CurrentOccutiondelegate=self;

//                NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                if ([objCurrentOccution.strtimeRemains intValue] < 0)
                    currentDefultGridCell.lblCoundown.text=@"Auction Closed";
                else
                    currentDefultGridCell.lblCoundown.text=objCurrentOccution.strmyBidClosingTime;
                
                
                if (![objCurrentOccution.strStatus isEqualToString:@"Current"])
                {
                    UILabel *countdowntitle_Lbl = (UILabel *)[currentDefultGridCell viewWithTag:113];
                    countdowntitle_Lbl.hidden = YES;
                    currentDefultGridCell.lblCoundown.hidden = YES;
                    UILabel *lineview = (UILabel *)[currentDefultGridCell viewWithTag:112];
                    lineview.hidden = YES;
                }
                else
                {
                    currentDefultGridCell.lblCoundown.hidden = NO;
                    UILabel *countdowntitle_Lbl = (UILabel *)[currentDefultGridCell viewWithTag:113];
                    countdowntitle_Lbl.hidden = NO;
                    currentDefultGridCell.lblCoundown.hidden = NO;
                    UILabel *lineview = (UILabel *)[currentDefultGridCell viewWithTag:112];
                    lineview.hidden = NO;
                    
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            currentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                            currentDefultGridCell.btnbidNow.hidden = YES;
                            currentDefultGridCell.btnproxy.hidden = YES;
                            UILabel *leading_Lbl = (UILabel *)[currentDefultGridCell viewWithTag:111];
                            leading_Lbl.hidden = NO;
                            if ([objCurrentOccution.strtimeRemains intValue] < 0)
                            {
                                leading_Lbl.text = @"Lot won";
                            }
                            else
                            {
                                leading_Lbl.text = @"You are currently the highest bidder.";
                            }
                        }
                        else
                        {
                            currentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                            currentDefultGridCell.btnbidNow.hidden = NO;
                            currentDefultGridCell.btnproxy.hidden = NO;
                            UILabel *leading_Lbl = (UILabel *)[currentDefultGridCell viewWithTag:111];
                            leading_Lbl.hidden = YES;
                        }
                    }
                }
                cell = currentDefultGridCell;
            }
        [ClsSetting SetBorder:cell cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (section==0 )
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 20);
    }
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    
}
-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:1];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [self.clvMyAuctionGallery reloadItemsAtIndexPaths: arrindexpath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnMaximizepressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:1];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
//#if TRY_AN_ANIMATED_GIF == 1
//    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
//#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL],objCurrentOccution.strimage]];
//#endif
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)[_clvMyAuctionGallery cellForItemAtIndexPath:indexPath];
    // CurrentDefultGridCollectionViewCell *cell1= (CurrentDefultGridCollectionViewCell*)cell;
    imageInfo.referenceRect = cell.imgProduct.frame;
    imageInfo.referenceView = cell.imgProduct.superview;
    imageInfo.referenceContentMode = cell.imgProduct.contentMode;
    imageInfo.referenceCornerRadius = cell.imgProduct.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    /*  UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
     DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
     objProductViewController.objCurrentOccution=objCurrentOccution;
     [navcontroll pushViewController:objProductViewController animated:YES];*/
}

-(void)addTapGestureOnProductimage:(UIImageView*)imgProduct indexpathrow:(NSInteger)indexpathrow
{
    imgProduct.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    imgProduct.tag=indexpathrow;
    [imgProduct addGestureRecognizer:tapGesture1];
    
}

- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    int index = ((int)tapGesture.view.tag);
    [self showDetailPage:index];
}

-(void)showDetailPage:(int)index
{
    clsCurrentOccution *objCurrentOccution=[arrMyAuctionGallery objectAtIndex:index];
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.objCurrentOccution=objCurrentOccution;
    if ([objCurrentOccution.strStatus isEqualToString:@"Current"])
    {
        objProductViewController.IsCurrent = 1;
    }
    else
    {
        objProductViewController.IsUpcomming = 1;
    }
    objProductViewController.IsPast = 0;
    
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//    {
//        objProductViewController.iscurrencyInDollar=1;
//    }
//    else
//    {
//        objProductViewController.iscurrencyInDollar=0;
//    }
    [navcontroll pushViewController:objProductViewController animated:YES];
    
}
- (IBAction)btnBidNowPressed:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
                objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=TRUE;
//                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=0;
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
- (IBAction)btnProxyBid:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
                objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
               
                if (_isCurrent == 1)
                {
                    objAuctionItemBidViewController.isBidNow = NO;
                    objAuctionItemBidViewController.IsUpcoming = 0;

                }
                else
                {
                    objAuctionItemBidViewController.isBidNow = NO;
                    objAuctionItemBidViewController.IsUpcoming = 1;

                }
                
//                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar = 1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar = 0;
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
- (IBAction)detailpageClicked:(UIButton*)sender
{
    int indexpath=((int)sender.tag);
    [self showDetailPage:indexpath];
}
- (IBAction)btnBidHistoryPressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
    BidHistoryViewController *objBidHistoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
//    objBidHistoryViewController.IsSort = 1;
    if ([objCurrentOccution.strStatus isEqualToString:@"Current"])
    {
        objBidHistoryViewController.IsUpcoming = 0;
    }
    else
    {
        objBidHistoryViewController.IsUpcoming = 1;
    }
    objBidHistoryViewController.objCurrentOuction=objCurrentOccution;
    
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}

- (IBAction)btnDelete:(UIButton*)sender
{
    WebserviceCount = 0;
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWebDelete:dict url:[NSString stringWithFormat:@"bidartistuser?api_key=%@&filter=bidartistuserid=%@",[ClsSetting apiKey],objCurrentOccution.strbidartistuserid] view:self.view Post:NO];
}

-(void)RefreshMyGallery
{
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    @try {
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@getMyGallery?api_key=%@&filter=userid=%@",[ClsSetting tableURL],[ClsSetting apiKey],strUserName];
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
             
             [arrItemCount removeAllObjects];
             arrItemCount=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
             
             NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
             NSMutableArray *arrUpcommingAuction = [[NSMutableArray alloc]init];
             
             for (int i=0; i<arrItemCount.count ; i++)
             {
                 clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
                 
                 if ([objCurrentOccution.strStatus isEqualToString:@"Current"])
                 {
                     [arrCurrentAuction addObject:objCurrentOccution];
                 }
                 else
                 {
                     [arrUpcommingAuction addObject:objCurrentOccution];
                 }
             }
             
             if (self.isCurrent == 1)
             {
                 for (int i=0; i<arrMyAuctionGallery.count; i++)
                 {
                     clsCurrentOccution *objacution = [arrMyAuctionGallery objectAtIndex:i];
                     for (int j=0; j<arrCurrentAuction.count; j++)
                     {
                         clsCurrentOccution *objFilterResult = [arrCurrentAuction objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                         {
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             break;
                         }
                     }
                 }
                 [arrMyAuctionGallery removeAllObjects];
                 arrMyAuctionGallery = arrCurrentAuction;
             }
             else
             {
                 for (int i=0; i<arrMyAuctionGallery.count; i++)
                 {
                     clsCurrentOccution *objacution=[arrMyAuctionGallery objectAtIndex:i];
                     for (int j=0; j<arrUpcommingAuction.count; j++)
                     {
                         clsCurrentOccution *objFilterResult=[arrUpcommingAuction objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                         {
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             break;
                         }
                     }
                 }
                 [arrMyAuctionGallery removeAllObjects];
                 arrMyAuctionGallery = arrUpcommingAuction;
             }
             
             if (arrMyAuctionGallery.count == 0)
             {
                 _lblNoRecords.hidden = NO;
                 _lblNoRecords.text = @"You haven’t added anything to the gallery.";
                 _clvMyAuctionGallery.hidden=YES;
                 [timer invalidate];
                 timer = nil;
             }
             else
             {
                 _lblNoRecords.hidden = YES;
                 _clvMyAuctionGallery.hidden=NO;
             }
             [_clvMyAuctionGallery reloadData];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
             }];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
}

- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
    ArtistViewController *objArtistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//    {
//        objArtistViewController.iscurrencyInDollar=1;
//    }
//    else
//    {
//        objArtistViewController.iscurrencyInDollar=0;
//    }
    
    objArtistViewController.objCurrentOccution1 = objCurrentOccution;
    [self.navigationController pushViewController:objArtistViewController animated:YES];
}


- (IBAction)btnCurrentAuctionPressed:(UIButton *)sender
{
    self.isCurrent = 1;
    
    
    self.lblCurrentLine.backgroundColor = [UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1];
    self.lblCurrentLine.hidden = NO;
    self.lblUpcommingLine.backgroundColor = [UIColor grayColor];
    self.lblUpcommingLine.hidden = YES;

    
    NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc] init];
    
    for (int i=0; i<arrItemCount.count ; i++)
    {
        clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
        
        if ([objCurrentOccution.strStatus isEqualToString:@"Current"])
        {
            [arrCurrentAuction addObject:objCurrentOccution];
        }
    }
    
    
    for (int i=0; i<arrMyAuctionGallery.count; i++)
    {
        clsCurrentOccution *objacution = [arrMyAuctionGallery objectAtIndex:i];
        for (int j=0; j<arrCurrentAuction.count; j++)
        {
            clsCurrentOccution *objFilterResult = [arrCurrentAuction objectAtIndex:j];
            if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
            {
                objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                break;
            }
        }
    }
    [arrMyAuctionGallery removeAllObjects];
    arrMyAuctionGallery = arrCurrentAuction;
    
    if (arrMyAuctionGallery.count == 0)
    {
        _lblNoRecords.hidden = NO;
        _lblNoRecords.text = @"You haven’t added anything to the gallery.";
        _clvMyAuctionGallery.hidden=YES;
        [timer invalidate];
        timer = nil;
    }
    else
    {
        _lblNoRecords.hidden = YES;
        _clvMyAuctionGallery.hidden=NO;
    }
    [_clvMyAuctionGallery reloadData];
    
}

- (IBAction)btnUpcommingAuctionPressed:(UIButton *)sender
{
    self.isCurrent = 0;
    
    self.lblCurrentLine.backgroundColor = [UIColor grayColor];
    self.lblCurrentLine.hidden = YES;
    self.lblUpcommingLine.backgroundColor = [UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1];
    self.lblUpcommingLine.hidden = NO;
    
    NSMutableArray *arrUpcommingAuction = [[NSMutableArray alloc]init];
    
    for (int i=0; i<arrItemCount.count ; i++)
    {
        clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
        
        if ([objCurrentOccution.strStatus isEqualToString:@"Upcomming"])
        {
            [arrUpcommingAuction addObject:objCurrentOccution];
        }
    }
    
    for (int i=0; i<arrMyAuctionGallery.count; i++)
    {
        clsCurrentOccution *objacution=[arrMyAuctionGallery objectAtIndex:i];
        for (int j=0; j<arrUpcommingAuction.count; j++)
        {
            clsCurrentOccution *objFilterResult=[arrUpcommingAuction objectAtIndex:j];
            if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
            {
                objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                break;
            }
        }
    }
    [arrMyAuctionGallery removeAllObjects];
    arrMyAuctionGallery = arrUpcommingAuction;
    
    if (arrMyAuctionGallery.count == 0)
    {
        _lblNoRecords.hidden = NO;
        _lblNoRecords.text = @"You haven’t added anything to the gallery.";
        _clvMyAuctionGallery.hidden=YES;
        [timer invalidate];
        timer = nil;
    }
    else
    {
        _lblNoRecords.hidden = YES;
        _clvMyAuctionGallery.hidden=NO;
    }
    [_clvMyAuctionGallery reloadData];
    
}

- (IBAction)btnCurrencyPressed:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        self.lblCurrency.text = @"INR";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUSD"];
        [_clvMyAuctionGallery reloadData];
    }
    else
    {
        self.lblCurrency.text = @"USD";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isUSD"];
        [_clvMyAuctionGallery reloadData];
    }
}

@end
