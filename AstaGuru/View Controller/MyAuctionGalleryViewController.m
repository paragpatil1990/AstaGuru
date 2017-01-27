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
    BOOL isList;
    int WebserviceCount;
    NSTimer *timer;
}
@end

@implementation MyAuctionGalleryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  [self getMyOccttionGallery];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
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
}
-(void)getMyOccttionGallery
{
    //USE LIMIT 10
    
    WebserviceCount=1;
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
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"getMyGallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=userid=%@",strUserName] view:self.view Post:NO];
    
}

-(void)getMyBidData
{
    WebserviceCount=2;
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"mygallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@&related=*",strUserName] view:self.view Post:NO];
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
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
   // arrItemCount=[parese parsePastOccution:[dict1 valueForKey:@"resource"]];
   
    
   
    if (WebserviceCount==1)
    {
        arrMyAuctionGallery=[[NSMutableArray alloc]init];
         arrItemCount=[parese parseSortCurrentAuction:[dict1 valueForKey:@"resource"]];
         [arrMyAuctionGallery addObjectsFromArray:arrItemCount];
        //[self getMyBidData];
    }
    else
    {
        [self getMyOccttionGallery];

    }
    _clvMyAuctionGallery.hidden=NO;
    [_clvMyAuctionGallery reloadData];
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   
        return 2;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
       return   CGSizeMake((collectionView1.frame.size.width),20);
    }
    else
    {
        if (isList==TRUE)
        {
            return   CGSizeMake((collectionView1.frame.size.width)-10,134);
        }
        return   CGSizeMake((collectionView1.frame.size.width/2)-10,340);//286);
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
    
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
//    UICollectionViewCell *cell1;
    
    // if (isList==FALSE)
   // {
    
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
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                
                if ([objCurrentOccution.strpricers intValue] > 10000000) // 10000000
                {
                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpriceus intValue];
                        int priceIncreaserete=(price*5)/100;
                        int FinalPrice=price+priceIncreaserete;
                        
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                        
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpricers intValue];
                        int priceIncreaserete=(price*5)/100;
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        
                        //  NSString *strFromRangeString;
                        // NSString *strToRangeString;
                        NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                        NSArray *subStrings = [objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                            
                            CurrentSelectedGridCell.lblEstimation.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                            
                        }
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    }
                }
                else
                {
                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpriceus intValue];
                        int priceIncreaserete=(price*10)/100;
                        int FinalPrice=price+priceIncreaserete;
                        
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                        
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpricers intValue];
                        int priceIncreaserete=(price*10)/100;
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        
                        //  NSString *strFromRangeString;
                        // NSString *strToRangeString;
                        NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                        NSArray *subStrings = [objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                            
                            CurrentSelectedGridCell.lblEstimation.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                            
                        }
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    }
                }
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize] ;
                CurrentSelectedGridCell.layer.borderWidth=1;
                CurrentSelectedGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentSelectedGridCell.btnbidNow.tag=indexPath.row;
                CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                CurrentSelectedGridCell.btnBidHistory.tag=indexPath.row;
                CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                
                CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                CurrentSelectedGridCell.lblLot.layer.cornerRadius = 8;
                CurrentSelectedGridCell.lblLot.layer.borderWidth = 1;
                CurrentSelectedGridCell.lblLot.layer.borderColor = [UIColor clearColor].CGColor;
                CurrentSelectedGridCell.lblLot.clipsToBounds = YES;
                CurrentSelectedGridCell.btnLot.hidden = YES;
                
                if (![objCurrentOccution.strStatus isEqualToString:@"Current"])
                {
                    CurrentSelectedGridCell.btnbidNow.hidden = YES;
                    CurrentSelectedGridCell.btnproxy.hidden=NO;
                    CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                    UILabel *countdowntitle_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:113];
                    countdowntitle_Lbl.hidden = YES;
                    CurrentSelectedGridCell.lblCoundown.hidden = YES;
                    CurrentSelectedGridCell.btnproxy.enabled = YES;
                    CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor blackColor];
                    UILabel *lineview = (UILabel *)[CurrentSelectedGridCell viewWithTag:112];
                    lineview.hidden = YES;
                }
                else
                {
                    UILabel *lineview = (UILabel *)[CurrentSelectedGridCell viewWithTag:112];
                    lineview.hidden = NO;
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                            CurrentSelectedGridCell.btnbidNow.hidden = YES;
                            CurrentSelectedGridCell.btnproxy.hidden = YES;
                            UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = NO;
                        }
                        else
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                            CurrentSelectedGridCell.btnbidNow.hidden = NO;
                            CurrentSelectedGridCell.btnproxy.hidden = NO;
                            UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = YES;
                        }
                    }

                    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                    if ([timeStr isEqualToString:@""])
                    {
                        CurrentSelectedGridCell.btnbidNow.enabled = NO;
                        CurrentSelectedGridCell.btnproxy.enabled = NO;
                        CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor grayColor];
                        CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor grayColor];
                        CurrentSelectedGridCell.lblCoundown.text=@"Auction Closed";
                    }
                    else
                    {
                        CurrentSelectedGridCell.btnbidNow.enabled = YES;
                        CurrentSelectedGridCell.btnproxy.enabled = YES;
                        CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor blackColor];
                        CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor blackColor];
                        CurrentSelectedGridCell.lblCoundown.text=timeStr;
                    }
                }
                cell = CurrentSelectedGridCell;
            }
            else
            {
                CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                
                [ClsSetting SetBorder:CurrentDefultGridCell.nextView cornerRadius:2 borderWidth:1];
                CurrentDefultGridCell.nextView.layer.borderColor = [UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1].CGColor;
                
                if ([objCurrentOccution.strpricers intValue] > 10000000) // 10000000
                {
                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                        
                        CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpriceus intValue];
                        int priceIncreaserete=(price*5)/100;
                        
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                        CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpricers intValue];
                        int priceIncreaserete=(price*5)/100;
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    }
                }
                else{
                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                        
                        
                        CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpriceus intValue];
                        int priceIncreaserete=(price*10)/100;
                        
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                        
                        
                        
                        CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[objCurrentOccution.strpricers intValue];
                        int priceIncreaserete=(price*10)/100;
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        
                    }
                }
                
                CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                CurrentDefultGridCell.lblMedium.text= objCurrentOccution.strmedium;
                CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.strmedium;
                
                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
                
                CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                CurrentDefultGridCell.lblLot.layer.cornerRadius = 8;
                CurrentDefultGridCell.lblLot.layer.borderWidth = 1;
                CurrentDefultGridCell.lblLot.layer.borderColor = [UIColor clearColor].CGColor;
                CurrentDefultGridCell.lblLot.clipsToBounds = YES;
                CurrentDefultGridCell.btnLot.hidden = YES;
                
                CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentDefultGridCell.btnMyGallery.tag=indexPath.row;
                CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                
                NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                if ([timeStr isEqualToString:@""])
                    CurrentDefultGridCell.lblCoundown.text=@"Auction Closed";
                else
                    CurrentDefultGridCell.lblCoundown.text=timeStr;
                
                
                cell.layer.borderWidth=1;
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",[ ClsSetting TrimWhiteSpaceAndNewLine:objCurrentOccution.strReference]] forState:UIControlStateNormal];
                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                
                if (![objCurrentOccution.strStatus isEqualToString:@"Current"])
                {
                    UILabel *countdowntitle_Lbl = (UILabel *)[CurrentDefultGridCell viewWithTag:113];
                    countdowntitle_Lbl.hidden = YES;
                    CurrentDefultGridCell.lblCoundown.hidden = YES;
                    UILabel *lineview = (UILabel *)[CurrentDefultGridCell viewWithTag:112];
                    lineview.hidden = YES;
                }
                else
                {
                    CurrentDefultGridCell.lblCoundown.hidden = NO;
                    UILabel *countdowntitle_Lbl = (UILabel *)[CurrentDefultGridCell viewWithTag:113];
                    countdowntitle_Lbl.hidden = NO;
                    CurrentDefultGridCell.lblCoundown.hidden = NO;
                    UILabel *lineview = (UILabel *)[CurrentDefultGridCell viewWithTag:112];
                    lineview.hidden = NO;
                    
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                            CurrentDefultGridCell.btnbidNow.hidden = YES;
                            CurrentDefultGridCell.btnproxy.hidden = YES;
                            UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = NO;
                        }
                        else
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                            CurrentDefultGridCell.btnbidNow.hidden = NO;
                            CurrentDefultGridCell.btnproxy.hidden = NO;
                            UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                            leading_Lbl.hidden = YES;
                        }
                    }
                }
                cell = CurrentDefultGridCell;
            }
       /*if ([objCurrentOccution.strTypeOfCell intValue]==1)
        {
            CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
            
        
            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
            CurrentSelectedGridCell.lblProductName.text=objCurrentOccution.strtitle;
           
            CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
            CurrentSelectedGridCell.lblSize.text= objCurrentOccution.strproductsize;
    
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
            
            
            NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
            NSDate *todaydate = [dateFormat dateFromString:strToday];
            
            NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
            CurrentSelectedGridCell.lblCoundown.text=strCondown;
            CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.objCurrentAuction.strestamiate;
            CurrentSelectedGridCell.hidden=YES;
            CurrentSelectedGridCell.isMyAuctionGallery=1;
            CurrentSelectedGridCell.iSelectedIndex=indexPath.row;
            CurrentSelectedGridCell.layer.borderWidth=1;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
            CurrentSelectedGridCell.CurrentOccutiondelegate=self;
            CurrentSelectedGridCell.iSelectedIndex=indexPath.row;
            CurrentSelectedGridCell.objMyAuctionGallery=objCurrentOccution;
           
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter setMaximumFractionDigits:0];
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strpricers];
                
                
                CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int price =[objCurrentOccution.strBidpriceus intValue];
                int priceIncreaserete=(price*10)/100;
                
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            }
            else
            {
                numberFormatter.currencyCode = @"INR";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strBidpricers];
                
                
                
                CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int price =[objCurrentOccution.strBidpricers intValue];
                int priceIncreaserete=(price*10)/100;
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                
                
                NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                NSArray *subStrings = [objCurrentOccution.objCurrentAuction.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
                if (subStrings.count>1)
                {
                    // strFromRangeString = [subStrings objectAtIndex:0];
                    //  strToRangeString = [subStrings objectAtIndex:1];
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.numberStyle = NSNumberFormatterDecimalStyle;
                    NSString *strFromRangeString = [[subStrings objectAtIndex:0] stringByTrimmingCharactersInSet:nonNumbersSet];
                    NSString *strToRangeString = [[subStrings objectAtIndex:1] stringByTrimmingCharactersInSet:nonNumbersSet];
                    
                    float Fromnumber = [[formatter numberFromString:strFromRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                    
                    float Tonumber = [[formatter numberFromString:strToRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                    
                    NSString *strFromRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Fromnumber]];
                    NSString *strToRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Tonumber]];
                    
                    CurrentSelectedGridCell.lblEstimation.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                }
                
                
            }
            
            
            
           //[[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
            
            [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
            [UIView animateWithDuration:1.0
                                  delay:0
                                options:(UIViewAnimationOptionAllowUserInteraction)
                             animations:^
             {
                 NSLog(@"starting animation");
                 
                 [UIView transitionFromView:CurrentDefultGridCell.contentView
                                     toView:CurrentSelectedGridCell
                                   duration:5
                                    options:UIViewAnimationOptionTransitionFlipFromRight
                                 completion:nil];
             }
                             completion:^(BOOL finished)
             {
                 NSLog(@"animation end");
                 CurrentSelectedGridCell.hidden=NO;
             }
             ];
            
            cell = CurrentSelectedGridCell;
            
            
            
            
            
            
        }
        else
        {
            
            CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
            CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strThumbnail]];
        
            CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstname,objCurrentOccution.strFirstname];
        
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
            CurrentDefultGridCell.lblProductName.text= objCurrentOccution.objCurrentAuction.strtitle;
            //CurrentDefultGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
           // CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
            //CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
            
            CurrentDefultGridCell.iSelectedIndex=indexPath.row;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strdaterec];
            CurrentDefultGridCell.objMyAuctionGallery=objCurrentOccution;
            CurrentDefultGridCell.btnDetail.tag=indexPath.row;
            CurrentDefultGridCell.btnArtist.tag=indexPath.row;
            CurrentDefultGridCell.isMyAuctionGallery=1;
            CurrentDefultGridCell.iSelectedIndex=indexPath.row;
            NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
            NSDate *todaydate = [dateFormat dateFromString:strToday];
            
            NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
            CurrentDefultGridCell.lblCoundown.text=strCondown;
            cell.layer.borderWidth=1;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter setMaximumFractionDigits:0];
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strBidpriceus];
                
                
                CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int price =[objCurrentOccution.strBidpriceus intValue];
                int priceIncreaserete=(price*10)/100;
                
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            }
            else
            {
                numberFormatter.currencyCode = @"INR";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strBidpricers];
                
                
                
                CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int price =[objCurrentOccution.strBidpricers intValue];
                int priceIncreaserete=(price*10)/100;
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                
            }
            
            
            
            CurrentDefultGridCell.CurrentOccutiondelegate=self;
            cell = CurrentDefultGridCell;
        
   }*/
   /*  else
    {
        if ([objCurrentOccution.strTypeOfCell intValue]==1)
        {
            CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelectedList" forIndexPath:indexPath];
            
            [UIView transitionWithView:CurrentDefultGridCell.contentView
             duration:5
             options:UIViewAnimationOptionTransitionFlipFromLeft
             animations:^{
             
             CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
             
             
             } completion:nil];
            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
            CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
            CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
            CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
            CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
            CurrentSelectedGridCell.lblSize.text= objCurrentOccution.strproductsize;
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
            
            
            NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
            NSDate *todaydate = [dateFormat dateFromString:strToday];
            
            NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
            CurrentSelectedGridCell.lblCoundown.text=strCondown;
            CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
            CurrentSelectedGridCell.hidden=YES;
            CurrentSelectedGridCell.layer.borderWidth=1;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strproductid] forState:UIControlStateNormal];
            CurrentSelectedGridCell.CurrentOccutiondelegate=self;
            CurrentSelectedGridCell.iSelectedIndex=indexPath.row;
            CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
            CurrentSelectedGridCell.CurrentOccutiondelegate=self;
            
            
            [UIView animateWithDuration:1.0
                                  delay:0
                                options:(UIViewAnimationOptionAllowUserInteraction)
                             animations:^
             {
                 NSLog(@"starting animation");
                 
                 [UIView transitionFromView:CurrentDefultGridCell.contentView
                                     toView:CurrentSelectedGridCell
                                   duration:5
                                    options:UIViewAnimationOptionTransitionFlipFromRight
                                 completion:nil];
             }
                             completion:^(BOOL finished)
             {
                 NSLog(@"animation end");
                 CurrentSelectedGridCell.hidden=NO;
             }
             ];
            
            cell = CurrentSelectedGridCell;
            
            
            
            
            
            
        }
        else
        {
            
            CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefultList" forIndexPath:indexPath];
            CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
            CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
            CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
            CurrentDefultGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
            CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
            CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
            
            CurrentDefultGridCell.iSelectedIndex=indexPath.row;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
            CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
            CurrentDefultGridCell.btnDetail.tag=indexPath.row;
            CurrentDefultGridCell.btnArtist.tag=indexPath.row;
            NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
            NSDate *todaydate = [dateFormat dateFromString:strToday];
            
            if (objCurrentOccution.IsSwapOn==1)
            {
                CurrentDefultGridCell.viwSwap.frame=CGRectMake((CurrentDefultGridCell.viwSwap.frame.size.width/4)-CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
            }
            else
            {
                CurrentDefultGridCell.viwSwap.frame=CGRectMake(0, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
            }
            NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
            CurrentDefultGridCell.lblCoundown.text=strCondown;
            cell.layer.borderWidth=1;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strproductid] forState:UIControlStateNormal];
            CurrentDefultGridCell.CurrentOccutiondelegate=self;
            cell = CurrentDefultGridCell;
            
            
            
            
        }
    }
    */
        cell.layer.borderWidth=1;
        cell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;

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

-(NSString*)timercount:(NSString*)dateStr fromDate:(NSString*)fromdate
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    
}
-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:1];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [self.clvMyAuctionGallery reloadItemsAtIndexPaths: arrindexpath];
    
    //[_clvCurrentOccution reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:x section:0]];
    
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
    
    
    //UICollectionViewCell *cell = [_clvCurrentOccution ]
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:1];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
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
    int indexpath=((int)tapGesture.view.tag);
    NSLog(@"ind %d",indexpath);
    [self showDetailPage:indexpath];
    
}
-(void)showDetailPage:(int)indexpath
{
    clsCurrentOccution *objCurrentOccution=[arrMyAuctionGallery objectAtIndex:indexpath];
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    //objProductViewController.IsSort=IsSort;
    objProductViewController.objCurrentOccution=objCurrentOccution;
    objProductViewController.IsSort=1;
    if (![objCurrentOccution.strStatus isEqualToString:@"Current"])
    {
        objProductViewController.IsUpcomming=1;
    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        objProductViewController.iscurrencyInDollar=1;
    }
    else
    {
        objProductViewController.iscurrencyInDollar=0;
    }
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
                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
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
                objAuctionItemBidViewController.isBidNow=FALSE;
                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
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
    objBidHistoryViewController.IsSort = 1;
    if (![objCurrentOccution.strStatus isEqualToString:@"Current"])
    {
        objBidHistoryViewController.IsUpcoming=1;
    }
    objBidHistoryViewController.objCurrentOuction=objCurrentOccution;
    
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}
- (IBAction)btnDelete:(UIButton*)sender
{
    WebserviceCount=3;
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
   // NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWebDelete:dict url:[NSString stringWithFormat:@"bidartistuser?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=bidartistuserid=%@",objCurrentOccution.strbidartistuserid] view:self.view Post:NO];
}

-(void)RefreshMyGallery
{
    /* NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
     ClsSetting *objSetting=[[ClsSetting alloc]init];
     [objSetting CallWeb:dict url:[NSString stringWithFormat:@"%@?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",strFunctionName] view:_mainView Post:NO];
     objSetting.PassReseposeDatadelegate=self;
     */
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    @try {
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@getMyGallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=userid=%@",[objsetting Url],strUserName];
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
             NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
             // arrMyAuctionGallery=[[NSMutableArray alloc]init];
             arrItemCount=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
             for (int i=0; i<arrMyAuctionGallery.count; i++)
             {
                 clsCurrentOccution *objacution=[arrMyAuctionGallery objectAtIndex:i];
                 for (int j=0; j<arrItemCount.count; j++)
                 {
                     clsCurrentOccution *objsortacution=[arrItemCount objectAtIndex:j];
                     if ([objacution.strproductid intValue]==[objsortacution.strproductid intValue])
                     {
                         objsortacution.IsSwapOn=objacution.IsSwapOn;
                         objsortacution.strTypeOfCell=objacution.strTypeOfCell;
                         
                         break;
                     }
                 }
             }
             [arrMyAuctionGallery removeAllObjects];
             arrMyAuctionGallery=arrItemCount;
             //[arrMyAuctionGallery addObjectsFromArray:arrItemCount];
             [_clvMyAuctionGallery reloadData];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
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
-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
}

- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
    ArtistViewController *objArtistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        objArtistViewController.iscurrencyInDollar=1;
    }
    else
    {
        objArtistViewController.iscurrencyInDollar=0;
    }
    
    objArtistViewController.objCurrentOccution=objCurrentOccution;
    [self.navigationController pushViewController:objArtistViewController animated:YES];
}
@end
