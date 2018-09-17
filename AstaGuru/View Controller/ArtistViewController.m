//
//  ArtistViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 18/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ArtistViewController.h"
#import "ClsSetting.h"
#import "TopStaticCollectionViewCell.h"
#import "CurrentDefultGridCollectionViewCell.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "DetailProductViewController.h"
#import "AuctionItemBidViewController.h"
#import "BforeLoginViewController.h"
#import "MyAuctionGalleryViewController.h"
#import "VerificationViewController.h"
@interface ArtistViewController ()<PassResepose,CurrentOccution>
//,AuctionItemBidViewControllerDelegate>
{
    int isCurrent;
    int ISReadMore;

    NSMutableArray *arrOccution;
    NSMutableArray *arrItemCount;
    
    NSTimer *countDownTimer;

    MBProgressHUD *HUD1;
}
@end

@implementation ArtistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    arrItemCount=[[NSMutableArray alloc]init];
    arrOccution=[[NSMutableArray alloc]init];

    [self GetArtistInfo];
    
    isCurrent = 1;
    ISReadMore = 0;
    
    [self setNavigationBarBackButton];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
    [self.clvArtistInfo reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    //self.navigationController.navigationBar.backItem.title = @"Back";
    if (countDownTimer == nil)
    {
        countDownTimer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(spGetArtistDetailData) userInfo:nil repeats:YES];
    }
}

-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
//    [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
//    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
   // [_backButton setTitle:@"Back" forState:UIControlStateNormal];
//    [[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
//    [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [countDownTimer invalidate];
    countDownTimer = nil;
}


-(void)setUpNavigationItem
{
    self.title=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution1.strFirstName,_objCurrentOccution1.strLastName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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
}

-(void)searchPressed
{
    [ClsSetting Searchpage:self.navigationController]; 
}

-(void)myastaguru
{
    [ClsSetting myAstaGuru:self.navigationController];
}

-(void)GetArtistInfo
{
    HUD1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD1.labelText = @"loading";
    [self spGetArtistDetailData];
}

//// Here we refresh the view after bid submited;

-(void)spGetArtistDetailData
{
    @try {
        
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetArtistDetailData(%@)?api_key=%@",[ClsSetting procedureURL],_objCurrentOccution1.strartist_id,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
             NSLog(@"%@",dict1);
             
             [arrItemCount removeAllObjects];
             arrItemCount = [parese parseSortCurrentAuction:dict1];
             
             NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
             NSMutableArray *arrpastAuction = [[NSMutableArray alloc]init];
             
             for (int i=0; i<arrItemCount.count ; i++)
             {
                 clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
                 
                 if ([objCurrentOccution.strStatus isEqualToString:@"Past"])
                 {
                     [arrpastAuction addObject:objCurrentOccution];
                 }
                 else
                 {
                     [arrCurrentAuction addObject:objCurrentOccution];
                 }
             }
             
             if (isCurrent == 1)
             {
                 for (int i=0; i<arrOccution.count; i++)
                 {
                     clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                     for (int j=0; j<arrCurrentAuction.count; j++)
                     {
                         clsCurrentOccution *objFilterResult = [arrCurrentAuction objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                         {
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             break;
                         }
                     }
                 }
                 [arrOccution removeAllObjects];
                 arrOccution = arrCurrentAuction;
             }
             else
             {
                 for (int i=0; i<arrOccution.count; i++)
                 {
                     clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                     for (int j=0; j<arrpastAuction.count; j++)
                     {
                         clsCurrentOccution *objFilterResult=[arrpastAuction objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                         {
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             break;
                         }
                     }
                 }
                 [arrOccution removeAllObjects];
                 arrOccution = arrpastAuction;
             }
             [_clvArtistInfo reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }];
        
        
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return   CGSizeMake(collectionView1.frame.size.width,246);
    }
    else if (indexPath.section == 1)
    {
        UIFont *font= [UIFont fontWithName:@"WorkSans-Regular" size:15];
        NSString *stringTojustify = _objCurrentOccution1.strArtistProfile;
        
//        NSMutableAttributedString * attribStr = [[NSMutableAttributedString alloc] initWithData:[stringTojustify dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

        
//        NSDictionary *dictAttrib = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
//        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
//        paragraphStyle.alignment                = NSTextAlignmentJustified;
//        
//        NSMutableAttributedString *attribStr = [[NSMutableAttributedString alloc] initWithString:stringTojustify attributes:dictAttrib];
        
//        NSMutableAttributedString *attribStr = [[NSMutableAttributedString alloc]initWithData:[stringTojustify dataUsingEncoding:NSUTF8StringEncoding] options:dictAttrib documentAttributes:nil error:nil];
        
//        [attribStr beginEditing];
//        [attribStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attribStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
//         {
//             if (value)
//             {
//                 /*----- Remove old font attribute -----*/
//                 [attribStr removeAttribute:NSFontAttributeName range:range];
//                 //replace your font with new.
//                 /*----- Add new font attribute -----*/
//                 [attribStr addAttribute:NSFontAttributeName value:font range:range];
//                 [attribStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
//                 [attribStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
//             }
//         }];
//        [attribStr endEditing];
        
        CGFloat labelHeight = [ClsSetting heightForNSString:stringTojustify havingWidth:collectionView1.frame.size.width-20 andFont:font];
//        [ClsSetting heightForNSAttributedString:attribStr havingWidth:collectionView1.frame.size.width-20];
        
        int numberofline=(labelHeight / font.lineHeight);
        
        if (numberofline > 3)
        {
            if(ISReadMore == 1)
            {
                return   CGSizeMake(collectionView1.frame.size.width,labelHeight+40);
            }
            else
            {
                return CGSizeMake(collectionView1.frame.size.width, (font.lineHeight *3)+65);
            }
        }
        else
        {
            return   CGSizeMake(collectionView1.frame.size.width,labelHeight+65);
        }
    }
    else
    {
        if (arrOccution.count == 0)
        {
            return  CGSizeMake(collectionView1.frame.size.width, 50);
        }
        else if (isCurrent == 1)
        {
            return   CGSizeMake((collectionView1.frame.size.width/2) - 12, 350);
        }
        else
        {
            return   CGSizeMake((collectionView1.frame.size.width/2)-12, 280);
        }
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 1;
    }
    else
    {
        if (arrOccution.count == 0)
        {
            return 1;
        }
        return  arrOccution.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CurrentDefultGridCollectionViewCell *defultGridCell;
    CurrentDefultGridCollectionViewCell *selectedGridCell;
    UICollectionViewCell *cell1;
    if (collectionView == _clvArtistInfo)
    {
        if (indexPath.section==0)
        {
            static NSString *identifier = @"ImageCell";
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
            imgServices.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], _objCurrentOccution1.strArtistPicture]];
            cell1 = cell;
        }
        else if (indexPath.section==1)
        {
            static NSString *identifier = @"DescriptionCell";
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            UILabel *lblTitle = (UILabel *)[cell viewWithTag:21];
            lblTitle.text=@"";
            
            UILabel *lblDescription = (UILabel *)[cell viewWithTag:22];
            
            UIButton *btnReaMore = (UIButton *)[cell viewWithTag:81];
            
            UIFont *font= [UIFont fontWithName:@"WorkSans-Regular" size:14];
            
            NSString *stringTojustify = _objCurrentOccution1.strArtistProfile;
            
            NSMutableAttributedString * attribStr = [[NSMutableAttributedString alloc] initWithData:[stringTojustify dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

            
//            NSDictionary *dictAttrib = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.alignment                = NSTextAlignmentJustified;
            
//            NSMutableAttributedString *attribStr = [[NSMutableAttributedString alloc]initWithData:[stringTojustify dataUsingEncoding:NSUTF8StringEncoding] options:dictAttrib documentAttributes:nil error:nil];
            
//            NSMutableAttributedString *attribStr = [[NSMutableAttributedString alloc] initWithString:stringTojustify attributes:dictAttrib];

            
            [attribStr beginEditing];
            [attribStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attribStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
             {
                 if (value)
                 {
                     /*----- Remove old font attribute -----*/
                     [attribStr removeAttribute:NSFontAttributeName range:range];
                     //replace your font with new.
                     /*----- Add new font attribute -----*/
                     [attribStr addAttribute:NSFontAttributeName value:font range:range];
                     [attribStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
                     [attribStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
                 }
             }];
            [attribStr endEditing];
            lblDescription.attributedText = attribStr;
            
            CGFloat labelHeight = [ClsSetting heightForNSAttributedString:attribStr havingWidth:collectionView.frame.size.width-20];
            
            int numberofline = (labelHeight / font.lineHeight);
            
            if (numberofline > 3)
            {
                btnReaMore.hidden=NO;
            }
            else
            {
                btnReaMore.hidden=YES;
            }
            
            if(ISReadMore == 1)
            {
                lblDescription.numberOfLines = numberofline;
                [btnReaMore setTitle:@"Read Less" forState:UIControlStateNormal];
            }
            else
            {
                lblDescription.numberOfLines = 3;
                [btnReaMore setTitle:@"Read More" forState:UIControlStateNormal];
            }
            
            
            UIButton *btnCurrent = (UIButton *)[cell viewWithTag:31];
            
            [btnCurrent addTarget:self
                           action:@selector(btnCurrentPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *btnPast = (UIButton *)[cell viewWithTag:32];
            
            [btnPast addTarget:self
                        action:@selector(btnPastPressed:)
              forControlEvents:UIControlEventTouchUpInside];
            
            UIView *viw = (UIView *)[cell viewWithTag:34];
            UIView *viw1 = (UIView *)[cell viewWithTag:33];
            
            if (isCurrent == 1)
            {
                btnCurrent.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                btnPast.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                viw.hidden=NO;
                viw1.hidden=YES;
            }
            else
            {
                btnPast.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                btnCurrent.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                viw.hidden=YES;
                viw1.hidden=NO;
            }
            cell1 = cell;
        }
        else
        {
            if (arrOccution.count == 0)
            {
                UICollectionViewCell *StaticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StaticCell" forIndexPath:indexPath];
                cell1 = StaticCell;
            }
            else
            {
                clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexPath.row];
                if ([objCurrentOccution.strTypeOfCell intValue]==1)
                {
                    if (isCurrent == 1)
                    {
                        selectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                    }
                    else
                    {
                        selectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastSelected" forIndexPath:indexPath];
                    }
                    
                    selectedGridCell.objCurrentOccution=objCurrentOccution;
                    selectedGridCell.CurrentOccutiondelegate=self;
                    
                    selectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                       
                    if ([objCurrentOccution.auctionType intValue] != 1)
                    {
                        UILabel *Lbl_1 = (UILabel *)[selectedGridCell viewWithTag:1];
                        Lbl_1.text = @"Title: ";
                        UILabel *Lbl_2 = (UILabel *)[selectedGridCell viewWithTag:2];
                        Lbl_2.text = @"Description: ";
                        UILabel *Lbl_3 = (UILabel *)[selectedGridCell viewWithTag:3];
                        Lbl_3.text = @"";
                        
                        selectedGridCell.lblArtistName.text=objCurrentOccution.strtitle;
                        NSString *htmlstr = [ClsSetting getAttributedStringFormHtmlString:objCurrentOccution.strPrdescription];
                        selectedGridCell.lblMedium.text = htmlstr;
                        selectedGridCell.lblYear.text = @"";
                        selectedGridCell.lblSize.text = [NSString stringWithFormat:@"%@",objCurrentOccution.strproductsize];
                        
                        selectedGridCell.lbl_sizeText.text = @"";
                        selectedGridCell.lbl_sizeText_width.constant = 0;
                    }
                    else
                    {
                        selectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                        selectedGridCell.lblMedium.text= objCurrentOccution.strmedium;
                        selectedGridCell.lblCategoryName.text=objCurrentOccution.strcategory;
                        selectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                        selectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",objCurrentOccution.strproductsize];
                    }
                    
                    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                    {
                        selectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                    }
                    else
                    {
                        selectedGridCell.lblEstimation.text=objCurrentOccution.strcollectors;
                    }
                    
                    
                    selectedGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    [ClsSetting SetBorder:selectedGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                    
                    selectedGridCell.iSelectedIndex=(int)indexPath.row;
                    
                    selectedGridCell.btnDetail.tag=indexPath.row;
                    selectedGridCell.btnGridSelectedDetail.tag = indexPath.row;
                    
                    selectedGridCell.btnbidNow.hidden = YES;
                    selectedGridCell.btnproxy.hidden=YES;
                    selectedGridCell.btnbidNow.tag =indexPath.row;
                    selectedGridCell.btnproxy.tag=indexPath.row;
                    
                    int priceUS = 0;
                    int priceRS = 0;
                    
                    NSString *strPriceUS = [NSString stringWithFormat:@"%@",objCurrentOccution.strpriceus];
                    
                    priceUS = [strPriceUS intValue];
                    
                    NSString *strPriceRS = [NSString stringWithFormat:@"%@",objCurrentOccution.strpricers];
                    
                    priceRS = [strPriceRS intValue];
                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    NSString *strCurrentBidPrice;
                    NSString *strNextValidBidPrice;
                    
                    int currentBidPrice = 0;
                    int nextValidBidPrice = 0;
                    
                    int priceIncreaseRate = 0;
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        currentBidPrice = priceUS;
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        currentBidPrice = priceRS;
                    }
                    
                    if (isCurrent == 1)
                    {
                        if (priceRS >= 10000000)
                        {
                            priceIncreaseRate = (currentBidPrice * 5)/100;
                        }
                        else
                        {
                            priceIncreaseRate = (currentBidPrice * 10)/100;
                        }
                        
                        nextValidBidPrice = currentBidPrice + priceIncreaseRate;
                        
                        strCurrentBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:currentBidPrice]];
                        
                        selectedGridCell.lblCurrentBuild.text= strCurrentBidPrice;
                        
                        strNextValidBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:nextValidBidPrice]];
                        
                        selectedGridCell.lblNextValidBuild.text = strNextValidBidPrice;
                        
//                        NSString *timeStr=[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                        if ([objCurrentOccution.strtimeRemains intValue] < 0)
                        {
                            selectedGridCell.lblCoundown.text = @"Auction Closed";
                        }
                        else
                        {
                            selectedGridCell.lblCoundown.text = objCurrentOccution.strmyBidClosingTime;
                        }
                        
                        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                        {
                            UILabel *leading_Lbl = (UILabel *)[selectedGridCell viewWithTag:111];
                            
                            if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                            {
                                selectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                                leading_Lbl.hidden = NO;
                                if ([objCurrentOccution.strtimeRemains intValue] < 0)
                                {
                                    leading_Lbl.text = @"Lot won";
                                }
                                else
                                {
                                    leading_Lbl.text = @"Your Proxy bid has been submitted successfully,you are currently leading. ";
                                }
                            }
                            else
                            {
                                selectedGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                                //                            CurrentSelectedGridCell.btnbidNow.hidden = NO;
                                //                            CurrentSelectedGridCell.btnproxy.hidden = NO;
                                leading_Lbl.hidden = YES;
                            }
                        }
                        
                    }
                    cell1 = selectedGridCell;
                }
                else
                {
                    if (isCurrent == 1)
                    {
                        defultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                    }
                    else
                    {
                        defultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pastDefult" forIndexPath:indexPath];
                    }
                    
                    defultGridCell.CurrentOccutiondelegate=self;
                    defultGridCell.objCurrentOccution = objCurrentOccution;
                    
                    defultGridCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference];
                    [ClsSetting SetBorder:defultGridCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
                    
                    defultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], objCurrentOccution.strthumbnail]];
                    
                    [self addTapGestureOnProductimage:defultGridCell.imgProduct indexpathrow:indexPath.row];
                    
                    defultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",objCurrentOccution.strFirstName,objCurrentOccution.strLastName];
                    //if ([objCurrentOccution.strAuctionname isEqualToString:@"Collectibles Auction"])
                    if ([objCurrentOccution.auctionType intValue] != 1)
                    {
                        defultGridCell.lblArtistName.text = @"";
                        defultGridCell.btnArtist.enabled = NO;
                    }
                    
                    
                    defultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                    
                    
                    defultGridCell.iSelectedIndex = (int)indexPath.row;
                    
                    defultGridCell.btnMyGallery.tag=indexPath.row;
                    defultGridCell.btnDetail.tag=indexPath.row;
                    
                    
                    
                    int priceUS = 0;
                    int priceRS = 0;
                    
                    NSString *strPriceUS = [NSString stringWithFormat:@"%@",objCurrentOccution.strpriceus];
                    
                    priceUS = [strPriceUS intValue];
                    
                    NSString *strPriceRS = [NSString stringWithFormat:@"%@",objCurrentOccution.strpricers];
                    
                    priceRS = [strPriceRS intValue];
                    
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:0];
                    
                    NSString *strCurrentBidPrice;
                    NSString *strNextValidBidPrice;
                    NSString *strWinBidPrice;
                    
                    int currentBidPrice = 0;
                    int nextValidBidPrice = 0;
                    int winBidPrice = 0;
                    
                    int priceIncreaseRate = 0;
                    
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                    {
                        numberFormatter.currencyCode = @"USD";
                        currentBidPrice = priceUS;
                    }
                    else
                    {
                        numberFormatter.currencyCode = @"INR";
                        currentBidPrice = priceRS;
                    }
                    
                    if (isCurrent == 1)
                    {
                        //Current auction cell
                        if (priceRS >= 10000000)
                        {
                            priceIncreaseRate = (currentBidPrice * 5)/100;
                        }
                        else
                        {
                            priceIncreaseRate = (currentBidPrice * 10)/100;
                        }
                        
                        nextValidBidPrice = currentBidPrice + priceIncreaseRate;
                        
                        strCurrentBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:currentBidPrice]];
                        
                        defultGridCell.lblCurrentBuild.text= strCurrentBidPrice;
                        
                        strNextValidBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:nextValidBidPrice]];
                        
                        defultGridCell.lblNextValidBuild.text = strNextValidBidPrice;
                        
//                        NSString *timeStr=[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                        if ([objCurrentOccution.strtimeRemains intValue] < 0)
                        {
                            defultGridCell.lblCoundown.text = @"Auction Closed";
                        }
                        else
                        {
                            defultGridCell.lblCoundown.text = objCurrentOccution.strmyBidClosingTime;
                        }
                        
                        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0) )
                        {
                            UILabel *leading_Lbl = (UILabel *)[defultGridCell viewWithTag:111];
                            
                            if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [objCurrentOccution.strmyuserid intValue])
                            {
                                defultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                                leading_Lbl.hidden = NO;
                                if ([objCurrentOccution.strtimeRemains intValue] < 0)
                                {
                                    leading_Lbl.text = @"Lot won";
                                }
                                else
                                {
                                    leading_Lbl.text = @"You are currently the highest bidder.";
                                }
                            }
                            else
                            {
                                defultGridCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                                leading_Lbl.hidden = YES;
                            }
                        }
                    }
                    else
                    {
                        // Past auction cell
                        if ([objCurrentOccution.strpricelow  intValue] > priceRS )
                        {
                            defultGridCell.lblNextValidBuild.text = @"Bought In";
                            defultGridCell.pastStatictext.text = @"";
                        }
                        else
                        {
                            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
                            {
                                priceIncreaseRate = (priceUS * 15)/100;
                                winBidPrice = priceUS + priceIncreaseRate;
                            }
                            else
                            {
                                priceIncreaseRate = (priceRS * 15)/100;
                                winBidPrice = priceRS + priceIncreaseRate;
                            }
                            strWinBidPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:winBidPrice]];
                            defultGridCell.lblNextValidBuild.text = strWinBidPrice;
                            defultGridCell.pastStatictext.text = @"Inclusive of 15% Margin";
                        }
                    }
                    cell1 = defultGridCell;
                }
                [ClsSetting SetBorder:cell1 cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
            }
        }
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(NSString*)timercount:(NSString*)dateStr fromDate:(NSString*)fromdate
{
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

}*/


-(void)btnShotinfoPressed:(int)iSelectedIndex
{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:2];
//    NSMutableArray *arrindexpath=[[NSMutableArray alloc] initWithObjects:indexPath, nil];
    
    [self.clvArtistInfo performBatchUpdates:^{
        [self.clvArtistInfo reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:iSelectedIndex inSection:2]]];
    } completion:^(BOOL finished) {}];
    
//    [self.clvArtistInfo reloadItemsAtIndexPaths: @[indexPath]];
}

- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution = [arrOccution objectAtIndex:sender.tag];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:2];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL],objCurrentOccution.strimage]];
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)[_clvArtistInfo cellForItemAtIndexPath:indexPath];
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
}


-(void)addTapGestureOnProductimage:(UIImageView*)imgProduct indexpathrow:(NSInteger)indexpathrow
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
    [self showDetailPage:indexpath];
    
}

-(void)showDetailPage:(int)indexpath
{
    clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexpath];
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.objCurrentOccution = objCurrentOccution;
//    objProductViewController.iscurrencyInDollar = _iscurrencyInDollar;

    if (isCurrent == 1)
    {
        objProductViewController.IsCurrent = 1;
        objProductViewController.IsPast = 0;
    }
    else
    {
        objProductViewController.IsPast = 1;
        objProductViewController.IsCurrent = 0;
    }
    objProductViewController.IsUpcomming = 0;
    objProductViewController.IsArtwork = 0;
    [self.navigationController pushViewController:objProductViewController animated:YES];
}

- (IBAction)btnCurrentPressed:(UIButton*)sender
{
    isCurrent = 1;
    
    NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
    NSMutableArray *arrpastAuction = [[NSMutableArray alloc]init];
    
    for (int i=0; i<arrItemCount.count ; i++)
    {
        clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
        
        if ([objCurrentOccution.strStatus isEqualToString:@"Past"])
        {
            [arrpastAuction addObject:objCurrentOccution];
        }
        else
        {
            [arrCurrentAuction addObject:objCurrentOccution];
            
        }
    }
    
    for (int i=0; i<arrOccution.count; i++)
    {
        clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
        for (int j=0; j<arrCurrentAuction.count; j++)
        {
            clsCurrentOccution *objFilterResult = [arrCurrentAuction objectAtIndex:j];
            if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
            {
                objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                break;
            }
        }
    }
    [arrOccution removeAllObjects];
    arrOccution = arrCurrentAuction;
    [_clvArtistInfo reloadData];
}

- (IBAction)btnPastPressed:(UIButton*)sender
{
    isCurrent = 0;
    
    NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
    NSMutableArray *arrpastAuction = [[NSMutableArray alloc]init];
    
    for (int i=0; i<arrItemCount.count ; i++)
    {
        clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
        
        if ([objCurrentOccution.strStatus isEqualToString:@"Past"])
        {
            [arrpastAuction addObject:objCurrentOccution];
        }
        else
        {
            [arrCurrentAuction addObject:objCurrentOccution];
        }
    }
    
    for (int i=0; i<arrOccution.count; i++)
    {
        clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
        for (int j=0; j<arrpastAuction.count; j++)
        {
            clsCurrentOccution *objFilterResult=[arrpastAuction objectAtIndex:j];
            if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
            {
                //                             objFilterResult.IsSwapOn=objacution.IsSwapOn;
                objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                
                break;
            }
        }
    }
    [arrOccution removeAllObjects];
    arrOccution = arrpastAuction;
    [_clvArtistInfo reloadData];
}

- (IBAction)readMorePressed:(id)sender
{
    if (ISReadMore == 0)
    {
        ISReadMore = 1;
    }
    else
    {
        ISReadMore = 0;
    }
    [_clvArtistInfo reloadData];
}

- (IBAction)btnBidNowPressed:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
                objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
//                objAuctionItemBidViewController.delegate = self;
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=TRUE;
//                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=0;
//                }
//                objAuctionItemBidViewController.IsSort=1;
                [self addChildViewController:objAuctionItemBidViewController];
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have Bidding Access. Please contact Astaguru."  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            [ClsSetting ValidationPromt:@"Your are not Verified"];
            
            NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
            VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
            rootViewController.dict=dict;
            rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
            rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
            rootViewController.strname=dict[@"t_firstname"];
            rootViewController.strSMSCode=strSMSCode;
            rootViewController.strEmialCode=strEmailCode;
            rootViewController.isRegistration = NO;
            rootViewController.IsCommingFromLoging = 0;
            [self.navigationController pushViewController:rootViewController animated:YES];
            
        }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
    
}
- (IBAction)btnProxyBid:(UIButton*)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"EmailVerified"] intValue] == 1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"MobileVerified"] intValue] == 1)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"confirmbid"] intValue] == 1)
            {
                clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
                objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
                AuctionItemBidViewController *objAuctionItemBidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionItemBidViewController"];
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=FALSE;
//                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=1;
//                }
//                else
//                {
//                    objAuctionItemBidViewController.iscurrencyInDollar=0;
//                }
//                objAuctionItemBidViewController.IsSort=1;
                [self addChildViewController:objAuctionItemBidViewController];
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have Bidding Access. Please contact Astaguru."  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            [ClsSetting ValidationPromt:@"Your are not Verified"];
            
            NSString *strSMSCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSString *strEmailCode = [NSString stringWithFormat:@"%d",arc4random() % 9000 + 1000];
            NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
            VerificationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VerificationViewController"];
            rootViewController.dict=dict;
            rootViewController.strEmail=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"email"]];
            rootViewController.strMobile=[ClsSetting TrimWhiteSpaceAndNewLine:dict[@"Mobile"]];
            rootViewController.strname=dict[@"t_firstname"];
            rootViewController.strSMSCode=strSMSCode;
            rootViewController.strEmialCode=strEmailCode;
            rootViewController.isRegistration = NO;
            rootViewController.IsCommingFromLoging = 0;
            [self.navigationController pushViewController:rootViewController animated:YES];
            
        }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
}

- (IBAction)detailpageClicked:(UIButton*)sender
{
    int indexpath=((int)sender.tag);
    [self showDetailPage:indexpath];
}

- (IBAction)AddToMyAuction:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    NSString *str;
    NSString *strUserid;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
    {
        str=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    }
    else
    {
        str=@"abhi123";
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_id] != nil)
    {
        strUserid=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    }
    else
    {
        strUserid=@"1972";
    }
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spAddToGallery(%@,%@)?api_key=%@",[ClsSetting procedureURL],objCurrentOccution.strproductid,strUserid,[ClsSetting apiKey]];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"%@",responseStr);

//             NSError *error;
//             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
//             NSLog(@"%@",dict);
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [ClsSetting ValidationPromt:@"The Lot has been added to your auction gallery."];;
             [self myAuctionGallery];
             
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

-(void)myAuctionGallery
{
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    MyAuctionGalleryViewController *objMyAuctionGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    objMyAuctionGalleryViewController.isCurrent = isCurrent;
    [navcontroll pushViewController:objMyAuctionGalleryViewController animated:YES];
}
@end
