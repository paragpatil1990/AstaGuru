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
    NSMutableArray *arrMenu;
    NSMutableArray *arrCategory;
    NSMutableArray *arrArtist;
    NSMutableArray *arrBottomMenu;
    
    NSMutableArray *arrFinalFilter;
    
    int CurrentPage;
    
}
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CurrentPage=1;
     [self GetArtistInfo];
    
    if (!_arrselectArtist) { _arrselectArtist=[[NSMutableArray alloc]init]; }
    
    arrFinalFilter=[[NSMutableArray alloc]init];
    arrMenu=[[NSMutableArray alloc]initWithObjects:@"Artist",@"Category",nil];
     arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"CURRENT",@"UPCOMING",@"PAST", nil];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
-(void)getCurrentAuction
{
     CurrentPage=3;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"lotslatest?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;

}
-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
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
    for (int i=0; i<arrArtist.count; i++)
    {
        clsArtistInfo *objArtist=[arrArtist objectAtIndex:i];
        objArtist.isChecked=0;
    }
    [_clvFilter reloadData];
}

-(void)closePressed
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvFilter)
    {
        //CurrentPage=1;
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
        float width=(self.view.frame.size.width/4);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView==_clvFilter)
    {
        /*if (CurrentPage==0)
        {
        return  arrMenu.count;
        }
        else if (CurrentPage==1)
        {*/
        return  arrArtist.count;
        /*}
        else
        {
        return  arrCategory.count;
        }*/
        
        
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
        
        /*if (CurrentPage==0)
        {
            static NSString *identifier = @"Menu";
            UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            UILabel *lblMenu = (UILabel *)[cell2 viewWithTag:21];
            lblMenu.text=[arrMenu objectAtIndex:indexPath.row];
            
            cell = cell2;
        }
        else
        {*/
            static NSString *identifier = @"Artist";
            UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            UILabel *lblMenu = (UILabel *)[cell2 viewWithTag:31];
            UIImageView *imgSelected=(UIImageView *)[cell2 viewWithTag:32];
           // if (CurrentPage==1)
            //{
                clsArtistInfo *objclsArtistInfo=[arrArtist objectAtIndex:indexPath.row];
                
                lblMenu.text=[NSString stringWithFormat:@"%@ %@",objclsArtistInfo.strFirstName,objclsArtistInfo.strLastName];
                if (objclsArtistInfo.isChecked==1)
                {
                    imgSelected.image=[UIImage imageNamed:@"img-radio-selected"];
                }
                else
                {
                    imgSelected.image=[UIImage imageNamed:@"img-radio-default"];
                }
   
            /*}
            else
            {
                clsCategory *objCategory=[arrCategory objectAtIndex:indexPath.row];
                
                lblMenu.text=[NSString stringWithFormat:@"%@",objCategory.strCategoryName];
                if (objCategory.isChecked==1)
                {
                 imgSelected.image=[UIImage imageNamed:@"img-radio-selected"];
                }
                else
                {
                imgSelected.image=[UIImage imageNamed:@"img-radio-default"];
                }
            }*/
            
            cell = cell2;
        //}
    }
    else
    {
        static NSString *identifier = @"Cell11";
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:30];
//        UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        NSLog(@"%@",[arrBottomMenu objectAtIndex:indexPath.row]);
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        
        if (indexPath.row==_selectedTab)
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView==_clvFilter)
    {
        if (CurrentPage==0)
        {
           
        
        if (indexPath.row==0)
        {
            /* CurrentPage=1;
            if (arrArtist.count==0)
            {
                [self GetArtistInfo];
            }
            else
            {
                [_clvFilter reloadData];
            }*/
          
        }
        else if (indexPath.row==1)
        {
            CurrentPage=2;
            if (arrCategory.count==0)
            {
                [self getCategoryData];
            }
            else
            {
                [_clvFilter reloadData];
            }
         
        }
        }
        else
        {
           // if (CurrentPage==1)
            //{
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
            /*}
            else if (CurrentPage==2)
            {
                clsCategory *objclsArtistInfo=[arrCategory objectAtIndex:indexPath.row];
                if (objclsArtistInfo.isChecked==0)
                {
                    objclsArtistInfo.isChecked=1;
                }
                else
                {
                    objclsArtistInfo.isChecked=0;
                }
                
            }*/
           
             NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
            [self.clvFilter reloadItemsAtIndexPaths:arrindexpath];
            
        }
    }
    else
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

-(void)GetArtistInfo
{
    CurrentPage=1;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    if (_ispast==1)
    {
        
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
            ClsSetting *objsetting=[[ClsSetting alloc]init];
            
            //NSArray *imgNameArr = [_objCurrentOuction.strthumbnail componentsSeparatedByString:@"/"];
          //  NSString *imgName = [imgNameArr objectAtIndex:1];
            NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetArtistincurrentauction(%@,%d)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting UrlProcedure],_strType,_Auctionid];
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
                     arrArtist=[[NSMutableArray alloc]init];
                     [arrArtist addObjectsFromArray:arr1];
                     
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

//                     [MBProgressHUD hideHUDForView:self.view animated:YES];
//                     if ([operation.response statusCode]==404)
//                     {
//                         [ClsSetting ValidationPromt:@"No Record Found"];
//                     }
//                     else
//                     {
//                         [ClsSetting internetConnectionPromt];
//                     }
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
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"artistincurrentauction?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
    }
    
}
-(void)getCategoryData
{
     NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"category?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    
}

-(void)passReseposeData:(id)arr
{
    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
    if ( CurrentPage==1)
    {
        NSError *error;
        NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        
        arrArtist=[[NSMutableArray alloc]init];
        NSMutableArray *arr1=[parese parseArtistInfo:[dict1 valueForKey:@"resource"]];
        
        if (arr1.count>0)
        {
            [arrArtist addObjectsFromArray:arr1];
            
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
        
        if (_ispast==1)
        {
            
        }
        else
        {
        [self getCurrentAuction];
        }
    }
    if ( CurrentPage==3)
    {
        
        NSError *error;
        NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        
        NSLog(@"%@",dict1);
        _arrFilter=[[NSMutableArray alloc]init];
       _arrFilter=[parese parseSortCurrentAuction:[dict1 valueForKey:@"resource"]];;
        [_clvFilter reloadData];
    }
    else
    {
        
        NSError *error;
        NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        
        NSLog(@"%@",dict1);
        NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
        arrCategory=[[NSMutableArray alloc]init];
        arrItemCount=[parese parseCategory:[dict1 valueForKey:@"resource"]];
        
        
        if (arrItemCount.count>0)
        {
        [arrCategory addObjectsFromArray:arrItemCount];
        }
        
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    
    if (collectionView==_clvFilter)
    {
     if (kind == UICollectionElementKindSectionHeader)
    {
        SectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (CurrentPage==1)
        {
            headerView.title.hidden=NO;
                headerView.title.text =@"Artists";
           
        }
        if (CurrentPage==2)
        {
            headerView.title.hidden=NO;
            headerView.title.text =@"Categories";
            
        }
        if (CurrentPage==0)
        {
            headerView.title.hidden=YES;
           
            
        }
       
        
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    }
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView==_clvFilter)
    {
    if (CurrentPage==1)
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40);
        
    }
   else if (CurrentPage==2)
    {
         return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40);
        
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 0);
        
    }
  }
    else
    {
         return CGSizeZero;
    }
}
- (IBAction)btnBackPressed:(id)sender
{
    CurrentPage=0;
    [_clvFilter reloadData];
    
}
-(void)setButton:(NSString *)strKey strValue:(NSString*)strvalue ArrFormFilter:(NSMutableArray*)ArrFormFilter BtnName:(UIButton*)btnName strValueKey:(NSString*)strValueKey
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(id == %@)",strvalue];
    NSArray *arrslectedbreed = [ArrFormFilter filteredArrayUsingPredicate:predicate];
    if (arrslectedbreed.count>0)
    {
        NSDictionary *dictSelectedState=[arrslectedbreed objectAtIndex:0];
        //btnState.titleLabel.text=[dictSelectedState valueForKey:@"st_name"];
        [btnName setTitle: [dictSelectedState valueForKey:strValueKey] forState:UIControlStateNormal];
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
//    if (arrCheck.count>0)
//    {
        [_arrselectArtist removeAllObjects];
        _arrselectArtist=arrCheck;
//    }
    if (_arrselectArtist.count>0)
    {
    NSLog(@"%@",arrFinalFilter);
    
    AppDelegate * objAppDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    objAppDelegate.isfilterStart=0;
    [_DelegateFilter filter:arrFinalFilter SelectedArtistArray:_arrselectArtist];
    [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [ClsSetting ValidationPromt:@"Please select refine result"];
    }
}

@end
