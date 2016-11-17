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
@interface BidHistoryViewController ()<PassResepose>
{
    NSMutableArray *arrBidHistoryData;
    NSMutableArray *arrBottomMenu;
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
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
}
-(void)getOccttionData
{
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"bidrecord?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=productid=%@",_objCurrentOuction.strproductid] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
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
            return   CGSizeMake(collectionView1.frame.size.width,260);
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
                   NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    
                    
                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[_objCurrentOuction.strpriceus intValue];
                        int priceIncreaserete=(price*10)/100;
                        int FinalPrice=price+priceIncreaserete;
                        
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
                        
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        int price =[_objCurrentOuction.strpricers intValue];
                        int priceIncreaserete=(price*10)/100;
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        
                    }
                    
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
                     CurrentSelectedGridCell.btnGridSelectedDetail.tag=indexPath.row;
                    CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
                    CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.strmedium;
                    CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.strcategory;
                    CurrentSelectedGridCell.lblYear.text= _objCurrentOuction.strproductdate;
                    CurrentSelectedGridCell.lblSize.text= [NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
            CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOuction.strthumbnail]];
            
            
                    
            
                    CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
                    
                    
            
                    
                    [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@" Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
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
            lblUsername.text=[NSString stringWithFormat:@"%@",objMyOuctionGallery.strUsername];
            
            numberFormatter.currencyCode = @"INR";
            UILabel *lblBidpricers = (UILabel *)[BidCell viewWithTag:13];
            NSString *strBidpricers = [numberFormatter stringFromNumber:(NSNumber*)objMyOuctionGallery.strBidpricers];
            lblBidpricers.text=[NSString stringWithFormat:@"%@",strBidpricers];
            
            NSNumberFormatter *numberFormatter1 = [[NSNumberFormatter alloc] init] ;
            [numberFormatter1 setNumberStyle: NSNumberFormatterCurrencyStyle];
            [numberFormatter1 setMaximumFractionDigits:0];
            numberFormatter1.currencyCode = @"USD";
          
            UILabel *lblBidpriceus = (UILabel *)[BidCell viewWithTag:14];
            NSString *strBidPriceCurrency = [numberFormatter1 stringFromNumber:(NSNumber*)objMyOuctionGallery.strBidpriceus];
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
            UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
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
    AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
    objAuctionItemBidViewController.objCurrentOuction=_objCurrentOuction;
    objAuctionItemBidViewController.isBidNow=1;
    [self addChildViewController:objAuctionItemBidViewController];
    
    
    
    
    [self.view addSubview:objAuctionItemBidViewController.view];
}

- (IBAction)btnProxyBidpressed:(id)sender
{
    
    
    AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
    objAuctionItemBidViewController.objCurrentOuction=_objCurrentOuction;
    objAuctionItemBidViewController.isBidNow=FALSE;
    
    objAuctionItemBidViewController.isBidNow=0;
    
    
    [self addChildViewController:objAuctionItemBidViewController];
    [self.view addSubview:objAuctionItemBidViewController.view];
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
