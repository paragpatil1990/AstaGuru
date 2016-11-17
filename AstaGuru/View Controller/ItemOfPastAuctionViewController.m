//
//  ItemOfPastAuctionViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 17/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ItemOfPastAuctionViewController.h"
#import "ClsSetting.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "DetailProductViewController.h"
#import "TopStaticCollectionViewCell.h"
#import "FilterViewController.h"
@interface ItemOfPastAuctionViewController ()<PassResepose,CurrentOccution>
{
    NSMutableArray *arrPactAuctionItem;
    int iOffset;
    BOOL isReloadDate;
}
@end

@implementation ItemOfPastAuctionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     arrPactAuctionItem=[[NSMutableArray alloc]init];
    [self GetArtistOccuctionInfo:1];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self setUpNavigationItem];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.backItem.title = @"Back";
}
-(void)setUpNavigationItem
{
    
    self.title=[NSString stringWithFormat:@"%@",_objPast.strAuctiontitle];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
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

-(void)GetArtistOccuctionInfo:(int)isCurrentOccution
{
    
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
    
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&limit=10&offset=%d&related=*&filter=online=%@",iOffset,_objPast.strAuctionId] view:self.view Post:NO];
        //[objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=artistid=%@&related=*",_objPast.strAuctionId] view:self.view Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    
    /*else if(isCurrentOccution==2)
     {
     NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
     ClsSetting *objSetting=[[ClsSetting alloc]init];
     webservice=2;
     [objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=artistid=%@",_objCurrentOccution.strartist_id] view:self.view Post:NO];
     objSetting.PassReseposeDatadelegate=self;
     }*/
    
    
    
    
}

-(void)passReseposeData:(id)arr
{
    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
   
        NSError *error;
        NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
   NSMutableArray *arrItemCount=[parese parseCurrentOccution:arr1];
    if (arrItemCount.count==10)
    {
        isReloadDate=YES;
    }
    else
    {
        isReloadDate=NO;
    }
    [arrPactAuctionItem addObjectsFromArray:arrItemCount];
    [_ClvItemOfPastAuction reloadData];
    
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
            return   CGSizeMake(collectionView1.frame.size.width,68);
        }
        else
        {
            
            return   CGSizeMake((collectionView1.frame.size.width/2)-7,266);
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
            return  arrPactAuctionItem.count;
        }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
    TopStaticCollectionViewCell *TopStaticCell;
    UICollectionViewCell *cell1;
    
        
        if (indexPath.section==0)
        {
           // static NSString *identifier = @"ImageCell";
            //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            
            TopStaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
            TopStaticCell.iSelectedIndex=0;
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                TopStaticCell.lblCurrency.text=@"USD";
            }
            else
            {
                TopStaticCell.lblCurrency.text=@"INR";
            }

            
            
            
            
            cell1 = TopStaticCell;
        }
    
        else
        {
            
            clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:indexPath.row];
            
            
            
            
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                
                /*[UIView transitionWithView:CurrentDefultGridCell.contentView
                 duration:5
                 options:UIViewAnimationOptionTransitionFlipFromLeft
                 animations:^{
                 
                 CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
                 
                 
                 } completion:nil];*/
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
                CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                CurrentSelectedGridCell.lblMedium.text=objCurrentOccution.objMediaInfo.strMediumName;
                CurrentSelectedGridCell.lblCategoryName.text= objCurrentOccution.objCategoryInfo.strCategoryName;
                CurrentSelectedGridCell.lblYear.text=objCurrentOccution.strproductdate;
                CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize] ;
                
                CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                CurrentSelectedGridCell.hidden=YES;
                CurrentSelectedGridCell.layer.borderWidth=1;
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@" Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
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
                
                
                
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                
                 if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                    
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpriceus intValue];
                    int priceIncreaserete=(price*10)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                    
                    
                    CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpricers intValue];
                    int priceIncreaserete=(price*10)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                    NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                    NSArray *subStrings = [objCurrentOccution.strestamiate componentsSeparatedByString:@"-"]; //or rather @" - "
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
                
                cell1 = CurrentSelectedGridCell;
                
                
                
                
                
                
            }
            else
            {
                
                CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.objArtistInfo.strFirstName,objCurrentOccution.objArtistInfo.strLastName];
                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                
                CurrentDefultGridCell.iSelectedIndex=indexPath.row;
                
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@" Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                 CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
                
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                
                 if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpriceus intValue];
                    int priceIncreaserete=(price*10)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpricers];
                    
                    
                    CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    
                    int price =[objCurrentOccution.strpricers intValue];
                    int priceIncreaserete=(price*10)/100;
                    
                    int FinalPrice=price+priceIncreaserete;
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    CurrentDefultGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                }
                
                
                
                cell1 = CurrentDefultGridCell;
                
                
                
            }
            
            
            if(indexPath.row==arrPactAuctionItem.count-1)
            {
                if (isReloadDate==YES)
                {
                    iOffset=iOffset+10;
                    [self GetArtistOccuctionInfo:1];
                }
            }
            
            cell1.layer.borderWidth=1;
            cell1.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            
            
         
        }
        
    return cell1;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section==0 ||section==1)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 15);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (section==0 ||section==1)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 20);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:1];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [_ClvItemOfPastAuction reloadItemsAtIndexPaths: arrindexpath];
    
    //[_clvCurrentOccution reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:x section:0]];
    
}
- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrPactAuctionItem objectAtIndex:sender.tag];
    
    
    //UICollectionViewCell *cell = [_clvCurrentOccution ]
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:1];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)[_ClvItemOfPastAuction cellForItemAtIndexPath:indexPath];
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
}
-(void)addTapGestureOnProductimage:(UIImageView*)imgProduct indexpathrow:(NSInteger*)indexpathrow
{
    imgProduct.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    //[tapGesture1 setDelegate:self];
    imgProduct.tag=indexpathrow;
    [imgProduct addGestureRecognizer:tapGesture1];
    
}

- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    int indexpath=((int)tapGesture.view.tag);
    NSLog(@"ind %d",indexpath);
    [self showDetailPage:indexpath];
    
}
-(void)showDetailPage:(int)indexpath
{
    clsCurrentOccution *objCurrentOccution=[arrPactAuctionItem objectAtIndex:indexpath];
    
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.objCurrentOccution=objCurrentOccution;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
      objProductViewController.iscurrencyInDollar=1;
    }
  
    
    [self.navigationController pushViewController:objProductViewController animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnCurrencyChanged:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
        [_ClvItemOfPastAuction reloadData];
    }
    else
    {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
        [_ClvItemOfPastAuction reloadData];
    }
}
- (IBAction)btnFilter:(id)sender
{
    FilterViewController *objFilterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    
    
    [self.navigationController pushViewController:objFilterViewController animated:YES];
}

@end
