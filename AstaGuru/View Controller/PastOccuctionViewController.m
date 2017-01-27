//
//  PastOccuctionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "PastOccuctionViewController.h"
#import "ClsSetting.h"
#import "SWRevealViewController.h"
#import "PastAuctionCollectionViewCell.h"
#import "ViewController.h"
#import "CurrentOccutionViewController.h"
#import "BforeLoginViewController.h"
#import "AfterLoginViewController.h"
#import "ItemOfPastAuctionViewController.h"
#import "ArtistViewController.h"
@interface PastOccuctionViewController ()<PassResepose>
{
    int iOffset;
    NSMutableArray *arrOccution;
    CGRect *selectedCellDefaultFrame;
    NSMutableArray *arrBottomMenu;
    BOOL isReloadDate;
}
@end

@implementation PastOccuctionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

[super viewDidLoad];
arrOccution=[[NSMutableArray alloc]init];



arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"CURRENT",@"UPCOMING",@"PAST", nil];
[self getOccttionData];
// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self setUpNavigationItem];
}
-(void)getOccttionData
{
    
    //USE LIMIT 10
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"AuctionList?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    
}
-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    if (_iIsUpcomming==1)
    {
         self.navigationItem.title=@"Upcoming Auctions";
    }
    else
    {
        self.navigationItem.title=@"Past Auctions";
    }
   
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    
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
-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    arrItemCount=[parese parsePastOccution:[dict1 valueForKey:@"resource"]];
    for (int i=0; i<arrItemCount.count; i++)
    {
        clsPastAuctionData *objpast=[arrItemCount objectAtIndex:i];
        if (_iIsUpcomming==1)
        {
            //if ([objpast.strAuctionId intValue]>[[[NSUserDefaults standardUserDefaults]valueForKey:@"CurrentAuctionID"] intValue])Upcoming
            if ([objpast.strStatus isEqualToString:@"Upcomming"])
            {
                [arrOccution addObject:objpast];
            }
           
        }
        else
        {
            //if ([objpast.strAuctionId intValue]<[[[NSUserDefaults standardUserDefaults]valueForKey:@"CurrentAuctionID"] intValue])
            if ([objpast.strStatus isEqualToString:@"Past"])
            
            {
                [arrOccution addObject:objpast];
            }
        }
    }
   
    //[arrOccution addObjectsFromArray:arrItemCount];
    _clvPastAuction.hidden=NO;
    [_clvPastAuction reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvPastAuction)
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
    if (collectionView1==_clvPastAuction)
    {
        if (indexPath.section==0)
        {
            return CGSizeMake(collectionView1.frame.size.width, 20);
        }
        else if (indexPath.section==2)
        {
            return CGSizeMake(collectionView1.frame.size.width, 20);
        }
        else
        {
            
            return   CGSizeMake((collectionView1.frame.size.width/2)-7,230);
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
    if (collectionView==_clvPastAuction)
    {
        if (section==0)
        {
            return 1;
        }
        else if (section==2)
        {
            return 1;
        }
        return  arrOccution.count;
    }
    else
    {
        return arrBottomMenu.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    PastAuctionCollectionViewCell *PastAuctionCell;
    UICollectionViewCell *cell1;
    
    if (collectionView==_clvPastAuction)
    {
        
        if (indexPath.section==0)
        {
            
            
            static NSString *identifier = @"blankcell";
            UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            
            cell = cell2;
            
        }
        else  if (indexPath.section==2)
        {
            
            
            static NSString *identifier = @"blankcell";
            UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            
            cell = cell2;
            
        }
        
        else
        {
            clsPastAuctionData *objPastOccution=[arrOccution objectAtIndex:indexPath.row];
            if (_iIsUpcomming==1)
            {
                
                PastAuctionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpComingAuction" forIndexPath:indexPath];
                
                //            NSString *newString = [originalString stringByReplacingOccurancesOfString:@" " withString:@"%20"];
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objPastOccution.strImage]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                PastAuctionCell.imgPastAuction.imageURL =[NSURL URLWithString:spaceUrl];
                PastAuctionCell.lblPastAuctionTitle.text=objPastOccution.strAuctiontitle;
                PastAuctionCell.lblPastAuctionDate.text= objPastOccution.strAuctiondate;
                
                PastAuctionCell.layer.borderWidth=1;
                PastAuctionCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                
                cell = PastAuctionCell;
                
                cell.layer.borderWidth=1;
                cell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                PastAuctionCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                
            }
            else
            {
                PastAuctionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastAuction" forIndexPath:indexPath];
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objPastOccution.strImage]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                PastAuctionCell.imgPastAuction.imageURL =[NSURL URLWithString:spaceUrl];
                PastAuctionCell.lblPastAuctionTitle.text=objPastOccution.strAuctiontitle;
                PastAuctionCell.lblPastAuctionDate.text= objPastOccution.strAuctiondate;
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    PastAuctionCell.lblTotlaSaleValue.text=[NSString stringWithFormat:@"$%@",objPastOccution.strTotalSaleValueUs];
                }
                else
                {
                    PastAuctionCell.lblTotlaSaleValue.text=[NSString stringWithFormat:@"₹%@",objPastOccution.strTotalSaleValueRs];
                }
                PastAuctionCell.layer.borderWidth=1;
                PastAuctionCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                
                cell = PastAuctionCell;
                
                cell.layer.borderWidth=1;
                cell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                PastAuctionCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                
            }
        }
    }
    else
    {
        static NSString *identifier = @"Cell11";
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:30];
        UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        NSLog(@"%@",[arrBottomMenu objectAtIndex:indexPath.row]);
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        if (_iIsUpcomming==1)
        {
            
            if (indexPath.row==2)
            {
                
                lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
                
                lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
                lblSelectedline.hidden=NO;
                
            }
            else
            {
                lblTitle.textColor=[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
                lblline.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
                lblSelectedline.hidden=YES;
            }
        }
        else if (_iIsUpcomming==2)
        {
            if (indexPath.row==3)
            {
                
                lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
                
                lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
                lblSelectedline.hidden=NO;
            }
            else
            {
                lblTitle.textColor=[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
                lblline.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
                lblSelectedline.hidden=YES;
            }
        }
        cell=cell1;
    }
    return cell;
}
-(NSString*)timercount:(NSString*)dateStr fromDate:(NSString*)fromdate
{
//    NSString *dateString = dateStr; //@"12-12-2015";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *dateStr_Date = [[NSDate alloc] init];
//    dateStr_Date = [dateFormatter dateFromString:dateString];
//    
//    NSString *fromdateString = fromdate; //@"12-12-2015";
//    NSDateFormatter *fromdateFormatter = [[NSDateFormatter alloc] init];
//    //    fromdateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    [fromdateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *dateFromString = [[NSDate alloc] init];
//    dateFromString = [fromdateFormatter dateFromString:fromdateString];
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSDateComponents *componentsHours = [calendar components:NSCalendarUnitHour fromDate:dateFromString];
//    NSDateComponents *componentMint = [calendar components:NSCalendarUnitMinute fromDate:dateFromString];
//    NSDateComponents *componentSec = [calendar components:NSCalendarUnitSecond fromDate:dateFromString];
//    
//    //    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *componentsDaysDiff = [calendar components:NSCalendarUnitDay
//                                                       fromDate:dateFromString
//                                                         toDate:dateStr_Date
//                                                        options:0];
//    
//    long day = (long)componentsDaysDiff.day;
//    long hours = (long)(24-componentsHours.hour);
//    long minutes = (long)(60-componentMint.minute);
//    long sec = (long)(60-componentSec.second);
//    
//    NSString *timeStr = [NSString stringWithFormat:@"%ldD %02ld:%02ld:%02ld",day,hours,minutes,sec];
//    NSDate* enddate = dateStr_Date;
//    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:dateFromString];
//    double secondsInMinute = 60;
//    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
//    
//    if (secondsBetweenDates == 0)
//        return @"";
//    else if (secondsBetweenDates < 0)
//        return @"";
//    else
//        return timeStr;
    
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
    if (collectionView==_clvBottomMenu)
    {
        if (indexPath.row==0)
        {
            
            UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
            ViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            //[navcontroll pushViewController:objViewController animated:YES];
            [navcontroll setViewControllers: @[objViewController] animated: YES];
            
            [self.revealViewController setFrontViewController:navcontroll];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        }
       else if (indexPath.row==1)
        {
            
           
                UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
                CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
                //[navcontroll pushViewController:VCLikesControll animated:YES];
                [navcontroll setViewControllers: @[VCLikesControll] animated: YES];
                
                [self.revealViewController setFrontViewController:navcontroll];
                [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            

        }
       else if (indexPath.row==2)
       {
           if (!(_iIsUpcomming==1))
           {
               _iIsUpcomming=1;
               [self setUpNavigationItem];
               [_clvBottomMenu reloadData];
               [arrOccution removeAllObjects];
               [self getOccttionData];
                _clvPastAuction.hidden=YES;
           }
         
       }
       else if (indexPath.row==3)
       {
           
           if (_iIsUpcomming==1)
           {
               _iIsUpcomming=2;
               [self setUpNavigationItem];
               [_clvBottomMenu reloadData];
               [arrOccution removeAllObjects];
               [self getOccttionData];
                _clvPastAuction.hidden=YES;
           }
       }
    }
    else
    {
        
            ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
            clsPastAuctionData *objPastAuctionData=[arrOccution objectAtIndex:indexPath.row];
            objViewController.objPast=objPastAuctionData;
            objViewController.IsUpcomming=_iIsUpcomming;
            [self.navigationController pushViewController:objViewController animated:YES];
            
            
    }
    
}

- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
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
