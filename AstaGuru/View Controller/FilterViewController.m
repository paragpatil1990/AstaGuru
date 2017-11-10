//
//  FilterViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 15/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "FilterViewController.h"
#import "ClsSetting.h"
#import "SectionHeaderReusableView.h"
#import "ViewController.h"
#import "SWRevealViewController.h"
#import "SWRevealViewController.h"
#import "PastOccuctionViewController.h"
#import "AppDelegate.h"
@interface FilterViewController ()<PassResepose>
{
    NSMutableArray *arrArtist;
    NSMutableArray *arrBottomMenu;
    NSMutableArray *arrFinalFilter;
}
@end

@implementation FilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.auctionName isEqualToString:@"Collectibles Auction"])
    {
        [self spGetAuctionCategory];
    }
    else
    {
        [self getArtistInfo];
    }
    
    if (!_arrselectArtist)
    {
        _arrselectArtist=[[NSMutableArray alloc]init];
    }
    
    arrArtist=[[NSMutableArray alloc]init];
    arrFinalFilter=[[NSMutableArray alloc]init];
    arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"AUCTION",@"UPCOMING",@"PAST", nil];
    [self setUpNavigationItem];
}


-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    self.title=@"Filter Artist";
    self.sidebarButton=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.sidebarButton.tintColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearArtist)];
    self.sideleftbarButton.tintColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}

-(void)clearArtist
{
    [_arrselectArtist removeAllObjects];
    for (int i=0; i<arrArtist.count; i++)
    {
        clsArtistInfo *objArtist=[arrArtist objectAtIndex:i];
        objArtist.isChecked=0;
    }
    [_clvFilter reloadData];
}

-(void)closePressed
{
    [_arrselectArtist removeAllObjects];
    [self.delegateFilter clearCancelFilter];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvFilter)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvFilter)
    {
        return CGSizeMake(collectionView1.frame.size.width, 40);
    }
    else
    {
        float width = self.view.frame.size.width/4;
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_clvFilter)
    {
        return  arrArtist.count;
    }
    else
    {
        return arrBottomMenu.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    UICollectionViewCell *cell1;
    
    if (collectionView==_clvFilter)
    {
        static NSString *identifier = @"Artist";
        UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UILabel *lblMenu = (UILabel *)[cell2 viewWithTag:31];
        UIImageView *imgSelected=(UIImageView *)[cell2 viewWithTag:32];
        
        clsArtistInfo *objclsArtistInfo = [arrArtist objectAtIndex:indexPath.row];
        
        lblMenu.text=[NSString stringWithFormat:@"%@ %@",objclsArtistInfo.strFirstName,objclsArtistInfo.strLastName];
        
        if (objclsArtistInfo.isChecked==1)
        {
            imgSelected.image=[UIImage imageNamed:@"img-radio-selected"];
        }
        else
        {
            imgSelected.image=[UIImage imageNamed:@"img-radio-default"];
        }
        cell = cell2;
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
        
        if (indexPath.row == _selectedTab)
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView==_clvFilter)
    {
        clsArtistInfo *objclsArtistInfo=[arrArtist objectAtIndex:indexPath.row];
        if (objclsArtistInfo.isChecked==0)
        {
            objclsArtistInfo.isChecked=1;
            [_arrselectArtist addObject:objclsArtistInfo];
        }
        else
        {
            objclsArtistInfo.isChecked=0;
            [_arrselectArtist removeObject:objclsArtistInfo];
        }
        NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
        [self.clvFilter reloadItemsAtIndexPaths:arrindexpath];
    }
    else
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

-(void)spGetAuctionCategory
{
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetAuctionCategory(%@,%d)?api_key=%@",[ClsSetting procedureURL],_strType,_auctionID,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             //                 NSLog(@"%@",dict1);
             NSMutableArray *arr1=[parese parseArtistInfo:dict1];
             
             if (arr1.count>0)
             {
                 [arrArtist removeAllObjects];
                 arrArtist = arr1;
                 
                 for (int i=0; i<_arrselectArtist.count; i++)
                 {
                     clsArtistInfo *objselectedArtistInfo=[_arrselectArtist objectAtIndex:i];
                     for (int j=0; j<arrArtist.count; j++)
                     {
                         clsArtistInfo *objArtistInfo=[arrArtist objectAtIndex:j];
                         if ([objselectedArtistInfo.strArtistid intValue]==[objArtistInfo.strArtistid intValue])
                         {
                             objArtistInfo.isChecked = 1;
                             break;
                         }
                     }
                 }
                 [_clvFilter reloadData];
             }
             else
             {
                 [ClsSetting ValidationPromt:@"Information not available"];
             }
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
    //    }
}


-(void)getArtistInfo
{
    if (_ispast == 1)
    {
        @try {
            
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"loading";
            NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetArtistincurrentauction(%@,%d)?api_key=%@",[ClsSetting procedureURL],_strType,_auctionID,[ClsSetting apiKey]];
            NSString *url = strQuery;
            NSLog(@"%@",url);
            
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 //  NSError *error=nil;
                 NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSError *error;
                 NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 NSLog(@"%@",responseStr);
                 NSLog(@"%@",dict1);
                 NSMutableArray *arr1=[parese parseArtistInfo:dict1];
                 
                 if (arr1.count>0)
                 {
                     [arrArtist removeAllObjects];
                     arrArtist = arr1;
                     
                     for (int i=0; i<_arrselectArtist.count; i++)
                     {
                         clsArtistInfo *objselectedArtistInfo=[_arrselectArtist objectAtIndex:i];
                         for (int j=0; j<arrArtist.count; j++)
                         {
                             clsArtistInfo *objArtistInfo=[arrArtist objectAtIndex:j];
                             if ([objselectedArtistInfo.strArtistid intValue]==[objArtistInfo.strArtistid intValue])
                             {
                                 objArtistInfo.isChecked=1;
                                 break;
                             }
                         }
                     }
                     [_clvFilter reloadData];
                 }
                 else
                 {
                     [ClsSetting ValidationPromt:@"Information not available"];
                 }
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
    else
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"artistincurrentauction?api_key=%@",[ClsSetting apiKey]] view:self.view Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
    
}

-(void)passReseposeData:(id)arr
{
    
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSMutableArray *arr1=[parese parseArtistInfo:[dict1 valueForKey:@"resource"]];
    
    if (arr1.count>0)
    {
        [arrArtist removeAllObjects];
        arrArtist = arr1;
        
        for (int i=0; i<_arrselectArtist.count; i++)
        {
            clsArtistInfo *objselectedArtistInfo=[_arrselectArtist objectAtIndex:i];
            for (int j=0; j<arrArtist.count; j++)
            {
                clsArtistInfo *objArtistInfo=[arrArtist objectAtIndex:j];
                if ([objselectedArtistInfo.strArtistid intValue]==[objArtistInfo.strArtistid intValue])
                {
                    objArtistInfo.isChecked=1;
                    break;
                }
            }
        }
    }
    else
    {
        [ClsSetting ValidationPromt:@"Information not available"];
    }
    [_clvFilter reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (IBAction)btnRefinepressed:(id)sender
{
    NSMutableArray *arrCheck=[[NSMutableArray alloc]init];
    for (int i=0; i<arrArtist.count; i++)
    {
        clsArtistInfo *objArtistInfo=[arrArtist objectAtIndex:i];
        
        if (objArtistInfo.isChecked==1)
        {
            [arrCheck addObject:objArtistInfo];
        }
    }
    [_arrselectArtist removeAllObjects];
    _arrselectArtist = arrCheck;
    
    if (_arrselectArtist.count>0)
    {
        [_delegateFilter filter:arrFinalFilter selectedArtistArray:_arrselectArtist];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [ClsSetting ValidationPromt:@"Please select refine result"];
    }
}

@end
