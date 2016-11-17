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
            if ([objpast.strStatus isEqualToString:@"Upcoming"])
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
       clsPastAuctionData *objPastOccution=[arrOccution objectAtIndex:indexPath.row];
        CGSize maximumLabelSize = CGSizeMake((collectionView1.frame.size.width/2)-100, FLT_MAX);
        CGRect labelRect1 = [objPastOccution.strAuctiontitle
                             boundingRectWithSize:maximumLabelSize
                             options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName : [UIFont systemFontOfSize:14]
                                          }
                             context:nil];
        CGRect labelRect2 = [objPastOccution.strAuctiondate
                             boundingRectWithSize:maximumLabelSize
                             options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{
                                          NSFontAttributeName : [UIFont systemFontOfSize:12]
                                          }
                             context:nil];
        
                  return   CGSizeMake((collectionView1.frame.size.width/2)-7,/*180+labelRect1.size.height+labelRect2.size.height*/225);
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
            PastAuctionCell.imgPastAuction.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objPastOccution.strImage]];
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
            PastAuctionCell.imgPastAuction.imageURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objPastOccution.strImage]];
            PastAuctionCell.lblPastAuctionTitle.text=objPastOccution.strAuctiontitle;
            PastAuctionCell.lblPastAuctionDate.text= objPastOccution.strAuctiondate;
            
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
            [navcontroll pushViewController:objViewController animated:YES];
        }
       else if (indexPath.row==1)
        {
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
            {
                
                UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
                CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
                [navcontroll pushViewController:VCLikesControll animated:YES];
            }
            else
            {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
                BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
                [self.navigationController pushViewController:rootViewController animated:YES];
            }

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
        if (_iIsUpcomming!=1)
        {
            ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
            clsPastAuctionData *objPastAuctionData=[arrOccution objectAtIndex:indexPath.row];
            objViewController.objPast=objPastAuctionData;
            [self.navigationController pushViewController:objViewController animated:YES];
            
        }
    
    }
    
}






@end
