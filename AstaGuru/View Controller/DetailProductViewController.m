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
@interface DetailProductViewController ()
{
    NSMutableArray *arrDescription;
     NSMutableArray *arrBottomMenu;
    
}
@end

@implementation DetailProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"CURRENT",@"UPCOMING",@"PAST", nil];
    
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
[self setUpNavigationItem];
}
-(void)viewDidAppear:(BOOL)animated
{
   /* self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];*/
      self.navigationController.navigationBar.backItem.title = @"Back";
}
-(void)setUpNavigationItem
{
   
    self.title=[NSString stringWithFormat:@"Lot %@",_objCurrentOccution.strReference];
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
        return   CGSizeMake(collectionView1.frame.size.width,390);
    }
    else if (indexPath.section==3)
    {
        return   CGSizeMake(collectionView1.frame.size.width,55);
    }
    else
    {
        NSMutableDictionary *dict=[arrDescription objectAtIndex:indexPath.row];
        CGSize maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-16, FLT_MAX);
        CGRect labelRect1 = [[dict valueForKey:@"Description"]
                             boundingRectWithSize:maximumLabelSize
                             options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName : [UIFont systemFontOfSize:17]
                                          }
                             context:nil];
     return   CGSizeMake(collectionView1.frame.size.width,labelRect1.size.height+50);
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
        UILabel *lblCounDown = (UILabel *)[cell viewWithTag:13];
        UILabel *lblEstimate = (UILabel *)[cell viewWithTag:15];
        lblEstimate.text=[NSString stringWithFormat:@"%@",_objCurrentOccution.strestamiate];
        
         UILabel *lblnextValidBid = (UILabel *)[cell viewWithTag:51];
         UILabel *lblCurrentbid = (UILabel *)[cell viewWithTag:52];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
       
        if (_iscurrencyInDollar==1)
        {
            numberFormatter.currencyCode = @"USD";
            NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOccution.strpriceus];
            
            
            lblCurrentbid.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
          
            
            int price =[_objCurrentOccution.strpriceus intValue];
            int priceIncreaserete=(price*10)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
            
              lblnextValidBid.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
            NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOccution.strpricers];
            
            
            lblCurrentbid.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
            
            
            int price =[_objCurrentOccution.strpricers intValue];
            int priceIncreaserete=(price*10)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
             lblnextValidBid.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            
            NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
            NSArray *subStrings = [_objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
                
                lblEstimate.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                
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
        NSDate *Enddate = [dateFormat dateFromString:_objCurrentOccution.strBidclosingtime];
        
        NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
        NSDate *todaydate = [dateFormat dateFromString:strToday];
        
        NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
        lblCounDown.text=strCondown;
        
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
        
        static NSString *identifier = @"DescriptionCell";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        NSMutableDictionary *dict=[arrDescription objectAtIndex:indexPath.row];
        UILabel *lblTitle = (UILabel *)[cell viewWithTag:21];
        lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Title"]];
        
        UILabel *lblDescription = (UILabel *)[cell viewWithTag:22];
        lblDescription.text=[ClsSetting getAttributedStringFormHtmlString:[dict objectForKey:@"Description"]];
        
        
                //lblDescription.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Description"]];
        
        
        cell1 = cell;
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
    AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
    objAuctionItemBidViewController.objCurrentOuction=_objCurrentOccution;
      objAuctionItemBidViewController.isBidNow=1;
    [self addChildViewController:objAuctionItemBidViewController];
    
    
    
    
    [self.view addSubview:objAuctionItemBidViewController.view];
}

- (IBAction)btnProxyBidpressed:(id)sender
{
   
    
    AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
    objAuctionItemBidViewController.objCurrentOuction=_objCurrentOccution;
    objAuctionItemBidViewController.isBidNow=FALSE;
   
        objAuctionItemBidViewController.isBidNow=0;
   
    
    [self addChildViewController:objAuctionItemBidViewController];
    [self.view addSubview:objAuctionItemBidViewController.view];
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
- (IBAction)btnMyAuctionGallery:(id)sender
{
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    
    MyAuctionGalleryViewController *objAfterLoginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    [navcontroll pushViewController:objAfterLoginViewController animated:YES];
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
    
    [self.navigationController pushViewController:objBidHistoryViewController animated:YES];
}
- (IBAction)btnViewAdditionalChargesPressed:(id)sender
{
    AdditionalChargesViewController *objAdditionalChargesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditionalChargesViewController"];
    objAdditionalChargesViewController.objCurrentOuction=_objCurrentOccution;
    
    [self.navigationController pushViewController:objAdditionalChargesViewController animated:YES];
}

@end
