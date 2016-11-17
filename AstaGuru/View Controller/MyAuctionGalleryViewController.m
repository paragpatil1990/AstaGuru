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
@interface MyAuctionGalleryViewController ()<PassResepose,CurrentOccution>
{
    NSMutableArray *arrMyAuctionGallery;
    BOOL isList;
    int WebserviceCount;
}
@end

@implementation MyAuctionGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrMyAuctionGallery=[[NSMutableArray alloc]init];
    [self getMyOccttionGallery];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
-(void)getMyOccttionGallery
{
    
    //USE LIMIT 10
    ;
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
    
    
    NSString *strUserName=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"bidrecord?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",strUserName] view:self.view Post:NO];
    
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
         arrItemCount=[parese parseMyAuctionGallery:[dict1 valueForKey:@"resource"] fromBid:1];
         [arrMyAuctionGallery addObjectsFromArray:arrItemCount];
        [self getMyBidData];
    }
    else
    {
        arrItemCount=[parese parseMyAuctionGallery:[dict1 valueForKey:@"resource"] fromBid:0];
        [arrMyAuctionGallery addObjectsFromArray:arrItemCount];

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
    return   CGSizeMake((collectionView1.frame.size.width/2)-10,286);
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
    UICollectionViewCell *cell1;
    
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
         clsMyAuctionGallery *objCurrentOccution=[arrMyAuctionGallery objectAtIndex:indexPath.row];
       if ([objCurrentOccution.strTypeOfCell intValue]==1)
        {
            CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
            
            /*[UIView transitionWithView:CurrentDefultGridCell.contentView
             duration:5
             options:UIViewAnimationOptionTransitionFlipFromLeft
             animations:^{
             
             CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
             
             
             } completion:nil];*/
            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstname,objCurrentOccution.strLastname];
            CurrentSelectedGridCell.lblProductName.text=objCurrentOccution.objCurrentAuction.strtitle;
           
            CurrentSelectedGridCell.lblYear.text= objCurrentOccution.objCurrentAuction.strproductdate;
            CurrentSelectedGridCell.lblSize.text= objCurrentOccution.objCurrentAuction.strproductsize;
    
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strdaterec];
            
            
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
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.objCurrentAuction.strReference] forState:UIControlStateNormal];
            CurrentSelectedGridCell.CurrentOccutiondelegate=self;
            CurrentSelectedGridCell.iSelectedIndex=indexPath.row;
            CurrentSelectedGridCell.objMyAuctionGallery=objCurrentOccution;
           
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strBidpriceus];
                
                
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
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.objCurrentAuction.strReference] forState:UIControlStateNormal];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            
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
        
   }
   /*  else
    {
        if ([objCurrentOccution.strTypeOfCell intValue]==1)
        {
            CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelectedList" forIndexPath:indexPath];
            
            /*[UIView transitionWithView:CurrentDefultGridCell.contentView
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
    clsMyAuctionGallery *objCurrentOccution=[[clsMyAuctionGallery alloc]init];
    objCurrentOccution=[arrMyAuctionGallery objectAtIndex:sender.tag];
    
    
    //UICollectionViewCell *cell = [_clvCurrentOccution ]
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:1];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],objCurrentOccution.strThumbnail]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
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

@end
