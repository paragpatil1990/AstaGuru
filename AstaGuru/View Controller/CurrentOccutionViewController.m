//
//  CurrentOccutionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CurrentOccutionViewController.h"
#import "ClsSetting.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "TopStaticCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
#import "DetailProductViewController.h"
#import "ViewController.h"
#import "ArtistViewController.h"
#import "PastOccuctionViewController.h"
#import "MyAuctionGalleryViewController.h"
#import "AuctionItemBidViewController.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "AfterLoginViewController.h"
#import "BforeLoginViewController.h"
#import "BidHistoryViewController.h"
#import "FilterViewController.h"
#import "AppDelegate.h"
#import "VerificationViewController.h"
#define TRY_AN_ANIMATED_GIF 0
@interface CurrentOccutionViewController ()<PassResepose,CurrentOccution,UIGestureRecognizerDelegate,SortCurrentAuction,Filter>
{
    int iOffset;
    NSMutableArray *arrOccution;
    CGRect *selectedCellDefaultFrame;
    NSMutableArray *arrBottomMenu;
    BOOL isReloadDate;
    BOOL isList;
    BOOL isUSD;
    int WebservicesCount;
    int IsSort;
    NSMutableArray *arrSelectedArtistarray;
    AppDelegate *objAppDelegate;
    NSTimer *timer;
    NSTimer *countDownTimer;

}
@end

@implementation CurrentOccutionViewController

- (void)viewDidLoad
{
    IsSort=1;
    [super viewDidLoad];
    arrOccution=[[NSMutableArray alloc]init];
    objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        isUSD=TRUE;
    }
    else
    {
        isUSD=FALSE;
    }
    
     arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"CURRENT",@"UPCOMING",@"PAST", nil];
    //_isSearch=FALSE;
    if(_isSearch==YES)
    {
       // arrOccution=_arrSearch;
       // [_clvCurrentOccution reloadData];
        
    }
    else
    {
        [self getCurrentAuction];
    }
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
    if(_isSearch==true)
    {
        arrOccution=_arrSearch;
      
        
    }
    [_clvCurrentOccution reloadData];
    
//    countDownTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(reloadCall) userInfo:nil repeats:YES];

}

-(void)getCurrentAuction
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    WebservicesCount=1;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"AuctionList?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)getOccttionData
{
   /* NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    WebservicesCount=2;
    http://54.169.222.181/api/v2/guru/_table/Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&limit=10&offset=21&related=*&filter=online=27
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&limit=10&offset=%d&related=*&filter=online=%@",iOffset,[[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentAuctionID"]] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;*/
    
    WebservicesCount=2;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"defaultlots?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)getFeaturedAuctionData
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&limit=10&offset=%d&related=* order by price desc ",iOffset] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    
    if (_iISFeatured==1)
    {
        self.navigationItem.title=@"Featured Product";
    }
    else
    {
    self.navigationItem.title=@"Current Auctions";
    }
    if (_isSearch ==1)
    {
      self.navigationController.navigationBar.backItem.title = @"Back";
    }
    else
    {
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
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
    if (_isSearch ==1)
    {
        [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem1]];
    }
    else
    {
    [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem,spaceFix1, barButtonItem1]];
    }
}
-(void)searchPressed
{
  [ClsSetting Searchpage:self.navigationController];   
}
-(void)myastaguru
{
    
    [ClsSetting myAstaGuru:self.navigationController];
    
}
-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    
    
    if (WebservicesCount==2)
    {
    arrItemCount=[parese parseSortCurrentAuction:[dict1 valueForKey:@"resource"]];
    
    if (arrItemCount.count==10)
    {
        isReloadDate=YES;
    }
    else
    {
        isReloadDate=NO;
    }
    [arrOccution addObjectsFromArray:arrItemCount];
    
    [_clvCurrentOccution reloadData];
    }
    else if (WebservicesCount==1)
    {
    arrItemCount=[parese parsePastOccution:[dict1 valueForKey:@"resource"]];
        for (int i=0; i< arrItemCount.count; i++)
        {
            clsPastAuctionData *objpastAuctionData=[arrItemCount objectAtIndex:i];
            if ([objpastAuctionData.strStatus isEqualToString:@"Current"])
            {
                [[NSUserDefaults standardUserDefaults]setValue:objpastAuctionData.strAuctionId forKey:@"CurrentAuctionID"];
                [[NSUserDefaults standardUserDefaults]setValue:objpastAuctionData.strDollarRate forKey:@"DollarRate"];
                
            }
            
        }
        [self getOccttionData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvCurrentOccution)
    {
      return 2;
    }
    else
    {
     return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvCurrentOccution)
    {
    if (indexPath.section==0)
    {
        return   CGSizeMake(collectionView1.frame.size.width,180);
    }
    else
    {
        if (isList==TRUE)
        {
            return   CGSizeMake((collectionView1.frame.size.width)-10,134);
        }
        return   CGSizeMake((collectionView1.frame.size.width/2)-7,340);
    }
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView==_clvCurrentOccution)
    {
    if (section==0)
    {
        if (_isSearch==0)
        {
        return 1;
        }
         return 0;
    }
    else
    {
    return  arrOccution.count;
    }
    }
    else
    {
        return arrBottomMenu.count;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    TopStaticCollectionViewCell *TopStaticCell;
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
    UICollectionViewCell *cell1;
    if (collectionView==_clvCurrentOccution)
    {
        if (indexPath.section==0)
        {
            TopStaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
            //        TopStaticCell.isRefreshstart=objAppDelegate.isfilterStart;
            //        TopStaticCell.iSelectedIndex=0;
            TopStaticCell.isRefreshstart=objAppDelegate.isRefreshstart;
            TopStaticCell.iSelectedIndex=objAppDelegate.isRefreshstart;
            if (isList==TRUE)
            {
                [TopStaticCell.btnGrid setImage:[UIImage imageNamed:@"icon-Grid-Def"] forState:UIControlStateNormal];
                [TopStaticCell.btnList setImage:[UIImage imageNamed:@"icon-list-sel"] forState:UIControlStateNormal];
                
            }
            else
            {
                [TopStaticCell.btnGrid setImage:[UIImage imageNamed:@"icon-grid"] forState:UIControlStateNormal];
                [TopStaticCell.btnList setImage:[UIImage imageNamed:@"icon-list"] forState:UIControlStateNormal];
            }
            if (isUSD)
            {
                TopStaticCell.lblCurrency.text=@"USD";
            }
            else
            {
                TopStaticCell.lblCurrency.text=@"INR";
            }
            TopStaticCell.mainView=self.view;
            TopStaticCell.passSortDataDelegate=self;
            if (arrOccution.count>0)
            {
                clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:0];
                //        NSString *auctionBanner = objCurrentOccution.strauctionBanner;
                EGOImageView *imgServices = (EGOImageView *)[TopStaticCell viewWithTag:22];
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strauctionBanner]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                imgServices.imageURL=[NSURL URLWithString:spaceUrl];
            }
            //TopStaticCell.iSelected=0;
            cell = TopStaticCell;
        }
        else
        {
            
            clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexPath.row];
            
            if (isList==FALSE)
            {
                NSLog(@"objCurrentOccution.strTypeOfCell == %@",objCurrentOccution.strTypeOfCell);
                if ([objCurrentOccution.strTypeOfCell intValue]==1)
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                    
                    CurrentSelectedGridCell.contentView.hidden = YES;
                    CurrentSelectedGridCell.imgProduct.hidden = YES;
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    if ([objCurrentOccution.strpricers intValue] > 10000000) // 10000000
                    {
                        if (isUSD==YES)
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
                            
                            [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:indexPath.row];
                            
                            //NSLog(@"%@ -> %.2f", result, [numberResult floatValue]);
                            
                            CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        }
                    }
                    else{
                        if (isUSD==YES)
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
                            
                            [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:indexPath.row];
                            
                            //NSLog(@"%@ -> %.2f", result, [numberResult floatValue]);
                            
                            CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        }
                    }
                    if (IsSort==1)
                    {
                        CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                        CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                        CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                    }
                    else
                    {
                        CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
                        CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
                        CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
                    }
                    
                    CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                    CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    
                    CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize] ;
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
                    
//                    CurrentSelectedGridCell.hidden=YES;
                    CurrentSelectedGridCell.layer.borderWidth=1;
                    
                    CurrentSelectedGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                    NSLog(@"User id = %@ /n Mysiteuserid = %@", [[NSUserDefaults standardUserDefaults] valueForKey:USER_id], objCurrentOccution.strmyuserid);
                    
                    CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    CurrentSelectedGridCell.lblLot.layer.cornerRadius = 8;
                    CurrentSelectedGridCell.lblLot.layer.borderWidth = 1;
                    CurrentSelectedGridCell.lblLot.layer.borderColor = [UIColor clearColor].CGColor;
                    CurrentSelectedGridCell.lblLot.clipsToBounds = YES;
                    
                    //           [ClsSetting SetBorder:CurrentSelectedGridCell.lblLot cornerRadius:8 borderWidth:1];
                    //           CurrentSelectedGridCell.lblLot.layer.cornerRadius = 8;
                    CurrentSelectedGridCell.btnLot.hidden = YES;
                    
                    //           [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                    [ClsSetting ISUSerLeading:objCurrentOccution.strmyuserid Cell:CurrentSelectedGridCell];
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
                    
                    CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                    CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                    CurrentSelectedGridCell.btnbidNow.tag=indexPath.row;
                    CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                    CurrentSelectedGridCell.btnBidHistory.tag=indexPath.row;
                    CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
//                    CurrentSelectedGridCell.hidden=NO;
                    if ([objCurrentOccution.isAnimate integerValue] == 1)
                    {
                        objCurrentOccution.isAnimate = @"0";
                        CurrentSelectedGridCell.contentView.hidden = YES;
                        [UIView transitionWithView:CurrentSelectedGridCell.contentView
                                          duration:1
                                           options:UIViewAnimationOptionTransitionFlipFromLeft
                                        animations:^{
                                            CurrentSelectedGridCell.contentView.hidden = NO;
                                            CurrentSelectedGridCell.imgProduct.hidden = NO;

                                        } completion:^(BOOL finished){
                                            //                                            if(finished)  NSLog(@"Finished !!!!!");
                                            // do any stuff here if you want
                                        }];
                    }
                    else
                    {
                        CurrentSelectedGridCell.contentView.hidden = NO;
                    }
                    cell = CurrentSelectedGridCell;
                    
                }
                else
                {
                    
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                    CurrentDefultGridCell.contentView.hidden = YES;
                    CurrentDefultGridCell.imgProduct.hidden = YES;
                    CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                    
                    [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    //           CurrentDefultGridCell.nextView.layer.borderColor = [UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1].CGColor;
                    
                    if ([objCurrentOccution.strpricers intValue] > 10000000) // 10000000
                    {
                        if (isUSD==YES)
                        {
                            numberFormatter.currencyCode = @"USD";
                            NSString *strCurrentBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[objCurrentOccution.strpriceus intValue]]];
                            
                            
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
                            NSString *strCurrentBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[objCurrentOccution.strpricers intValue]]];
                            
                            
                            
                            CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                            
                            int price =[objCurrentOccution.strpricers intValue];
                            int priceIncreaserete=(price*5)/100;
                            int FinalPrice=price+priceIncreaserete;
                            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                            
                            CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        }
                        
                    }
                    else{
                        if (isUSD==YES)
                        {
                            numberFormatter.currencyCode = @"USD";
                            NSString *strCurrentBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[objCurrentOccution.strpriceus intValue]]];
                            
                            
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
                            NSString *strCurrentBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[objCurrentOccution.strpricers intValue]]];
                            
                            
                            
                            CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                            
                            int price =[objCurrentOccution.strpricers intValue];
                            int priceIncreaserete=(price*10)/100;
                            int FinalPrice=price+priceIncreaserete;
                            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                            
                            CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        }
                    }
                    if (IsSort==1)
                    {
                        CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                        CurrentDefultGridCell.lblMedium.text= objCurrentOccution.strmedium;
                        CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.strmedium;
                    }
                    else
                    {
                        CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
                        CurrentDefultGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
                        CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
                    }
                    
                    
                    CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    
                    CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    
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
                    NSLog(@"User id = %@ /n Mysiteuserid = %@", [[NSUserDefaults standardUserDefaults] valueForKey:USER_id], objCurrentOccution.strmyuserid);
                    
                    CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    CurrentDefultGridCell.lblLot.layer.cornerRadius = 8;
                    CurrentDefultGridCell.lblLot.layer.borderWidth = 1;
                    CurrentDefultGridCell.lblLot.layer.borderColor = [UIColor clearColor].CGColor;
                    CurrentDefultGridCell.lblLot.clipsToBounds = YES;
                    
                    //           [ClsSetting SetBorder:CurrentDefultGridCell.lblLot cornerRadius:8 borderWidth:1];
                    CurrentDefultGridCell.btnLot.hidden = YES;
                    
                    //       [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                    
                    [ClsSetting ISUSerLeading:objCurrentOccution.strmyuserid Cell:CurrentDefultGridCell];
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                        }
                        else
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                        }
                    }
                    CurrentDefultGridCell.CurrentOccutiondelegate=self;
                    if ([objCurrentOccution.isAnimate integerValue] == 1)
                    {
                        objCurrentOccution.isAnimate = @"0";
                        CurrentDefultGridCell.contentView.hidden = YES;
                        [UIView transitionWithView:CurrentDefultGridCell.contentView
                                          duration:1
                                           options:UIViewAnimationOptionTransitionFlipFromLeft
                                        animations:^{
                                            CurrentDefultGridCell.contentView.hidden = NO;
                                            CurrentDefultGridCell.imgProduct.hidden = NO;
                                        } completion:^(BOOL finished){
                                            //                                            if(finished)
                                            //                                                NSLog(@"Finished !!!!!");
                                            // do any stuff here if you want
                                        }];
                        
                    }
                    else
                    {
                        CurrentDefultGridCell.contentView.hidden = NO;
                        CurrentDefultGridCell.imgProduct.hidden = NO;

                    }
                    cell = CurrentDefultGridCell;
                }
            }
            else
            {
                if ([objCurrentOccution.strTypeOfCell intValue]==1)
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelectedList" forIndexPath:indexPath];
                    
                    CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                    
                    [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:indexPath.row];
                    if (IsSort==1)
                    {
                        CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                        CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                        CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                    }
                    else
                    {
                        CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
                        CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
                        CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
                    }
                    
                    CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    CurrentSelectedGridCell.lblSize.text= [NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                    CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                    
                    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                    if ([timeStr isEqualToString:@""])
                        CurrentSelectedGridCell.lblCoundown.text=@"Auction Closed";
                    else
                        CurrentSelectedGridCell.lblCoundown.text=timeStr;
                    
                    
                    CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                    CurrentSelectedGridCell.layer.borderWidth=1;
                    CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                    NSLog(@"User id = %@ /n Mysiteuserid = %@", [[NSUserDefaults standardUserDefaults] valueForKey:USER_id], objCurrentOccution.strmyuserid);
                    
                    CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    CurrentSelectedGridCell.lblLot.layer.cornerRadius = 8;
                    CurrentSelectedGridCell.lblLot.layer.borderWidth = 1;
                    CurrentSelectedGridCell.lblLot.layer.borderColor = [UIColor clearColor].CGColor;
                    CurrentSelectedGridCell.lblLot.clipsToBounds = YES;
                    CurrentSelectedGridCell.btnLot.hidden = YES;
                    
                    [ClsSetting ISUSerLeading:objCurrentOccution.strmyuserid Cell:CurrentSelectedGridCell];
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                        }
                        else
                        {
                            CurrentSelectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                        }
                        
                    }
                    
                    CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                    CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                    CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    if (isUSD==NO)
                    {
                        numberFormatter.currencyCode = @"INR";
                        NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                        NSArray *subStrings = [objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                    cell = CurrentSelectedGridCell;
                    
                }
                else
                {
                    
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefultList" forIndexPath:indexPath];
                    
                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    if ([objCurrentOccution.strpricers intValue] > 10000000) // 10000000
                    {
                        if (isUSD==YES)
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
                        if (isUSD==YES)
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
                    
                    CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                    [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                    if (IsSort==1)
                    {
                        CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                        CurrentDefultGridCell.lblMedium.text= objCurrentOccution.strmedium;
                        CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                    }
                    else
                    {
                        CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
                        CurrentDefultGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
                        CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
                    }
                    
                    CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    
                    CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    
                    CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                    
                    
                    NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                    if ([timeStr isEqualToString:@""])
                        CurrentDefultGridCell.lblCoundown.text=@"Auction Closed";
                    else
                        CurrentDefultGridCell.lblCoundown.text=timeStr;
                    
                    
                    CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                    CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                    CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                    
                    if (objCurrentOccution.IsSwapOn==1)
                    {
                        CurrentDefultGridCell.viwSwap.frame=CGRectMake((CurrentDefultGridCell.viwSwap.frame.size.width/3)-CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
                    else
                    {
                        CurrentDefultGridCell.viwSwap.frame=CGRectMake(0, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
                    cell.layer.borderWidth=1;
                    CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                    CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    CurrentDefultGridCell.lblLot.layer.cornerRadius = 8;
                    CurrentDefultGridCell.lblLot.layer.borderWidth = 1;
                    CurrentDefultGridCell.lblLot.layer.borderColor = [UIColor clearColor].CGColor;
                    CurrentDefultGridCell.lblLot.clipsToBounds = YES;
                    
                    CurrentDefultGridCell.btnLot.hidden = YES;
                    
                    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
                    {
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor =[UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1] ;
                        }
                        else
                        {
                            CurrentDefultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                        }
                    }
                    [ClsSetting ISUSerLeading:objCurrentOccution.strmyuserid Cell:CurrentDefultGridCell];
                    CurrentDefultGridCell.CurrentOccutiondelegate=self;
                    cell = CurrentDefultGridCell;
                }
            }
            
            cell.layer.borderWidth=1;
            cell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        }
        if (IsSort==0)
        {
            if(indexPath.row==arrOccution.count-1)
            {
                if (isReloadDate==YES)
                {
                    iOffset=iOffset+10;
                    [self getOccttionData];
                }
            }
        }
    }
    else
    {
        static NSString *identifier = @"Cell11";
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:30];
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        NSLog(@"%@",[arrBottomMenu objectAtIndex:indexPath.row]);
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        if (indexPath.row==1)
        {
            UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden=NO;
            
        }
        else
        {
            //            UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
            lblSelectedline.hidden=YES;
        }
        cell=cell1;
    }
    return cell;
    
    
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

-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:1];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [self.clvCurrentOccution reloadItemsAtIndexPaths: arrindexpath];
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
- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    
    
    //UICollectionViewCell *cell = [_clvCurrentOccution ]
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:1];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)[_clvCurrentOccution cellForItemAtIndexPath:indexPath];
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
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView==_clvBottomMenu)
    {
    if (indexPath.row==0)
    {

        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        ViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
       // [navcontroll pushViewController:objViewController animated:YES];
        
        [navcontroll setViewControllers: @[objViewController] animated: YES];
        
        [self.revealViewController setFrontViewController:navcontroll];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
   else if (indexPath.row==1)
     {
            
         if (_isSearch==YES)
         {
             _isSearch=NO;
             [self getCurrentAuction];
         }
     }
    
    else if (indexPath.row==2)
    {
    
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
         objPastOccuctionViewController.iIsUpcomming=1;
        [navcontroll setViewControllers: @[objPastOccuctionViewController] animated: YES];
        
        [self.revealViewController setFrontViewController:navcontroll];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        
    }
    else if (indexPath.row==3)
    {
        
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
        objPastOccuctionViewController.iIsUpcomming=2;
        //[navcontroll pushViewController:objPastOccuctionViewController animated:YES];
        [navcontroll setViewControllers: @[objPastOccuctionViewController] animated: YES];
        
        [self.revealViewController setFrontViewController:navcontroll];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    }
  }  
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    ArtistViewController *objArtistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
    if (isUSD)
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

- (IBAction)btnListPressed:(id)sender
{
    isList=TRUE;
    [_clvCurrentOccution reloadData];
}
- (IBAction)btnGriPressed:(id)sender
{
    isList=FALSE;
    [_clvCurrentOccution reloadData];
   
}
- (IBAction)addToMyAuctionGallery:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    [self insertItemToAuctionGallery:objCurrentOccution];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
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

- (IBAction)btnBidNowPressed:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
                objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=TRUE;
                if (isUSD)
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
                objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=FALSE;
                if (isUSD)
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
            rootViewController.IsCommingFromLoging = 1;
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
- (IBAction)detailpageClicked:(UIButton*)sender
{
    int indexpath=((int)sender.tag);
    [self showDetailPage:indexpath];
}

-(void)showDetailPage:(int)indexpath
{
    clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexpath];
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.IsSort=IsSort;
    objProductViewController.objCurrentOccution=objCurrentOccution;
    if (isUSD)
    {
        objProductViewController.iscurrencyInDollar=1;
    }
    else
    {
        objProductViewController.iscurrencyInDollar=0;
    }
    [navcontroll pushViewController:objProductViewController animated:YES];

}
- (IBAction)ChangeCurrencyPressed:(id)sender
{
    if (isUSD==NO)
    {
        isUSD=YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
        [_clvCurrentOccution reloadData];
    }
    else
    {
        isUSD=NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
        [_clvCurrentOccution reloadData];
    }
}
-(void)ListSwipeOptionpressed:(int)option currentCellIndex:(int)index
{
    if (option==1)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
        [self btnBidHistoryPressed:btn];
    }
    else if (option==2)
    {
        [self showDetailPage:index ];
    }
    else if (option==3)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
//        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
//        {
//            if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
//            {
//            }
//            else
//            {
//            }
//        }

        [self btnProxyBid:btn];
    }
    else if (option==4)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
        [self btnBidNowPressed:btn];
    }
    
}
- (IBAction)btnBidHistoryPressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    
    BidHistoryViewController *objBidHistoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
    objBidHistoryViewController.objCurrentOuction=objCurrentOccution;
    objBidHistoryViewController.IsSort=IsSort;
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}

- (IBAction)btnFilterPressed:(id)sender
{
    [self InvalidateTimer];
    FilterViewController *objFilterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    objFilterViewController.arrFilter=arrOccution;
    objFilterViewController.arrselectArtist=arrSelectedArtistarray;
    objFilterViewController.DelegateFilter=self;
    objFilterViewController.selectedTab=1;
    [self.navigationController pushViewController:objFilterViewController animated:YES];
}

-(void)CurrentAuctionSortData:(NSMutableArray*)arrSordData intdex:(int)index iSelectedntdex:(int)iSelectedntdex
{
    //int isrefresh=1;
    if (index==1)
    {
        for (int i=0; i<arrOccution.count; i++)
        {
            clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
            for (int j=0; j<arrSordData.count; j++)
            {
                clsCurrentOccution *objsortacution=[arrSordData objectAtIndex:j];
                if ([objacution.strproductid intValue]==[objsortacution.strproductid intValue])
                {
                    objsortacution.IsSwapOn=objacution.IsSwapOn;
                    objsortacution.strTypeOfCell=objacution.strTypeOfCell;
                    break;
                }
            }
        }
        [arrOccution removeAllObjects];
        arrOccution=arrSordData;
        [_clvCurrentOccution reloadData];
    }
    else
    {
    
    IsSort=1;
        
//        [countDownTimer invalidate];
    [timer invalidate];
        
    [arrOccution removeAllObjects];
    arrOccution=arrSordData;
        if (objAppDelegate.isfilterStart==1)
        {
            [self InvalidateTimer];
            objAppDelegate.isfilterStart=0;
            objAppDelegate.isRefreshstart=0;

//         objAppDelegate.isfilterStart=0;
        }
        [_clvCurrentOccution reloadData];
    }
    
    //NSLog(@"%@",arrSordData);
}

-(void)reloadCall
{
    [_clvCurrentOccution reloadData];
}

-(void)filter:(NSMutableArray *)arrFilterArray SelectedArtistArray:(NSMutableArray *)arrSelectedArtist
{
    //[arrOccution removeAllObjects];
    //arrOccution=arrFilterArray;
    ///arrSelectedArtistarray=[[NSMutableArray alloc]init];
    
    arrSelectedArtistarray=arrSelectedArtist;
    //[_clvCurrentOccution reloadData];
    if (objAppDelegate.isfilterStart!=1)
    {
        [self fiterArtistCall];
       timer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(fiterArtistCall) userInfo:nil repeats:YES];
        
//        countDownTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(reloadCall) userInfo:nil repeats:YES];

    }
//     objAppDelegate.isfilterStart=1;
    objAppDelegate.isfilterStart=1;
    objAppDelegate.isRefreshstart=1;
}

-(void)fiterArtistCall
{
    @try {
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        NSMutableArray *arrSelectedArtist=arrSelectedArtistarray;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString *strFunctionName;
        if (objAppDelegate.iSelectedSortInCurrentAuction==0)
        {
            strFunctionName=@"defaultlots";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==1)
        {
            strFunctionName=@"lotslatest";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==2)
        {
            strFunctionName=@"lotssignificant";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==3)
        {
            strFunctionName=@"lotspopular";
        }
        else if (objAppDelegate.iSelectedSortInCurrentAuction==4)
        {
            strFunctionName=@"lotsclosingtime";
        }
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=",[objsetting Url],strFunctionName];
        NSString *str=[[NSString alloc] init];
        for (int i=0; i<arrSelectedArtist.count; i++)
        {
            clsArtistInfo *objArtistInfo=[arrSelectedArtist objectAtIndex:i];
            str= [str stringByAppendingString:[NSString stringWithFormat:@"(artistid=%@)",objArtistInfo.strArtistid]];
            if (arrSelectedArtist.count-1 !=i)
            {
                str= [str stringByAppendingString:@"OR"];
            }
        }
        NSLog(@"url:%@",strQuery);
       NSString *strQuery1=[NSString stringWithFormat:@"%@%@",strQuery,str];
        NSLog(@"url:%@",strQuery1);
        
        NSString *url = strQuery1;
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSError *error;
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict);
             
             NSMutableArray *arrFilterResult=[[NSMutableArray alloc]init];
             arrFilterResult=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];
             for (int i=0; i<arrOccution.count; i++)
             {
                 clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                 for (int j=0; j<arrFilterResult.count; j++)
                 {
                     clsCurrentOccution *objFilterResult=[arrFilterResult objectAtIndex:j];
                     if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                     {
                         objFilterResult.IsSwapOn=objacution.IsSwapOn;
                         objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                         
                         break;
                     }
                 }
             }
             [arrOccution removeAllObjects];
             arrOccution=arrFilterResult;
             [_clvCurrentOccution reloadData];
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
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
-(void)viewWillDisappear:(BOOL)animated
{
    [countDownTimer invalidate];
    [self InvalidateTimer];
    if (objAppDelegate.isfilterStart==0)
    {
        objAppDelegate.isRefreshstart=0;
        [timer invalidate];
    }
    else
    {
        objAppDelegate.isRefreshstart=1;
    }
}
-(void)InvalidateTimer
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    TopStaticCollectionViewCell * cell = (TopStaticCollectionViewCell*)[_clvCurrentOccution cellForItemAtIndexPath:indexPath];
    [cell.timer invalidate];
}
@end
