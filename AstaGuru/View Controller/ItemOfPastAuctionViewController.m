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
#import "AuctionAnalyisisViewController.h"

 BOOL isList;

@interface ItemOfPastAuctionViewController ()<PassResepose,CurrentOccution,FilterDelegate>
{
    NSMutableArray *arrPactAuctionItem;
    int iOffset;
    BOOL isReloadDate;
    NSMutableArray *arrSelectedArtistarray;
    NSArray *arrSearchResult;

    clsCurrentOccution *objCurrentOccutionForAuctionName;
    BOOL isFilter;

}
@end

@implementation ItemOfPastAuctionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _noRecords_Lbl.hidden = YES;
    
    isFilter = NO;
    
    arrSearchResult = [[NSArray alloc]init];
    arrPactAuctionItem=[[NSMutableArray alloc]init];
    
    if (_isSearch == YES)
    {
        arrSearchResult = _arrSearch;
        arrPactAuctionItem = [_arrSearch mutableCopy];
    }
    else if (_isWorkArt == YES)
    {
        [self getRecordPriceArtworks];
    }
    else if (_isMyPurchase == YES)
    {
        [self getMyPurchase];
    }
    else
    {
        [self getAccuctions];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.ClvItemOfPastAuction reloadData];
    [self setUpNavigationItem];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
   // self.navigationController.navigationBar.topItem.title = @"Back";
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
    if (_IsUpcomming == 1)
    {
        _IsPast = 0;
    }
    else
    {
        _IsPast = 1;
    }
    
    if(_isSearch == 1)
    {
        if (_IsUpcomming == 1)
        {
            _IsPast = 0;
            self.navigationItem.title =@"Upcoming Auctions";
            self.title=[NSString stringWithFormat:@"Upcoming Auctions"];
        }
        else
        {
            _IsPast = 1;
            self.navigationItem.title =@"Past Auctions";
            self.title=[NSString stringWithFormat:@"Past Auctions"];
        }
    }
    else if (_isWorkArt == YES)
    {
        self.navigationItem.title =@"Record Price Artworks";
        self.title=[NSString stringWithFormat:@"Record Price Artworks"];
    }
    else if (_isMyPurchase == YES)
    {
        self.navigationItem.title =@"My Purchase";
        self.title=[NSString stringWithFormat:@"My Purchase"];
    }
    else
    {
        self.navigationItem.title = [NSString stringWithFormat:@"%@",_objPast.strAuctiontitle];
        self.title = [NSString stringWithFormat:@"%@",_objPast.strAuctiontitle];
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

-(void)getRecordPriceArtworks
{
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@recordPriceArtworks?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableArray *arr1=[dict valueForKey:@"resource"];
             NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:arr1];
             arrPactAuctionItem=arrItemCount;
             if (arrPactAuctionItem.count == 0)
             {
                 _ClvItemOfPastAuction.hidden = YES;
                 _noRecords_Lbl.hidden = NO;
                 _noRecords_Lbl.text = @"There is no any record price artworks auction still yet.";
             }
             else
             {
                 _ClvItemOfPastAuction.hidden = NO;
                 _noRecords_Lbl.hidden = YES;
                 _noRecords_Lbl.text = @"";
             }
             [_ClvItemOfPastAuction reloadData];
             
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

-(void)getMyPurchase
{    
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spMyPurchase(%@)?api_key=%@",[ClsSetting procedureURL],[[NSUserDefaults standardUserDefaults] valueForKey:USER_id],[ClsSetting apiKey]];
        
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:dict];
             arrPactAuctionItem=arrItemCount;
             if (arrPactAuctionItem.count == 0)
             {
                 _ClvItemOfPastAuction.hidden = YES;
                 _noRecords_Lbl.hidden = NO;
                 _noRecords_Lbl.text = @"There is no lot in your Purchase.";
             }
             else
             {
                 _ClvItemOfPastAuction.hidden = NO;
                 _noRecords_Lbl.hidden = YES;
                 _noRecords_Lbl.text = @"";
             }

             [_ClvItemOfPastAuction reloadData];
             
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

-(void)getAccuctions
{    
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
      
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spPastAuction(%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],_objPast.strAuctionId,@"P",@" ",[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:dict];
             [arrPactAuctionItem removeAllObjects];
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
             
             if (arrPactAuctionItem.count == 0)
             {
                 _ClvItemOfPastAuction.hidden = YES;
                 _noRecords_Lbl.hidden = NO;
                 if (_IsUpcomming == 1)
                 {
                     _noRecords_Lbl.text = @"There is no any upcoming auction still yet.";
                 }
                 else
                 {
                     _noRecords_Lbl.text = @"There is no any past auction still yet.";
                 }
             }
             else
             {
                 _ClvItemOfPastAuction.hidden = NO;
                 _noRecords_Lbl.hidden = YES;
                 _noRecords_Lbl.text = @"";
             }

             [_ClvItemOfPastAuction reloadData];
             
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

-(void)passReseposeData:(id)arr
{
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
    return 4;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2)
    {
        return UIEdgeInsetsMake(0, 8, 0, 8);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (_isMyPurchase == YES)
        {
            return   CGSizeMake(collectionView1.frame.size.width,50);
        }
        else
        {
            return   CGSizeMake(collectionView1.frame.size.width,142);
        }
    }
    if (indexPath.section==1 || indexPath.section == 3)
    {
        return   CGSizeMake((collectionView1.frame.size.width),10);
    }
    else
    {
        if (isList==TRUE)
        {
            return   CGSizeMake((collectionView1.frame.size.width) - 16, 155);
        }
        return   CGSizeMake((collectionView1.frame.size.width/2)-12, 290);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section == 1 || section == 3)
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
    UICollectionViewCell *cell;
    if (indexPath.section==0)
    {
        TopStaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
        EGOImageView *imgServices = (EGOImageView *)[TopStaticCell viewWithTag:22];

        if (isList == TRUE)
        {
            [TopStaticCell.btnGrid setImage:[UIImage imageNamed:@"icon-Grid-Def"] forState:UIControlStateNormal];
            [TopStaticCell.btnList setImage:[UIImage imageNamed:@"icon-list-sel"] forState:UIControlStateNormal];
        }
        else
        {
            [TopStaticCell.btnGrid setImage:[UIImage imageNamed:@"icon-grid"] forState:UIControlStateNormal];
            [TopStaticCell.btnList setImage:[UIImage imageNamed:@"icon-list"] forState:UIControlStateNormal];
        }
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
        {
            TopStaticCell.lblCurrency.text=@"USD";
        }
        else
        {
            TopStaticCell.lblCurrency.text=@"INR";
        }
        
        if (_IsUpcomming == 1)
        {
            TopStaticCell.btnAuctionAnalist.hidden=YES;
        }
        else
        {
            TopStaticCell.btnAuctionAnalist.hidden=NO;
            [TopStaticCell.btnAuctionAnalist addTarget:self action:@selector(btnAuctionAnalistPressed:) forControlEvents:UIControlEventTouchUpInside];
        }

        if (_isWorkArt == YES || _isMyPurchase == YES || _isSearch == YES)
        {
            if (_isMyPurchase == YES)
            {
                UIView *liveView = (UIView *)[TopStaticCell viewWithTag:11];
                liveView.hidden = YES;
                TopStaticCell.imgContianView.hidden = YES;
                TopStaticCell.img_height.constant = 0;
                imgServices.hidden =  YES;
            }
            TopStaticCell.btnAuctionAnalist.hidden=YES;
            TopStaticCell.btnFilter.hidden = YES;
            TopStaticCell.lblFilter.hidden = YES;
            TopStaticCell.iconDropdown.hidden = YES;
        }

        
        if (arrPactAuctionItem.count>0)
        {
            clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:0];
            NSString *spaceUrl;
            
            if (isFilter == YES)
            {
                spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strauctionBanner]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            else
            {
                if (_isWorkArt == YES || _isSearch == YES)
                {
                    spaceUrl = [NSString stringWithFormat:@"%@",objCurrentOccution.strauctionBanner];
                }
                else
                {
                    spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strauctionBanner]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                }
            }
            
            imgServices.imageURL=[NSURL URLWithString:spaceUrl];
        }
        cell = TopStaticCell;
    }
    else if (indexPath.section == 1 || indexPath.section == 3)
    {
        static NSString *identifier = @"blankcell";
        UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell = cell2;
    }
    else
    {
        objCurrentOccutionForAuctionName = [arrPactAuctionItem objectAtIndex:0];
        clsCurrentOccution *objCurrentOccution = [arrPactAuctionItem objectAtIndex:indexPath.row];
        if (isList == FALSE)
        {
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
                if (_IsUpcomming)
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpcommingSelected" forIndexPath:indexPath];
                }
                else
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastSelected" forIndexPath:indexPath];
                }
                
                CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                [ClsSetting SetBorder:CurrentSelectedGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentSelectedGridCell.btnDetail.tag=indexPath.row;
                CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                
                if (_IsUpcomming==1)
                {
                    CurrentSelectedGridCell.isCommingFromUpcoming = 1;
                    CurrentSelectedGridCell.isCommingFromPast = 0;
                    CurrentSelectedGridCell.btnproxy.hidden=NO;
                }
                else
                {
                    CurrentSelectedGridCell.isCommingFromUpcoming = 0;
                    CurrentSelectedGridCell.isCommingFromPast = 1;
                    CurrentSelectedGridCell.btnproxy.hidden=YES;
                }
                
                //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                if ([objCurrentOccution.auctionType intValue] != 1)
                {
                    UILabel *Lbl_1 = (UILabel *)[CurrentSelectedGridCell viewWithTag:1];
                    Lbl_1.text = @"Title: ";
                    UILabel *Lbl_2 = (UILabel *)[CurrentSelectedGridCell viewWithTag:2];
                    Lbl_2.text = @"Description: ";
                    UILabel *Lbl_3 = (UILabel *)[CurrentSelectedGridCell viewWithTag:3];
                    Lbl_3.text = @"";
                    
                    CurrentSelectedGridCell.lblArtistName.text=objCurrentOccution.strtitle;
                    NSString *ht = [ClsSetting getAttributedStringFormHtmlString:objCurrentOccution.strPrdescription];
                    CurrentSelectedGridCell.lblMedium.text= ht;
                    CurrentSelectedGridCell.lblYear.text= @"";
                    CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                    
                }
                else
                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                    CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                    CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                    CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                }
                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                }
                else
                {
                    CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                }
                cell = CurrentSelectedGridCell;
            }
            else
            {
                if (_IsUpcomming)
                {
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpcommingDefult" forIndexPath:indexPath];
                }
                else
                {
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastDefult" forIndexPath:indexPath];
                }
                
                NSString *imgUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                CurrentDefultGridCell.imgProduct.imageURL = [NSURL URLWithString:imgUrl];
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];

                CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                [ClsSetting SetBorder:CurrentDefultGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                
                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentDefultGridCell.btnArtist.tag=indexPath.row;
                CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                CurrentDefultGridCell.btnMyGallery.tag = indexPath.row;
                
                //if ([objCurrentOccutionForAuctionName.strAuctionname isEqualToString:@"Collectibles Auction"])
                if ([objCurrentOccutionForAuctionName.auctionType intValue] != 1)
                {
                    CurrentDefultGridCell.lblArtistName.text = @"";
                    CurrentDefultGridCell.btnArtist.enabled = NO;
                }
                else
                {
                    CurrentDefultGridCell.btnArtist.enabled = YES;
                    CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                }
                
                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
            
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
                
                NSInteger incresedRate = (currentBid*15)/100;
                NSInteger incresedPrice = currentBid + incresedRate;
                
                if (_IsUpcomming == 1)
                {
//                    CurrentDefultGridCell.isCommingFromUpcoming = 1;
//                    CurrentDefultGridCell.isCommingFromPast = 0;
                    
                    CurrentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                    CurrentDefultGridCell.lbl_startPriceText.text = @"Opening Bid"; //@"Start price";
                    CurrentDefultGridCell.pastStatictext.hidden=YES;
                }
                else
                {
//                    CurrentDefultGridCell.isCommingFromUpcoming = 0;
//                    CurrentDefultGridCell.isCommingFromPast = 1;

                    CurrentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
                    CurrentDefultGridCell.lbl_startPriceText.text = @"";
                    
                    
                    if ([objCurrentOccution.strpricelow  intValue] > [objCurrentOccution.strpricers intValue] )
                    {
                        CurrentDefultGridCell.lblNextValidBuild.text = @"Bought In";
                        CurrentDefultGridCell.pastStatictext.hidden = YES;
//                        CurrentDefultGridCell.lblProductName.hidden = YES;
                    }
                    else
                    {
//                        CurrentDefultGridCell.hidden = NO;
                        CurrentDefultGridCell.pastStatictext.hidden = NO;
                        CurrentDefultGridCell.pastStatictext.text = @"(Inclusive of 15% Buyers Premium)";
                    }

                }
                cell = CurrentDefultGridCell;
            }
            
        }
        else
        {
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelectedList" forIndexPath:indexPath];
                
                CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
                
                [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:indexPath.row];
                
                CurrentSelectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                [ClsSetting SetBorder:CurrentSelectedGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentSelectedGridCell.btnGridSelectedDetail.tag = indexPath.row;
                
                //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                if ([objCurrentOccution.auctionType intValue] != 1)
                {
                    UILabel *Lbl_1 = (UILabel *)[CurrentSelectedGridCell viewWithTag:11];
                    Lbl_1.text = @"Title: ";
                    UILabel *Lbl_2 = (UILabel *)[CurrentSelectedGridCell viewWithTag:12];
                    Lbl_2.text = @"Description: ";
                    UILabel *Lbl_3 = (UILabel *)[CurrentSelectedGridCell viewWithTag:13];
                    Lbl_3.text = @"";
                    
                    CurrentSelectedGridCell.lblArtistName.text=objCurrentOccution.strtitle;
                    NSString *ht = [ClsSetting getAttributedStringFormHtmlString:objCurrentOccution.strPrdescription];
                    CurrentSelectedGridCell.lblMedium.text= ht;
                    CurrentSelectedGridCell.lblYear.text= @"";
                    CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                }
                else
                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                    CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                    CurrentSelectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                    CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                    CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                }
                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                }
                else
                {
                    CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                }
                cell = CurrentSelectedGridCell;
                
            }
            else
            {
                if (_IsUpcomming)
                {
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpcommingDefultList" forIndexPath:indexPath];
                }
                else
                {
                    CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastDefultList" forIndexPath:indexPath];
                }
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:spaceUrl];
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];

                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;

                CurrentDefultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                [ClsSetting SetBorder:CurrentDefultGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                
                [CurrentDefultGridCell setupGesture];

                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                CurrentDefultGridCell.btnArtist.tag=indexPath.row;

                
                //if ([objCurrentOccutionForAuctionName.strAuctionname isEqualToString:@"Collectibles Auction"])
                if ([objCurrentOccution.auctionType intValue] != 1)
                {
                    CurrentDefultGridCell.lblArtistName.text = @"";
                    CurrentDefultGridCell.btnArtist.enabled = NO;
                }
                else
                {
                    CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                }
            
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
                
                NSInteger incresedRate = (currentBid*15)/100;
                NSInteger incresedPrice = currentBid + incresedRate;
                
                
                if (_IsUpcomming == 1)
                {
                    CurrentDefultGridCell.isCommingFromUpcoming = 1;
                    CurrentDefultGridCell.isCommingFromPast = 0;
                    
                    CurrentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:currentBid]];
                    CurrentDefultGridCell.lbl_startPriceText.text = @"Opening Bid"; //@"Start price";
                    CurrentDefultGridCell.pastStatictext.hidden=YES;
                    
                    if (objCurrentOccution.IsSwapOn == 1)
                    {
                        CurrentDefultGridCell.viwSwap.frame = CGRectMake(-(CurrentDefultGridCell.viwSwap.frame.size.width/2), CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
                    else
                    {
                        CurrentDefultGridCell.viwSwap.frame = CGRectMake(0, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }

                }
                else
                {
                    CurrentDefultGridCell.isCommingFromUpcoming = 0;
                    CurrentDefultGridCell.isCommingFromPast = 1;
                    
                    CurrentDefultGridCell.lblNextValidBuild.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:incresedPrice]];
                    CurrentDefultGridCell.lbl_startPriceText.text = @"";
                    
                    
                    if ([objCurrentOccution.strpricelow  intValue] > [objCurrentOccution.strpricers intValue] )
                    {
                        CurrentDefultGridCell.lblNextValidBuild.text = @"Bought In";
                        CurrentDefultGridCell.pastStatictext.hidden = YES;
                    }
                    else
                    {
                        CurrentDefultGridCell.pastStatictext.hidden = NO;
                        CurrentDefultGridCell.pastStatictext.text = @"(Inclusive of 15% Buyers Premium)";
                    }
                    if (objCurrentOccution.IsSwapOn==1)
                    {
                        CurrentDefultGridCell.viwSwap.frame=CGRectMake(-(CurrentDefultGridCell.viwSwap.frame.size.width/4), CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
                    else
                    {
                        CurrentDefultGridCell.viwSwap.frame=CGRectMake(0, CurrentDefultGridCell.viwSwap.frame.origin.y, CurrentDefultGridCell.viwSwap.frame.size.width, CurrentDefultGridCell.viwSwap.frame.size.width);
                    }
                }
                [CurrentDefultGridCell setuparray];
                cell = CurrentDefultGridCell;
            }
        }
        
        [ClsSetting SetBorder:cell cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
    }
    return cell;
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

-(void)ListSwipeOptionpressed:(int)option currentCellIndex:(int)index
{
    if (option==1)
    {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=index;
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
    }
    
}

-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:2];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc] initWithObjects:indexPath, nil];
    [_ClvItemOfPastAuction reloadItemsAtIndexPaths: arrindexpath];
    
}
- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:2];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL],objCurrentOccution.strimage]];
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)
    [_ClvItemOfPastAuction cellForItemAtIndexPath:indexPath];
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
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//    {
//      objProductViewController.iscurrencyInDollar=1;
//    }
    objProductViewController.IsUpcomming = _IsUpcomming;
    objProductViewController.IsPast = _IsPast;
    objProductViewController.Auction_id = objCurrentOccutionForAuctionName.strOnline;
    [self.navigationController pushViewController:objProductViewController animated:YES];
}


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
    objFilterViewController.ispast=1;
    objFilterViewController.arrselectArtist=arrSelectedArtistarray;
    if (_IsUpcomming==1)
    {
        objFilterViewController.strType=@"Upcomming";
        objFilterViewController.selectedTab=2;
    }
    else
    {
        objFilterViewController.strType=@"Past";
        objFilterViewController.selectedTab=3;
    }
    //objFilterViewController.auctionName = objCurrentOccutionForAuctionName.strAuctionname;
    objFilterViewController.auctionType = objCurrentOccutionForAuctionName.auctionType;
    objFilterViewController.auctionID = [objCurrentOccutionForAuctionName.strOnline intValue];
    objFilterViewController.delegateFilter=self;
    [self.navigationController pushViewController:objFilterViewController animated:YES];
}

-(void)clearCancelFilter
{
    if (_isSearch == YES)
    {
        isFilter = NO;
        arrPactAuctionItem = [arrSearchResult mutableCopy];
        [_ClvItemOfPastAuction reloadData];
    }
    else
    {
        [self getAccuctions];
    }
}

-(void)filter:(NSMutableArray *)arrFilterArray selectedArtistArray:(NSMutableArray *)arrSelectedArtist
{
    isFilter = YES;
    NSString *str=[[NSString alloc] init];
    for (int i=0; i<arrSelectedArtist.count; i++)
    {
        clsArtistInfo *objartistinfo=[arrSelectedArtist objectAtIndex:i];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@",objartistinfo.strArtistid,@"K"]];
    }
    [self filterAuctions:str];
    
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
                clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=FALSE;
                objAuctionItemBidViewController.IsUpcoming = _IsUpcomming;
                objAuctionItemBidViewController.IsPast = _IsPast;
                objAuctionItemBidViewController.Auction_id = objCurrentOccutionForAuctionName.strOnline; // _objPast.strAuctionId;
//                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
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

- (IBAction)btnAuctionAnalistPressed:(UIButton*)sender
{
    AuctionAnalyisisViewController *auctionAnalysisVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionAnalyisisViewController"];
    auctionAnalysisVC.objCurrentOuction =  objCurrentOccutionForAuctionName;
    [self.navigationController pushViewController:auctionAnalysisVC animated:YES];
    
//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@",[ClsSetting autionAnalysisURL],objCurrentOccutionForAuctionName.strOnline];
//    NSURL *url = [NSURL URLWithString:[ClsSetting TrimWhiteSpaceAndNewLine:strUrl]];
//    NSLog(@"strUrl = %@  url = %@",strUrl, url);
//    objWebViewViewController.url=url;// _objPast.strAuctionId]];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}

- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
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
        [self goLoginVC];
    }
}
-(void)goLoginVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
    [self.navigationController pushViewController:rootViewController animated:YES];
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
}
-(void)passReseposeData1:(id)str
{
    [self myAuctionGallery];
}

-(void)myAuctionGallery
{
    
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    
    MyAuctionGalleryViewController *objMyAuctionGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    objMyAuctionGalleryViewController.isCurrent = 0;
    [navcontroll pushViewController:objMyAuctionGalleryViewController animated:YES];
}


-(void)filterAuctions:(NSString*)strid
{
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
       
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *strtype;
//        _objPast.strAuctionname
        //if ([objCurrentOccutionForAuctionName.strAuctionname isEqualToString:@"Collectibles Auction"])
        if ([objCurrentOccutionForAuctionName.auctionType intValue] != 1)
        {
            strtype = @"C";
        }
        else if (_IsUpcomming == 1)
        {
           strtype = @"U";
        }
        else if (_IsPast == 1)
        {
            strtype = @"P";
        }
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spPastAuction(%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],objCurrentOccutionForAuctionName.strOnline,strtype,strid,[ClsSetting apiKey]];

        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSMutableArray *arrItemCount=[parese parseSortCurrentAuction:dict];
             [arrPactAuctionItem removeAllObjects];
             arrPactAuctionItem=arrItemCount;
             if (arrPactAuctionItem.count == 0)
             {
                 _noRecords_Lbl.hidden = NO;
                 _noRecords_Lbl.text = @"No record found, please try some other filtration options.";
             }
             else
             {
                 _noRecords_Lbl.hidden = YES;
                 _noRecords_Lbl.text = @"";
             }
             [_ClvItemOfPastAuction reloadData];
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


@end
