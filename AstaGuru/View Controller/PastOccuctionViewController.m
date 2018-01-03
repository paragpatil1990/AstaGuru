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
#import "TOPCollectionViewCell.h"

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

    _noRecords_Lbl.hidden = YES;
    arrOccution=[[NSMutableArray alloc]init];
    arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"AUCTION",@"UPCOMING",@"PAST", nil];
    [self getOccttionData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpNavigationItem];
    [self.clvPastAuction reloadData];
}

-(void)getOccttionData
{
    //USE LIMIT 10
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    if (_IsUpcomming == 1)
    {
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"getAuctionList?api_key=%@&filter=status=Upcomming",[ClsSetting apiKey]] view:self.view Post:NO];
    }
    else
    {
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"getAuctionList?api_key=%@&filter=status=Past",[ClsSetting apiKey]] view:self.view Post:NO];
    }
}

-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    if (_IsUpcomming == 1)
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
        if (_IsUpcomming == 1)
        {
            if ([objpast.strStatus isEqualToString:@"Upcomming"])
            {
                [arrOccution addObject:objpast];
            }
        }
        else
        {
            if ([objpast.strStatus isEqualToString:@"Past"])
            {
                [arrOccution addObject:objpast];
            }
        }
    }
    if (arrOccution.count == 0)
    {
        if (_IsUpcomming == 1)
        {
            _noRecords_Lbl.text = @"There is no Upcoming Auction. We will notify you whenever any Upcoming Auction is live.";
        }
        else
        {
            _noRecords_Lbl.text = @"There is no any past auction still yet.";
        }
        _noRecords_Lbl.hidden = NO;
        _clvPastAuction.hidden = YES;
    }
    else
    {
        _noRecords_Lbl.hidden = YES;
        _clvPastAuction.hidden=NO;
    }
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 2)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvPastAuction)
    {
        if (indexPath.section==0)
        {
            if (_IsUpcomming==1)
            {
                return CGSizeMake(collectionView1.frame.size.width, 20);
            }
            else
            {
                return CGSizeMake(collectionView1.frame.size.width, 44);
            }
        }
        else if (indexPath.section==2)
        {
            return CGSizeMake(collectionView1.frame.size.width, 20);
        }
        else
        {
            if (_IsUpcomming==1)
            {
                return   CGSizeMake((collectionView1.frame.size.width/2) - 12, 250);
            }
            else
            {
                return   CGSizeMake((collectionView1.frame.size.width/2) - 12, 260);
            }
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);        
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
    TOPCollectionViewCell *TopStaticCell;

    if (collectionView==_clvPastAuction)
    {
        
        if (indexPath.section==0)
        {
            if (_IsUpcomming==1)
            {
                static NSString *identifier = @"blankcell";
                UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                cell = cell2;
            }
            else
            {
                TopStaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    TopStaticCell.lblCurrency.text=@"USD";
                }
                else
                {
                    TopStaticCell.lblCurrency.text=@"INR";
                }
                
                cell = TopStaticCell;
            }
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
            if (_IsUpcomming == 1)
            {
                
                PastAuctionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpComingAuction" forIndexPath:indexPath];
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objPastOccution.strImage]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                PastAuctionCell.imgPastAuction.imageURL =[NSURL URLWithString:spaceUrl];
                PastAuctionCell.Title.text=objPastOccution.strAuctionname;
                PastAuctionCell.lblPastAuctionDate.text= objPastOccution.strDate;
                
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
                
                NSString *spaceUrl = [[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objPastOccution.strImage]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:20];
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];

        UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
        
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        lblSelectedline.hidden=YES;

        UIButton *btnLive = (UIButton *)[cell1 viewWithTag:23];
        btnLive.layer.cornerRadius = 4;
        btnLive.hidden = YES;
        
        if (indexPath.row == 1)
        {
            btnLive.hidden = NO;
        }
        
        if (_IsUpcomming == 1)
        {
            if (indexPath.row==2)
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
        }
        else
        {
            if (indexPath.row==3)
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
        }
        cell=cell1;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView == _clvBottomMenu)
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

           if (_IsUpcomming == 1)
           {
               //Here we on upcomming
           }
           else
           {
               //Here we going to upcomming
               _IsUpcomming = 1;
               [self setUpNavigationItem];
               [_clvBottomMenu reloadData];
               [arrOccution removeAllObjects];
               [self getOccttionData];
               _clvPastAuction.hidden=YES;
           }
       }
       else if (indexPath.row == 3)
       {
           if (_IsUpcomming == 0)
           {
               //Here we on past
           }
           else
           {
               //Here we going to past
               _IsUpcomming = 0;
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
        if (indexPath.section==0 || indexPath.section==1)
        {
            return;
        }
        
        ItemOfPastAuctionViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
        clsPastAuctionData *objPastAuctionData=[arrOccution objectAtIndex:indexPath.row];
        if ([objPastAuctionData.strupcomingCountVal  intValue] > 0)
        {
            if ([objPastAuctionData.strAuctionId intValue] != 13)
            {
                objViewController.objPast=objPastAuctionData;
                if (_IsUpcomming == 1)
                {
                    objViewController.IsUpcomming = 1;
                    objViewController.IsPast = 0;
                }
                else
                {
                    objViewController.IsUpcomming = 0;
                    objViewController.IsPast = 1;
                }
                objViewController.isSearch = NO;
                objViewController.isWorkArt = NO;
                objViewController.isMyPurchase = NO;
                [self.navigationController pushViewController:objViewController animated:YES];
            }
        }
    }
}

- (IBAction)btnCurrencyChanged:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
        [_clvPastAuction reloadData];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
        [_clvPastAuction reloadData];
    }
}


- (IBAction)btnArtistInfo:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    ArtistViewController *objArtistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//    {
//        objArtistViewController.iscurrencyInDollar=1;
//    }
//    else
//    {
//        objArtistViewController.iscurrencyInDollar=0;
//    }
    
    objArtistViewController.objCurrentOccution1 =objCurrentOccution;
    [self.navigationController pushViewController:objArtistViewController animated:YES];
}





@end
