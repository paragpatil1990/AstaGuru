//
//  BidHistoryViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 13/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "BidHistoryViewController.h"
#import "ClsSetting.h"
#import "SWRevealViewController.h"
#import "clsMyAuctionGallery.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "AuctionItemBidViewController.h"
#import "ViewController.h"
#import "PastOccuctionViewController.h"
#import "BforeLoginViewController.h"
#import "VerificationViewController.h"
@interface BidHistoryViewController ()<PassResepose>
{
    NSMutableArray *arrBidHistoryData;
    NSMutableArray *arrBottomMenu;
    NSTimer *countDownTimer;

}
@end

@implementation BidHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    arrBidHistoryData=[[NSMutableArray alloc]init];
    
       arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"CURRENT",@"UPCOMING",@"PAST", nil];
    [self getOccttionData];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    /* self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];*/
    self.navigationController.navigationBar.backItem.title = @"Back";
    
    countDownTimer =[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(refreshData) userInfo:nil repeats:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [countDownTimer invalidate];
}
-(void)getOccttionData
{
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
//    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"bidrecord?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=productid=%@",_objCurrentOuction.strproductid] view:self.view Post:NO];
//
//    objSetting.PassReseposeDatadelegate=self;
    
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
        
//        http://54.169.222.181/api/v2/guru/_proc/spGetBidByLatest(2577)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetBidByLatest(%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objSetting UrlProcedure],_objCurrentOuction.strproductid];
        
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];

             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
             NSLog(@"%@",dict1);
             NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
             
             arrItemCount=[parese parseMyAuctionGallery:dict1 fromBid:1];
             
             [arrBidHistoryData addObjectsFromArray:arrItemCount];
             
             [_clsBidHistory reloadData];
             
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

-(void)setUpNavigationItem
{
   // self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
   // self.sidebarButton.tintColor=[UIColor whiteColor];
    
        self.navigationItem.title=@"Bid History";
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   // [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
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
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}
-(void)searchPressed
{
   [ClsSetting Searchpage:self.navigationController];  
}
-(void)myastaguru
{
    
    [ClsSetting myAstaGuru:self.navigationController];
    
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
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetBidPrice(%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objSetting UrlProcedure],_objCurrentOuction.strproductid];
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
             _objCurrentOuction.strpricers=strpricers;
             _objCurrentOuction.strpriceus=strpriceus;
             _objCurrentOuction.strBidclosingtime = priceDic[@"Bidclosingtime"];
             _objCurrentOuction.strCurrentDate = priceDic[@"currentDate"];
             
             [_clsBidHistory reloadData];
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
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    arrItemCount=[parese parseMyAuctionGallery:[dict1 valueForKey:@"resource"] fromBid:1];
    
        [arrBidHistoryData addObjectsFromArray:arrItemCount];
    
    [_clsBidHistory reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clsBidHistory)
    {
        return 3;
        
    }
    else
    {
        return 1;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clsBidHistory)
    {
        if (indexPath.section==0)
        {
            return   CGSizeMake(collectionView1.frame.size.width,290);
        }
       else if (indexPath.section==1)
        {
            return   CGSizeMake(collectionView1.frame.size.width,70);
        }
        else
        {
            CGSize maximumLabelSize = CGSizeMake((collectionView1.frame.size.width-40)/4, FLT_MAX);
            
            clsMyAuctionGallery *objMyAuctionGallery=[arrBidHistoryData objectAtIndex:indexPath.row];
            CGRect labelUserNmae = [objMyAuctionGallery.strUsername
                                 boundingRectWithSize:maximumLabelSize
                                 options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{
                                              NSFontAttributeName : [UIFont systemFontOfSize:12]
                                              }
                                 context:nil];
            CGRect labelPriceRs = [[NSString stringWithFormat:@"%@",objMyAuctionGallery.strBidpricers]
                                 boundingRectWithSize:maximumLabelSize
                                 options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{
                                              NSFontAttributeName : [UIFont systemFontOfSize:12]
                                              }
                                 context:nil];
            CGRect labelPriceUS = [[NSString stringWithFormat:@"%@",objMyAuctionGallery.strBidpriceus]
                                   boundingRectWithSize:maximumLabelSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{
                                                NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                }
                                   context:nil];
            
            CGRect labelDate = [objMyAuctionGallery.strdaterec
                                   boundingRectWithSize:maximumLabelSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{
                                                NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                }
                                   context:nil];
            
            
         
            int max = MAX(MAX(MAX(labelUserNmae.size.height, labelPriceRs.size.height), labelPriceUS.size.height),labelDate.size.height);
            if (max<40)
            {
                max=40;
            }
               return   CGSizeMake(collectionView1.frame.size.width,max);
            return   CGSizeMake((collectionView1.frame.size.width),276);
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
    
    if (collectionView==_clsBidHistory)
    {
        if (section==0)
        {
            return 1;
        }
        if (section==1)
        {
            return 1;
        }
        else
        {
            return  arrBidHistoryData.count;
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
    UICollectionViewCell*Title;
    UICollectionViewCell*BidCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
    UICollectionViewCell *cell1;
    
    if (collectionView==_clsBidHistory)
    {
        
        
        if (indexPath.section==0)
        {
            CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected1234" forIndexPath:indexPath];
                    
                    /*[UIView transitionWithView:CurrentDefultGridCell.contentView
                     duration:5
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                     
                     CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
                     
                     
                     } completion:nil];*/
            CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
                   NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
            if ([_objCurrentOuction.strpricers intValue] > 10000000) // 10000000
            {
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
//                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
                    
                    int price =[_objCurrentOuction.strpriceus intValue];

                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int priceIncreaserete=(price*5)/100;
                    int FinalPrice=price+priceIncreaserete;
                    
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    
//                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
                    
                    int price =[_objCurrentOuction.strpricers intValue];
                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int priceIncreaserete=(price*5)/100;
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    
                    //  NSString *strFromRangeString;
                    // NSString *strToRangeString;
                    NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                    NSArray *subStrings = [_objCurrentOuction.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                    
//                    [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:(NSInteger*)indexPath.row];
                    
                    //NSLog(@"%@ -> %.2f", result, [numberResult floatValue]);
                    
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                }
            }
            else{
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    
//                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
                    
                    int price =[_objCurrentOuction.strpriceus intValue];

                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];

                    int priceIncreaserete=(price*10)/100;
                    int FinalPrice=price+priceIncreaserete;
                    
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    
//                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
                    int price =[_objCurrentOuction.strpricers intValue];
                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int priceIncreaserete=(price*10)/100;
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    
                    //  NSString *strFromRangeString;
                    // NSString *strToRangeString;
                    NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                    NSArray *subStrings = [_objCurrentOuction.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                    
//                    [self addTapGestureOnProductimage:CurrentSelectedGridCell.imgProduct indexpathrow:(NSInteger*)indexPath.row];
                    
                    //NSLog(@"%@ -> %.2f", result, [numberResult floatValue]);
                    
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                }
            }

//                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//                    {
//                        numberFormatter.currencyCode = @"USD";
//                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
//                        
//                        
//                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
//                        
//                        int price =[_objCurrentOuction.strpriceus intValue];
//                        int priceIncreaserete=(price*10)/100;
//                        int FinalPrice=price+priceIncreaserete;
//                        
//                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
//                        
//                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//                    }
//                    else
//                    {
//                        numberFormatter.currencyCode = @"INR";
//                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
//                        
//                        
//                        
//                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
//                        
//                        int price =[_objCurrentOuction.strpricers intValue];
//                        int priceIncreaserete=(price*10)/100;
//                        int FinalPrice=price+priceIncreaserete;
//                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
//                        
//                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            
                        
                        NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                        NSArray *subStrings = [_objCurrentOuction.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                        
//                    }
            
            if (_IsSort==1)
            {
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
                CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.strmedium;
                CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.strcategory;
            }
            else
            {
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.objArtistInfo.strFirstName,_objCurrentOuction.objArtistInfo.strLastName];
                CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.objMediaInfo.strMediumName;
                CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.objCategoryInfo.strCategoryName;
            }
                    
                     CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                    CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
                   
            
                    CurrentSelectedGridCell.lblYear.text= _objCurrentOuction.strproductdate;
                    CurrentSelectedGridCell.lblSize.text= [NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
            CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOuction.strthumbnail]];
                    [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
            if (_IsUpcoming == 1)
            {
                CurrentSelectedGridCell.btnbidNow.hidden = YES;
            }
                cell = CurrentSelectedGridCell;
            
                }
        else if (indexPath.section==1)
        {
        Title = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleBid" forIndexPath:indexPath];
            
            UILabel *lblUsername = (UILabel *)[Title viewWithTag:21];
            lblUsername.text=[NSString stringWithFormat:@"No of Bids: %lu",(unsigned long)arrBidHistoryData.count];
            cell=Title;
        }
        else
        {
            clsMyAuctionGallery*objMyOuctionGallery=[arrBidHistoryData objectAtIndex:indexPath.row];
            BidCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidCell" forIndexPath:indexPath];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
           [numberFormatter setMaximumFractionDigits:0];
          
            
            UILabel *lblUsername = (UILabel *)[BidCell viewWithTag:12];
            lblUsername.text=[NSString stringWithFormat:@"%@",objMyOuctionGallery.stranoname];
            
            numberFormatter.currencyCode = @"INR";
            UILabel *lblBidpricers = (UILabel *)[BidCell viewWithTag:13];
            
//            NSNumber *num = 
            
            NSNumberFormatter *num = [[NSNumberFormatter alloc] init];
            num.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *myNumber = [num numberFromString:objMyOuctionGallery.strBidpricers];
            
            
            NSString *strBidpricers = [numberFormatter stringFromNumber:myNumber];

            
//            NSString *strBidpricers = [numberFormatter stringFromNumber:(NSNumber*)objMyOuctionGallery.strBidpricers];
            lblBidpricers.text=[NSString stringWithFormat:@"%@",strBidpricers];
            
            NSNumberFormatter *numberFormatter1 = [[NSNumberFormatter alloc] init] ;
            [numberFormatter1 setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter1 setMaximumFractionDigits:0];
            numberFormatter1.currencyCode = @"USD";
          
            UILabel *lblBidpriceus = (UILabel *)[BidCell viewWithTag:14];
            
//            NSNumberFormatter *num1 = [[NSNumberFormatter alloc] init];
//            num.numberStyle = NSNumberFormatterDecimalStyle;
            
            NSNumber *myNumber1 = [num numberFromString:objMyOuctionGallery.strBidpriceus];
            
            NSString *strBidPriceCurrency = [numberFormatter1 stringFromNumber:myNumber1];
            
            lblBidpriceus.text=[NSString stringWithFormat:@"%@",strBidPriceCurrency];
            
            UILabel *lbldaterec = (UILabel *)[BidCell viewWithTag:15];
            lbldaterec.text=[NSString stringWithFormat:@"%@",objMyOuctionGallery.strdaterec];
            
            
            cell=BidCell;
            
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (section==0||section==1 )
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 25);
    }
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
                objAuctionItemBidViewController.objCurrentOuction=_objCurrentOuction;
                objAuctionItemBidViewController.isBidNow=1;
                [self addChildViewController:objAuctionItemBidViewController];
                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
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
                objAuctionItemBidViewController.objCurrentOuction=_objCurrentOuction;
                objAuctionItemBidViewController.isBidNow=FALSE;
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
                }
                objAuctionItemBidViewController.isBidNow=0;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(collectionView==_clvBottomMenu)
    {
        if (indexPath.row==0)
        {
            
            UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
            ViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [navcontroll pushViewController:objViewController animated:YES];
        }
        
        else if (indexPath.row==2)
        {
            /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             CurrentOccutionViewController *objDetailVideoViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
             [self.navigationController pushViewController:objDetailVideoViewController animated:YES];*/
            
            UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.iIsUpcomming=1;
            [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
            
        }
        else if (indexPath.row==3)
        {
            /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             CurrentOccutionViewController *objDetailVideoViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
             [self.navigationController pushViewController:objDetailVideoViewController animated:YES];*/
            
            UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.iIsUpcomming=2;
            [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
            
        }
    }
}

@end
