//
//  SearchViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "SearchViewController.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "ClsSetting.h"
#import "ItemOfPastAuctionViewController.h"
#import "CurrentOccutionViewController.h"
@interface SearchViewController ()<CurrentOccution>
{
    int SearchResultCounter;
    NSMutableArray *arrOption;
    NSMutableArray * arrMyAuctionGallery;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
 
      SearchResultCounter=1;
    arrMyAuctionGallery=[[NSMutableArray alloc]init];
    arrOption=[[NSMutableArray alloc]init];
    arrOption=[[NSMutableArray alloc]initWithObjects:@"Browse Current Auctions",@"Browse Upcoming Auctions",@"View past Auction Results", nil];
    [self.searchBar setImage:[UIImage imageNamed:@"icon-search.png"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];

    // Do any additional setup after loading the view.
}

- (void)searchBarSearchButtonClicked1:(NSString *)strSearchType
{
    [_searchBar resignFirstResponder];
    // Do the search...

    
   
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"loading";
   
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    ClsSetting *objseting=[[ClsSetting alloc]init];
    NSString  *strQuery=[NSString stringWithFormat:@"%@/spSearch(%@,%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objseting UrlProcedure],[ClsSetting TrimWhiteSpaceAndNewLine:_searchBar.text],strSearchType];
    NSString *url = strQuery;
    NSLog(@"%@",url);
    //http://52.33.170.225/index.php/ser_authen/set_log
    
    NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // HUD.labelText = @"loading";
    
    [manager POST:encoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //  NSError *error=nil;
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         // NSData *data = [NSData dataWithBytes:utf16Bytes length:sizeof(utf16Bytes)];
         // NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
         // NSLog(@"str: '%@'", str);
         
         
         NSError *error;
         NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         NSLog(@"%@",responseStr);
         NSLog(@"%@",dict);
         
         
         
        
         
         
        arrMyAuctionGallery=[parese parseSortCurrentAuction:dict];
         
        
         if ([strSearchType isEqualToString:@"Past"])
         {
             if (arrMyAuctionGallery.count==0)
             {
                 [ClsSetting ValidationPromt:@"No Lots found for this artist search result in Past Auction"];
             }
             else
             {
                 [[self navigationController] setNavigationBarHidden:NO animated:NO];
             ItemOfPastAuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
             objPastOccuctionViewController.isSearch=YES;
             objPastOccuctionViewController.arrSearch=arrMyAuctionGallery;
             objPastOccuctionViewController.IsUpcomming=0;
             [self.navigationController pushViewController:objPastOccuctionViewController animated:YES];
             }
         }
         else if ([strSearchType isEqualToString:@"Upcomming"])
         {
             if (arrMyAuctionGallery.count==0)
             {
                 [ClsSetting ValidationPromt:@"No Lots found for this artist search result in Upcomming Auction"];
             }
             else
             {
                 [[self navigationController] setNavigationBarHidden:NO animated:NO];
             ItemOfPastAuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
             objPastOccuctionViewController.isSearch=YES;
             objPastOccuctionViewController.IsUpcomming=1;
             objPastOccuctionViewController.arrSearch=arrMyAuctionGallery;
             [self.navigationController pushViewController:objPastOccuctionViewController animated:YES];
             
             }
           
         }
         else if ([strSearchType isEqualToString:@"Current"])
         {
             if (arrMyAuctionGallery.count==0)
             {
                 [ClsSetting ValidationPromt:@"No Lots found for this artist search result in Current Auction"];
             }
             else
             {
                 [[self navigationController] setNavigationBarHidden:NO animated:NO];
             CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
                 
             VCLikesControll.isSearch=YES;
             VCLikesControll.arrSearch=arrMyAuctionGallery;
             [self.navigationController pushViewController:VCLikesControll animated:YES];
             }
         }
            // [_clvSearchBaR reloadData];
             
         
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        
         //[CvSearchCollection setContentOffset:CGPointZero animated:NO];
        
         //_vwSearchPopUp.backgroundColor=[UIColor whiteColor];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              //[MBProgressHUD hideHUDForView:self.view animated:YES];
//              if ([operation.response statusCode]==404)
//              {
//                  [ClsSetting ValidationPromt:@"No Record Found"];
//                  
//              }
//              else
//              {
//                 [ClsSetting internetConnectionPromt];
//              }
              [ClsSetting ValidationPromt:error.localizedDescription];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
          }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
     [[self navigationController] setNavigationBarHidden:YES animated:YES];
    for (UIView *subView in self.searchBar.subviews){
        for (UIView *ndLeveSubView in subView.subviews){
            if ([ndLeveSubView isKindOfClass:[UITextField class]])
            {
               //UITextField *searchBarTextField = (UITextField *)ndLeveSubView;
                //searchBarTextField.layer.cornerRadius = 10;
                //searchBarTextField.layer.masksToBounds = YES;
               // [searchBarTextField.layer setBorderWidth:10.0];
               //[searchBarTextField.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor blackColor])];
                break;
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 25);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SearchResultCounter==1)
    {
        return   CGSizeMake((collectionView1.frame.size.width),40);
    }
    else
    {
    return   CGSizeMake((collectionView1.frame.size.width)/2,200);
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  arrOption.count;
}

- (IBAction)btncanclepressed:(id)sender
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell;
    
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
//    UICollectionViewCell *cell1;
    
    // if (isList==FALSE)
    // {
    
    if (SearchResultCounter==1)
    {
        
        
        static NSString *identifier = @"blankcell";
        UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
         UILabel *lblMenu = (UILabel *)[cell2 viewWithTag:21];
        lblMenu.text=[arrOption objectAtIndex:indexPath.row];
        
        cell = cell2;
        
    }
    else
    {
        clsCurrentOccution *objCurrentOccution=[arrOption objectAtIndex:indexPath.row];
        if ([objCurrentOccution.strTypeOfCell intValue]==1)
        {
            CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
            
            /*[UIView transitionWithView:CurrentDefultGridCell.contentView
             duration:5
             options:UIViewAnimationOptionTransitionFlipFromLeft
             animations:^{
             
             CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
             
             
             } completion:nil];*/
            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
            CurrentSelectedGridCell.lblProductName.text=objCurrentOccution.strtitle;
            
            CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
            CurrentSelectedGridCell.lblSize.text= objCurrentOccution.strproductsize;
            
//            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
//            NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
//            NSDate *todaydate = [dateFormat dateFromString:strToday];
            
           // NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
            //CurrentSelectedGridCell.lblCoundown.text=strCondown;
            
            
            CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
            CurrentSelectedGridCell.hidden=YES;
            CurrentSelectedGridCell.isMyAuctionGallery=1;
            CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
            CurrentSelectedGridCell.layer.borderWidth=1;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strproductid] forState:UIControlStateNormal];
            CurrentSelectedGridCell.CurrentOccutiondelegate=self;
            CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strpriceus];
                
                
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
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strpricers];
                
                
                
                CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int price =[objCurrentOccution.strpricers intValue];
                int priceIncreaserete=(price*10)/100;
                int FinalPrice=price+priceIncreaserete;
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                
                
                NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                NSArray *subStrings = [objCurrentOccution.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
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
            
            [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strproductid] forState:UIControlStateNormal];
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
            CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
            
            CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
            
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strproductid] forState:UIControlStateNormal];
            CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
            //CurrentDefultGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
            // CurrentDefultGridCell.lblCategoryName.text=objCurrentOccution.objCategoryInfo.strCategoryName;
            //CurrentDefultGridCell.lblYear.text= objCurrentOccution.strproductdate;
            
            CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
            CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
            CurrentDefultGridCell.btnDetail.tag=indexPath.row;
            CurrentDefultGridCell.btnArtist.tag=indexPath.row;
            CurrentDefultGridCell.isMyAuctionGallery=1;
//            NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
//            NSDate *todaydate = [dateFormat dateFromString:strToday];
            
           // NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
            //CurrentDefultGridCell.lblCoundown.text=strCondown;
            
            cell.layer.borderWidth=1;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",[ClsSetting TrimWhiteSpaceAndNewLine:objCurrentOccution.strReference ]] forState:UIControlStateNormal];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strpriceus];
                
                
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
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:(NSNumber*)objCurrentOccution.strpricers];
                
                
                
                CurrentDefultGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                int price =[objCurrentOccution.strpricers intValue];
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
         
         [UIView transitionWithView:CurrentDefultGridCell.contentView
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
        if (indexPath.row==0)
        {
            
            [self searchBarSearchButtonClicked1:@"Current"];
            
            
        }
        else if (indexPath.row==1)
        {
             [self searchBarSearchButtonClicked1:@"Upcomming"];
            
        }
        else if (indexPath.row==2)
        {
           [self searchBarSearchButtonClicked1:@"Past"];
            
        }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchBarSearchButtonClicked1:@"Past"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
