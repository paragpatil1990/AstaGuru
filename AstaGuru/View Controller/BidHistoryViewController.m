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
    
       arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"AUCTION",@"UPCOMING",@"PAST", nil];
    [self getOccttionData];
    
    [self setNavigationBarBackButton];

    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    /* self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];*/
    //self.navigationController.navigationBar.backItem.title = @"Back";
    
    
    countDownTimer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(refreshData) userInfo:nil repeats:YES];

}

-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
  //  [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
  //  [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
   // [_backButton setTitle:@"Back" forState:UIControlStateNormal];
   // [[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
   // [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [countDownTimer invalidate];
    countDownTimer = nil;
}
-(void)getOccttionData
{

    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetBidByLatest(%@)?api_key=%@",[ClsSetting procedureURL],_objCurrentOuction.strproductid,[ClsSetting apiKey]];
        
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
    self.navigationItem.title=@"Bid History";
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
    @try {
        
        //        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetBidPrice(%@)?api_key=%@",[ClsSetting procedureURL],_objCurrentOuction.strproductid,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             //             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSDictionary *priceDic = [ClsSetting RemoveNull:[dict[0] mutableCopy]];
             NSLog(@"price = %@",priceDic);
             NSNumber *strpricers = priceDic[@"pricers"];
             NSNumber *strpriceus = priceDic[@"priceus"];
             
             _objCurrentOuction.strpricers = [NSString stringWithFormat:@"%@", strpricers];
             _objCurrentOuction.strpriceus = [NSString stringWithFormat:@"%@", strpriceus];
             _objCurrentOuction.strBidclosingtime = priceDic[@"Bidclosingtime"];
             _objCurrentOuction.strCurrentDate = priceDic[@"currentDate"];
             _objCurrentOuction.strmyuserid = priceDic[@"MyUserID"];
             
             NSString *closeingTime = priceDic[@"myBidClosingTime"];
             
             NSArray *timeArray = [closeingTime componentsSeparatedByString:@" "];
             
             NSString *dateString = [timeArray lastObject];//@"13:17:34.674194";
             NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
             dateFormatter.dateFormat = @"HH:mm:ss:SS";
             NSDate *yourDate = [dateFormatter dateFromString:dateString];
             dateFormatter.dateFormat = @"HH:mm:ss";
             
             _objCurrentOuction.strmyBidClosingTime = [NSString stringWithFormat:@"%@ %@", [timeArray objectAtIndex:0],[dateFormatter stringFromDate:yourDate]];
             _objCurrentOuction.strtimeRemains = priceDic[@"timeRemains"];
             
             [_clsBidHistory reloadData];
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
//            return   CGSizeMake((collectionView1.frame.size.width),276);
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
            
            CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter setMaximumFractionDigits:0];
            if ([_objCurrentOuction.strpricers intValue] >= 10000000) 
            {
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
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
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                }
            }
            else{
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    
                    
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
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                }
            }
            
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
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
            }
            else
            {
                CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strcollectors;
            }

            //if ([_objCurrentOuction.strAuctionname isEqualToString:@"Collectibles Auction"])
            if ([_objCurrentOuction.auctionType intValue] != 1)
            {
                UIView *subvuew = (UIView*) [CurrentSelectedGridCell viewWithTag:10];
                UILabel *Lbl_1 = (UILabel *)[subvuew viewWithTag:1];
                Lbl_1.text = @"Title: ";
                UILabel *Lbl_2 = (UILabel *)[subvuew viewWithTag:2];
                Lbl_2.text = @"Description: ";
                UILabel *Lbl_3 = (UILabel *)[subvuew viewWithTag:3];
                Lbl_3.text = @"";
                
                CurrentSelectedGridCell.lblArtistName.text=_objCurrentOuction.strtitle;
                NSString *ht = [ClsSetting getAttributedStringFormHtmlString:_objCurrentOuction.strPrdescription];
                CurrentSelectedGridCell.lblMedium.text= ht;
                CurrentSelectedGridCell.lblYear.text = @"";
                CurrentSelectedGridCell.lblSize.text = [NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
            }
            else
            {
//                if (_IsSort==1)
//                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
                    CurrentSelectedGridCell.lblMedium.text=[NSString stringWithFormat:@"%@",_objCurrentOuction.strmedium];
//                }
//                else
//                {
//                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.objArtistInfo.strFirstName,_objCurrentOuction.objArtistInfo.strLastName];
//                    CurrentSelectedGridCell.lblMedium.text=[NSString stringWithFormat:@"%@",_objCurrentOuction.objMediaInfo.strMediumName];
//                }
                CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
                CurrentSelectedGridCell.lblYear.text=[NSString stringWithFormat:@"%@",_objCurrentOuction.strproductdate];
            }

            
            
            CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
            CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
            
            CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], _objCurrentOuction.strthumbnail]];
            [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
            
//            NSString *timeStr=[self timercount:_objCurrentOuction.strBidclosingtime fromDate:_objCurrentOuction.strCurrentDate];
            if ([_objCurrentOuction.strtimeRemains intValue] < 0)
            {
                CurrentSelectedGridCell.btnbidNow.enabled = NO;
                CurrentSelectedGridCell.btnproxy.enabled = NO;
                CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor grayColor];
                CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor grayColor];
            }
            else
            {
                CurrentSelectedGridCell.btnbidNow.enabled = YES;
                CurrentSelectedGridCell.btnproxy.enabled = YES;
                CurrentSelectedGridCell.btnbidNow.backgroundColor = [UIColor blackColor];
                CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor blackColor];
            }
            
            if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
            {
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [_objCurrentOuction.strmyuserid intValue])
                {
                    CurrentSelectedGridCell.btnbidNow.hidden = YES;
                    CurrentSelectedGridCell.btnproxy.hidden = YES;
                    UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                    leading_Lbl.hidden = NO;
                    if ([_objCurrentOuction.strtimeRemains intValue] < 0)
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
                    CurrentSelectedGridCell.btnbidNow.hidden = NO;
                    CurrentSelectedGridCell.btnproxy.hidden = NO;
                    UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                    leading_Lbl.hidden = YES;
                }
            }
            
            if (_IsUpcoming == 1)
            {
                UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                leading_Lbl.hidden = YES;

                CurrentSelectedGridCell.btnbidNow.hidden = YES;
                CurrentSelectedGridCell.btnproxy.enabled = YES;
                CurrentSelectedGridCell.btnproxy.backgroundColor = [UIColor blackColor];
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
            
            NSNumberFormatter *num = [[NSNumberFormatter alloc] init];
            num.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *myNumber = [num numberFromString:objMyOuctionGallery.strBidpricers];
            
            
            NSString *strBidpricers = [numberFormatter stringFromNumber:myNumber];
            
            lblBidpricers.text=[NSString stringWithFormat:@"%@",strBidpricers];
            
            NSNumberFormatter *numberFormatter1 = [[NSNumberFormatter alloc] init] ;
            [numberFormatter1 setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter1 setMaximumFractionDigits:0];
            numberFormatter1.currencyCode = @"USD";
            
            UILabel *lblBidpriceus = (UILabel *)[BidCell viewWithTag:14];
           
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
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:20];
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];

        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        lblSelectedline.hidden=YES;
        
        UIButton *btnLive = (UIButton *)[cell1 viewWithTag:23];
        btnLive.layer.cornerRadius = 4;
        btnLive.hidden = YES;
        
        UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
        
        if (indexPath.row == 1)
        {
            btnLive.hidden = NO;
        }
        
        if (indexPath.row==1)
        {
            
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden=NO;
        }
        else
        {
            lblTitle.textColor=[UIColor blackColor];//[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            lblline.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
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
                
//                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=0;
//                }
                objAuctionItemBidViewController.IsUpcoming = _IsUpcoming;
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have Bidding Access. Please contact Astaguru."  preferredStyle:UIAlertControllerStyleAlert];
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
//                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=0;
//                }
                objAuctionItemBidViewController.isBidNow=0;
                [self addChildViewController:objAuctionItemBidViewController];
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have Bidding Access. Please contact Astaguru."  preferredStyle:UIAlertControllerStyleAlert];
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
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        if (indexPath.row==0)
        {
            ViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [navcontroll pushViewController:objViewController animated:YES];
        }
        
        else if (indexPath.row==2)
        {
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.IsUpcomming = 1;
            [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
            
        }
        else if (indexPath.row==3)
        {
            PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
            objPastOccuctionViewController.IsUpcomming = 0;
            [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
        }
    }
}

@end
