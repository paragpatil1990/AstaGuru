//
//  ItemOfPastAuctionViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 17/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ItemOfPastAuctionViewController.h"
#import "ClsSetting.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "DetailProductViewController.h"
#import "TOPCollectionViewCell.h"
#import "FilterViewController.h"
#import "BidHistoryViewController.h"
#import "AuctionItemBidViewController.h"
#import "BforeLoginViewController.h"
#import "ArtistViewController.h"
#import "WebViewViewController.h"
#import "SWRevealViewController.h"
#import "MyAuctionGalleryViewController.h"
#import "VerificationViewController.h"
 BOOL isList;
@interface ItemOfPastAuctionViewController ()<PassResepose,CurrentOccution,Filter>
{
    NSMutableArray *arrPactAuctionItem;
    int iOffset;
    BOOL isReloadDate;
    NSMutableArray *arrSelectedArtistarray;
}
@end

@implementation ItemOfPastAuctionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     arrPactAuctionItem=[[NSMutableArray alloc]init];
    if (_isSearch==YES)
    {
        arrPactAuctionItem=_arrSearch;
        
    }
    else if (_isWorkArt == YES)
    {
        [self GetWrokArt];
    }
    else
    {
        [self GetArtistOccuctionInfo:1];
    }
    
    //auctionbaner
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpNavigationItem];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.backItem.title = @"Back";
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}
-(void)setUpNavigationItem
{
    if (_IsUpcomming==1)
    {
        _IsPast = 0;
    }
    else
    {
        _IsPast = 1;
    }
    if(_isSearch==1)
    {
        if (_IsUpcomming==1)
        {
            _IsPast = 0;
          self.title=[NSString stringWithFormat:@"Upcoming Auctions"];
        }
        else
        {
            _IsPast = 1;
            self.title=[NSString stringWithFormat:@"Past Auctions"];
        }
    }
    else if (_isWorkArt == YES)
    {
        self.title=[NSString stringWithFormat:@"Art Work"];
    }
    else
    {
        self.title=[NSString stringWithFormat:@"%@",_objPast.strAuctiontitle];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
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
    if (_isSearch==1)
    {
     [self.navigationItem setRightBarButtonItems:@[spaceFix, barButtonItem1]];
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

-(void)GetWrokArt
{
    
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];

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
//        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@recordPriceArtworks?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objSetting Url]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             //NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableArray *arr1=[dict valueForKey:@"resource"];
             NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:arr1];
             arrPactAuctionItem=arrItemCount;
             //[arrPactAuctionItem addObjectsFromArray:arrItemCount];
             [_ClvItemOfPastAuction reloadData];
             
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

-(void)GetArtistOccuctionInfo:(int)isCurrentOccution
{
    
//        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
    
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
//        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spPastAuction(%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objSetting UrlProcedure],_objPast.strAuctionId];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             //NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             //NSMutableArray *arr1=[dict valueForKey:@""];
             NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:dict];
             arrPactAuctionItem=arrItemCount;
             
             for (int i=0; i<arrPactAuctionItem.count; i++)
             {
                 clsCurrentOccution *objacution=[arrPactAuctionItem objectAtIndex:i];
                 for (int j=0; j<arrItemCount.count; j++)
                 {
                     clsCurrentOccution *objFilterResult=[arrItemCount objectAtIndex:j];
                     if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                     {
                         objFilterResult.IsSwapOn=objacution.IsSwapOn;
                         objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                         
                         break;
                     }
                 }
             }

//             [arrPactAuctionItem removeAllObjects];
//             arrPactAuctionItem=arrItemCount;
////             [_clvCurrentOccution reloadData];

             
             //[arrPactAuctionItem addObjectsFromArray:arrItemCount];
             [_ClvItemOfPastAuction reloadData];
             
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

-(void)passReseposeData:(id)arr
{
    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
   
        NSError *error;
        NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
   NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:arr1];
    if (arrItemCount.count==10)
    {
        isReloadDate=YES;
    }
    else
    {
        isReloadDate=NO;
    }
    [arrPactAuctionItem addObjectsFromArray:arrItemCount];
    [_ClvItemOfPastAuction reloadData];
    
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
        return   CGSizeMake(collectionView1.frame.size.width,145);
    }
    else
    {
        if (isList==TRUE)
        {
            return   CGSizeMake((collectionView1.frame.size.width)-10,134);
        }
        
        return   CGSizeMake((collectionView1.frame.size.width/2)-7,266);
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
        return  arrPactAuctionItem.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
    TOPCollectionViewCell *TopStaticCell;
    UICollectionViewCell *cell1;
    if (indexPath.section==0)
    {
        
        TopStaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
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
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
        {
            TopStaticCell.lblCurrency.text=@"USD";
        }
        else
        {
            TopStaticCell.lblCurrency.text=@"INR";
        }
        
        if (_IsUpcomming==1)
        {
            TopStaticCell.btnAuctionAnalist.hidden=YES;
        }
        else if (_isWorkArt == YES)
        {
            TopStaticCell.btnAuctionAnalist.hidden=YES;
            TopStaticCell.btnFilter.hidden = YES;
            TopStaticCell.lblFilter.hidden = YES;
            TopStaticCell.iconDropdown.hidden = YES;
        }
        else
        {
            TopStaticCell.btnAuctionAnalist.hidden=false;
            [TopStaticCell.btnAuctionAnalist addTarget:self action:@selector(btnAuctionAnalistPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (arrPactAuctionItem.count>0)
        {
            clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:0];
            //        NSString *auctionBanner = objCurrentOccution.strauctionBanner;
            EGOImageView *imgServices = (EGOImageView *)[TopStaticCell viewWithTag:22];
            NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strauctionBanner]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            imgServices.imageURL=[NSURL URLWithString:spaceUrl];
        }
        
        
        cell1 = TopStaticCell;
    }
    
    else
    {
        clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:indexPath.row];
        if (isList==FALSE)
        {
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                CurrentSelectedGridCell.lblMedium.text=objCurrentOccution.strmedium;
                CurrentSelectedGridCell.lblCategoryName.text= objCurrentOccution.strcategory;
                CurrentSelectedGridCell.lblYear.text=objCurrentOccution.strproductdate;
                CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize] ;
                
                CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                CurrentSelectedGridCell.layer.borderWidth=1;
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.btnDetail.tag=indexPath.row;
                CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                CurrentSelectedGridCell.btnBidHistory.tag=indexPath.row;
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                    
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpriceus intValue];
                    int priceIncreaserete=(price*15)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                    
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpricers intValue];
                    int priceIncreaserete=(price*15)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                    NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                    NSArray *subStrings = [objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - " //or rather @" - "
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
                }
                if (_IsUpcomming==1)
                {
                    CurrentSelectedGridCell.isCommingFromUpcoming = 1;
                    CurrentSelectedGridCell.isCommingFromPast = 0;
                    CurrentSelectedGridCell.btnproxy.hidden=NO;
                    CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                }
                else
                {
                    CurrentSelectedGridCell.isCommingFromUpcoming = 0;
                    CurrentSelectedGridCell.isCommingFromPast = 1;
                    CurrentSelectedGridCell.btnproxy.hidden=YES;
                }
                cell1 = CurrentSelectedGridCell;
            }
            else
            {
                
                CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:spaceUrl];
                CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                
                
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                
                CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpriceus intValue];
                    int priceIncreaserete=(price*15)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    if (_IsUpcomming==1)
                    {
                        CurrentDefultGridCell.pastStatictext.hidden=YES;
                        NSString *strBASICBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price]];
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strBASICBuild];
                    }
                    
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpricers intValue];
                    int priceIncreaserete=(price*15)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                    if (_IsUpcomming==1)
                    {
                        CurrentDefultGridCell.pastStatictext.hidden=YES;
                        NSString *strBASICBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price]];
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strBASICBuild];
                    }
                    
                }
                
                if (_IsUpcomming == 1)
                {
                    CurrentDefultGridCell.isCommingFromUpcoming = 1;
                    CurrentDefultGridCell.isCommingFromPast = 0;
                    CurrentDefultGridCell.btnMyGallery.tag=indexPath.row;
                }
                else{
                    CurrentDefultGridCell.isCommingFromUpcoming = 0;
                    CurrentDefultGridCell.isCommingFromPast = 1;
                    CurrentDefultGridCell.btnMyGallery.hidden=YES;
                    CurrentDefultGridCell.btnMyGallery_width.constant = 0;
                }
                CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                cell1 = CurrentDefultGridCell;
            }
            
        }
        else
        {
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelectedList" forIndexPath:indexPath];
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"]==YES)
                {
                    numberFormatter.currencyCode = @"USD";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int price =[objCurrentOccution.strpriceus intValue];
                    int priceIncreaserete=(price*15)/100;
                    
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
                    int priceIncreaserete=(price*15)/100;
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                }
                CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
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
                [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                if (_IsUpcomming == 1)
                {
                    CurrentSelectedGridCell.isCommingFromUpcoming = 1;
                    CurrentSelectedGridCell.isCommingFromPast = 0;
                }
                else{
                    CurrentSelectedGridCell.isCommingFromUpcoming = 0;
                    CurrentSelectedGridCell.isCommingFromPast = 1;
                }
                [CurrentSelectedGridCell setuparray];
                cell1 = CurrentSelectedGridCell;
                
            }
            else
            {
                
                CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefultList" forIndexPath:indexPath];
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"]==YES)
                {
                    numberFormatter.currencyCode = @"USD";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int price =[objCurrentOccution.strpriceus intValue];
                    int priceIncreaserete=(price*15)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    if (_IsUpcomming==1)
                    {
                        CurrentDefultGridCell.pastStatictext.hidden=YES;
                        NSString *strBASICBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price]];
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strBASICBuild];
                    }
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                    
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int price =[objCurrentOccution.strpricers intValue];
                    int priceIncreaserete=(price*15)/100;
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    if (_IsUpcomming==1)
                    {
                        CurrentDefultGridCell.pastStatictext.hidden=YES;
                        NSString *strBASICBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price]];
                        CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strBASICBuild];
                    }
                    
                }
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:spaceUrl];
                
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                
                CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                CurrentDefultGridCell.lblMedium.text= objCurrentOccution.strmedium;
                CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                
                
                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                
                
                CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
                
                CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                
                if (objCurrentOccution.IsSwapOn==1)
                {
                    CurrentDefultGridCell.viwSwap.frame=CGRectMake((CurrentDefultGridCell.viwSwap.frame.size.width/4)-CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                }
                else
                {
                    CurrentDefultGridCell.viwSwap.frame=CGRectMake(0, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                }
                
                NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                if ([timeStr isEqualToString:@""])
                    CurrentDefultGridCell.lblCoundown.text=@"Auction Closed";
                else
                    CurrentDefultGridCell.lblCoundown.text=timeStr;
                cell1.layer.borderWidth=1;
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                if (_IsUpcomming == 1)
                {
                    CurrentDefultGridCell.isCommingFromUpcoming = 1;
                    CurrentDefultGridCell.isCommingFromPast = 0;
                }
                else
                {
                    CurrentDefultGridCell.isCommingFromUpcoming = 0;
                    CurrentDefultGridCell.isCommingFromPast = 1;
                }
                [CurrentDefultGridCell setuparray];
                cell1 = CurrentDefultGridCell;
            }
        }
        cell1.layer.borderWidth=1;
        cell1.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    }
    return cell1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section==0 ||section==1)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 15);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (section==0 ||section==1)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 20);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)ListSwipeOptionpressed:(int)option currentCellIndex:(int)index
{
    if (option==1)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
//        [self btnBidHistoryPressed:btn];
    }
    else if (option==2)
    {
        [self showDetailPage:index ];
    }
    else if (option==3)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
        [self btnProxyBid:btn];
    }
    else if (option==4)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
//        [self btnBidNowPressed:btn];
    }
    
}

-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:1];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [_ClvItemOfPastAuction reloadItemsAtIndexPaths: arrindexpath];
    
    //[_clvCurrentOccution reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:x section:0]];
    
}
- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
    
    
    //UICollectionViewCell *cell = [_clvCurrentOccution ]
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:1];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)[_ClvItemOfPastAuction cellForItemAtIndexPath:indexPath];
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
}

-(void)addTapGestureOnProductimage:(UIImageView*)imgProduct indexpathrow:(NSInteger)indexpathrow
{
    imgProduct.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    //[tapGesture1 setDelegate:self];
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
    clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:indexpath];
    
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.objCurrentOccution=objCurrentOccution;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
      objProductViewController.iscurrencyInDollar=1;
    }
    objProductViewController.IsSort=1;
    objProductViewController.IsUpcomming = _IsUpcomming;
    objProductViewController.IsPast = _IsPast;
    objProductViewController.Auction_id = _objPast.strAuctionId;
    [self.navigationController pushViewController:objProductViewController animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnCurrencyChanged:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
        [_ClvItemOfPastAuction reloadData];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
        [_ClvItemOfPastAuction reloadData];
    }
}

- (IBAction)btnFilter:(id)sender
{
    FilterViewController *objFilterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    objFilterViewController.arrFilter=arrPactAuctionItem;
    objFilterViewController.ispast=1;
    objFilterViewController.arrselectArtist=arrSelectedArtistarray;
    if (_IsUpcomming==1)
    {
        objFilterViewController.strType=@"upcoming";
        objFilterViewController.selectedTab=2;

    }
    else
    {
        objFilterViewController.strType=@"Past";
        objFilterViewController.selectedTab=3;

    }
    objFilterViewController.Auctionid=[_objPast.strAuctionId intValue];
    objFilterViewController.DelegateFilter=self;
    [self.navigationController pushViewController:objFilterViewController animated:YES];
    
    
}
-(void)filter:(NSMutableArray *)arrFilterArray SelectedArtistArray:(NSMutableArray *)arrSelectedArtist
{
//    NSString *arrArtistId=[[NSString alloc ]init];
    NSString *str=[[NSString alloc] init];
//    (artistid=%@)or(artistid=%@)
    for (int i=0; i<arrSelectedArtist.count; i++)
    {
        clsArtistInfo *objartistinfo=[arrSelectedArtist objectAtIndex:i];
        str= [str stringByAppendingString:[NSString stringWithFormat:@"(artistid=%@)",objartistinfo.strArtistid]];
        if (arrSelectedArtist.count-1 != i)
        {
            str= [str stringByAppendingString:@"or"];
        }
    }
    NSLog(@"str:%@",str);
    [self filter:str];
    [arrPactAuctionItem removeAllObjects];
    arrSelectedArtistarray=arrSelectedArtist;
    
}
- (IBAction)btnBidHistory:(UIButton*)sender
{
    /*clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
    BidHistoryViewController *objBidHistoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BidHistoryViewController"];
    objBidHistoryViewController.objCurrentOuction=objCurrentOccution;
    
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];*/
}
- (IBAction)btnDetailPressed:(UIButton*)sender
{
    int indexpath=((int)sender.tag);
    [self showDetailPage:indexpath];
}


- (IBAction)btnListPressed:(id)sender
{
    isList=TRUE;
    [_ClvItemOfPastAuction reloadData];
}
- (IBAction)btnGriPressed:(id)sender
{
    isList=FALSE;
    [_ClvItemOfPastAuction reloadData];
    
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
                objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=FALSE;
                objAuctionItemBidViewController.IsUpcoming = _IsUpcomming;
                objAuctionItemBidViewController.IsPast = _IsPast;
                objAuctionItemBidViewController.Auction_id = _objPast.strAuctionId;
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
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

- (IBAction)btnAuctionAnalistPressed:(UIButton*)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:[NSString stringWithFormat:@"http://astaguru.com:81/auction-analysis-mobile.aspx?astaguruauction=%@",_objPast.strAuctionId]];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}

- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
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
//    objArtistViewController.IsUpcomming = _IsUpcomming;
//    objArtistViewController.IsPast = _IsPast;
    [self.navigationController pushViewController:objArtistViewController animated:YES];
}

- (IBAction)addToMyAuctionGallery:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
        objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
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


-(void)filter:(NSString*)strid
{
    
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];

    
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
        NSString  *strQuery=[NSString stringWithFormat:@"%@getPastAuction?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=(Online=%@)and(%@)",[objSetting Url],_objPast.strAuctionId,strid];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             //NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableArray *arr1=[dict valueForKey:@"resource"];
             [arrPactAuctionItem removeAllObjects];
             if (dict.count>0)
             {
                 NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:arr1];
                 arrPactAuctionItem=arrItemCount; 
             }
                        //[arrPactAuctionItem addObjectsFromArray:arrItemCount];
             [_ClvItemOfPastAuction reloadData];
             
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


@end
