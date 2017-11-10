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
    NSMutableArray * arrSearchResult;
}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    SearchResultCounter = 1;
    arrSearchResult = [[NSMutableArray alloc]init];
    arrOption=[[NSMutableArray alloc] initWithObjects:@"Browse Current Auctions",@"Browse Upcoming Auctions",@"View past Auction Results", nil];
    [self.searchBar setImage:[UIImage imageNamed:@"icon-search.png"]
            forSearchBarIcon:UISearchBarIconSearch
                       state:UIControlStateNormal];
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
    
    NSArray *words = [_searchBar.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger wordCount = [words count];

    
    NSString  *strQuery=[NSString stringWithFormat:@"%@/spSearch(%@,%@,%ld)?api_key=%@",[ClsSetting procedureURL],[ClsSetting TrimWhiteSpaceAndNewLine:_searchBar.text],strSearchType, (long)wordCount,[ClsSetting apiKey]];
    NSString *url = strQuery;
    NSLog(@"%@",url);
    
    NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:encoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //  NSError *error=nil;
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         NSError *error;
         NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         NSLog(@"%@",responseStr);
         NSLog(@"%@",dict);
         
         arrSearchResult = [parese parseSortCurrentAuction:dict];
         if ([strSearchType isEqualToString:@"Past"])
         {
             if (arrSearchResult.count==0)
             {
                 [ClsSetting ValidationPromt:@"No Lots found for this artist search result in Past Auction"];
             }
             else
             {
                 [[self navigationController] setNavigationBarHidden:NO animated:NO];
                 ItemOfPastAuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
                 objPastOccuctionViewController.arrSearch = arrSearchResult;
                 objPastOccuctionViewController.IsUpcomming = 0;
                 objPastOccuctionViewController.IsPast = 1;
                 objPastOccuctionViewController.isWorkArt = NO;
                 objPastOccuctionViewController.isMyPurchase = NO;
                 objPastOccuctionViewController.isSearch = YES;
                 [self.navigationController pushViewController:objPastOccuctionViewController animated:YES];
             }
         }
         else if ([strSearchType isEqualToString:@"Upcomming"])
         {
             if (arrSearchResult.count==0)
             {
                 [ClsSetting ValidationPromt:@"No Lots found for this artist search result in Upcomming Auction"];
             }
             else
             {
                 [[self navigationController] setNavigationBarHidden:NO animated:NO];
                 ItemOfPastAuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
                 objPastOccuctionViewController.arrSearch = arrSearchResult;
                 objPastOccuctionViewController.IsUpcomming = 1;
                 objPastOccuctionViewController.IsPast = 0;
                 objPastOccuctionViewController.isWorkArt = NO;
                 objPastOccuctionViewController.isMyPurchase = NO;
                 objPastOccuctionViewController.isSearch = YES;
                 [self.navigationController pushViewController:objPastOccuctionViewController animated:YES];
             }
         }
         else if ([strSearchType isEqualToString:@"Current"])
         {
             if (arrSearchResult.count==0)
             {
                 [ClsSetting ValidationPromt:@"No Lots found for this artist search result in Current Auction"];
             }
             else
             {
                 [[self navigationController] setNavigationBarHidden:NO animated:NO];
                 CurrentOccutionViewController *objCurrentOccutionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
                 objCurrentOccutionViewController.arrSearch = arrSearchResult;
                 objCurrentOccutionViewController.searchUrl = url;
                 objCurrentOccutionViewController.isSearch=YES;
                 [self.navigationController pushViewController:objCurrentOccutionViewController animated:YES];
             }
         }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
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
        
            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
            CurrentSelectedGridCell.lblProductName.text=objCurrentOccution.strtitle;
            
            CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
            CurrentSelectedGridCell.lblSize.text= objCurrentOccution.strproductsize;
            
            
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
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
            }
            else
            {
                CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
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
            CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
            
            CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
            
            [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strproductid] forState:UIControlStateNormal];
            CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
            
            CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

            CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;
            CurrentDefultGridCell.btnDetail.tag=indexPath.row;
            CurrentDefultGridCell.btnArtist.tag=indexPath.row;
            CurrentDefultGridCell.isMyAuctionGallery=1;

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
        
        cell.layer.borderWidth=1;
        cell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        
    }
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([_searchBar.text isEqualToString:@""])
    {
        [ClsSetting ValidationPromt:@"Please enter search text"];
    }
    else
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
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchBarSearchButtonClicked1:@"Past"];
}

@end
