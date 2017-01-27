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
@interface ArtistViewController ()<PassResepose,CurrentOccution,AuctionItemBidViewControllerDelegaet>
{
    int webservice;
    int isCurrEntOccuction;
    NSMutableArray *arrOccution;
    NSMutableArray *arrshow;
    NSMutableArray *arrpastAuction;
    NSMutableArray *arrCurrentAuction;
    
    int ISMore;
    NSMutableArray *arrBottomMenu;
    int isCurrentAuctionShow;
    NSTimer *countDownTimer;

}
@end

@implementation ArtistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GetArtistOccuctionInfo:1];
    isCurrEntOccuction=1;
    _IsPast = 0;
   // http://54.169.244.245/api/v2/guru/_table/artist/1/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
  [self setUpNavigationItem];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.backItem.title = @"Back";
    countDownTimer =[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(reloadCall) userInfo:nil repeats:YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [countDownTimer invalidate];
}
-(void)reloadCall
{
    [self refreshData];
}
-(void)setUpNavigationItem
{
    
    self.title=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
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
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    webservice=1;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"artist/%@/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",_objCurrentOccution.strartist_id] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
    
}

-(void)GetArtistOccuctionInfo:(int)isCurrentOccution
{
    if (isCurrentOccution==1)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        webservice=2;
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=artistid=%@&related=*",_objCurrentOccution.strartist_id] view:self.view Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
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
    if ( webservice==1)
    {
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
    if (arr1.count>0)
    {
        
        [self GetArtistOccuctionInfo:1];
        
    }
    else
    {
        [ClsSetting ValidationPromt:@"Information not available"];
    }
        
    }
    else
    {
    
        NSError *error;
        NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        
        NSLog(@"%@",dict1);
        NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
        arrOccution=[[NSMutableArray alloc]init];
        arrItemCount=[parese parseCurrentOccution:[dict1 valueForKey:@"resource"]];
        arrCurrentAuction=[[NSMutableArray alloc]init];
        arrpastAuction=[[NSMutableArray alloc]init];
        
        for (int i=0; i<arrItemCount.count ; i++)
        {
            clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
            if ([objCurrentOccution.strOnline intValue]==[[[NSUserDefaults standardUserDefaults]valueForKey:@"CurrentAuctionID"] intValue])
            {
                [arrCurrentAuction addObject:objCurrentOccution];
            }
            else
            {
            [arrpastAuction addObject:objCurrentOccution];
            }
        }
        
        if (isCurrEntOccuction==1)
        {
            for (int i=0; i<arrOccution.count; i++)
            {
                clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                for (int j=0; j<arrCurrentAuction.count; j++)
                {
                    clsCurrentOccution *objFilterResult=[arrCurrentAuction objectAtIndex:j];
                    if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                    {
                        //                             objFilterResult.IsSwapOn=objacution.IsSwapOn;
                        objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                        
                        break;
                    }
                }
            }
            [arrOccution removeAllObjects];
            arrOccution=arrCurrentAuction;
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
                        //                             objFilterResult.IsSwapOn=objacution.IsSwapOn;
                        objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                        
                        break;
                    }
                }
            }
            [arrOccution removeAllObjects];
            arrOccution=arrpastAuction;
        }
        
        [_clvArtistInfo reloadData];
        
    }
    
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvArtistInfo)
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
    if (collectionView1==_clvArtistInfo)
    {
        if (indexPath.section==0)
        {
            return   CGSizeMake(collectionView1.frame.size.width,246);
        }
        else  if (indexPath.section==1)
        {
            
            CGSize maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-30, FLT_MAX);
            //UIFont *font = [UIFont fontWithName:@"DS-Digital" size:24];
            CGRect labelRect1 = [[ClsSetting getAttributedStringFormHtmlString:_objCurrentOccution.strArtistProfile]
                                 boundingRectWithSize:maximumLabelSize
                                 options:NSStringDrawingUsesLineFragmentOrigin
                                 
                                 attributes:@{
                                              NSFontAttributeName : [UIFont systemFontOfSize:16]
                                              }
                                 context:nil];
            
            
            
            
            UIFont *font=[UIFont systemFontOfSize:16];
            float labelRect=[ClsSetting heightOfTextForString:[ClsSetting getAttributedStringFormHtmlString:_objCurrentOccution.strArtistProfile] andFont:font maxSize:maximumLabelSize];
            int numberofline=(labelRect / font.lineHeight);
            if (numberofline>4)
            {
                if(ISMore==1)
                {
                    return   CGSizeMake(collectionView1.frame.size.width,labelRect1.size.height+65);
                }
                else
                {
                    return CGSizeMake(collectionView1.frame.size.width, (font.lineHeight *3)+65);
                }
            }
            else
            {
                return   CGSizeMake(collectionView1.frame.size.width,labelRect1.size.height+65);
            }
            
        }
        else
        {
            if (isCurrEntOccuction == 1)
            {
                return   CGSizeMake((collectionView1.frame.size.width/2)-7,340); //,266);

            }
            else{
                return   CGSizeMake((collectionView1.frame.size.width/2)-7,266); //,266);

            }
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
    
    if (collectionView==_clvArtistInfo)
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
            return  arrOccution.count;
        }
    }
    else
    {
        return arrBottomMenu.count;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    CurrentDefultGridCollectionViewCell *CurrentDefultGridCell;
    CurrentDefultGridCollectionViewCell *CurrentSelectedGridCell;
    UICollectionViewCell *cell1;
    if (collectionView==_clvArtistInfo)
    {
        
        
        if (indexPath.section==0)
        {
            static NSString *identifier = @"ImageCell";
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
            imgServices.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOccution.strArtistPicture]];
            
            cell1 = cell;
        }
        else if (indexPath.section==1)
        {
            static NSString *identifier = @"DescriptionCell";
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
          
            UILabel *lblTitle = (UILabel *)[cell viewWithTag:21];
            UIButton *btnReaMore = (UIButton *)[cell viewWithTag:81];
            
            lblTitle.text=@"";
            
            UILabel *lblDescription = (UILabel *)[cell viewWithTag:22];
            
          CGSize maximumLabelSize = CGSizeMake(collectionView.frame.size.width-30, FLT_MAX);
            UIFont *font=[UIFont systemFontOfSize:17];
            float labelRect=[ClsSetting heightOfTextForString:_objCurrentOccution.strArtistProfile andFont:font maxSize:maximumLabelSize];
            
            
            
            //CGSize size = [self sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
            int numberofline=(labelRect / font.lineHeight);
            
            
            
            if(ISMore)
            {
                lblDescription.numberOfLines = numberofline;
                [btnReaMore setTitle:@"Read Less" forState:UIControlStateNormal];
            }
            else
            {
                lblDescription.numberOfLines = 3;
                [btnReaMore setTitle:@"Read More" forState:UIControlStateNormal];
            }
            
            
           // lblDescription.text=[ClsSetting getAttributedStringFormHtmlString:_objCurrentOccution.strArtistProfile];
            
            NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
            paragraphStyles.alignment                = NSTextAlignmentJustified;    // To justified text
            paragraphStyles.firstLineHeadIndent      = 0.05;    // IMP: must have a value to make it work
            
            NSString *stringTojustify                = [ClsSetting getAttributedStringFormHtmlString:_objCurrentOccution.strArtistProfile];
            NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles};
            NSAttributedString *attributedString     = [[NSAttributedString alloc] initWithString:stringTojustify attributes:attributes];
            
            lblDescription.attributedText             = attributedString;
            
            [lblDescription sizeToFit];
            
            
            
             UIButton *btnCurrent = (UIButton *)[cell viewWithTag:31];
            
            [btnCurrent addTarget:self
                       action:@selector(btnCurrentAuctionpressed:)
             forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *btnPast = (UIButton *)[cell viewWithTag:32];
            
            [btnPast addTarget:self
                           action:@selector(btnPastPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
            UIView *viw = (UIView *)[cell viewWithTag:34];
             UIView *viw1 = (UIView *)[cell viewWithTag:33];
            
            if (isCurrEntOccuction==1)
            {
               // btnCurrent.titleLabel.textColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1];
                btnCurrent.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                btnPast.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                viw.hidden=NO;
                viw1.hidden=YES;
                
            }
            else
            {
               // btnPast.titleLabel.textColor=[UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1];
                btnPast.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                btnCurrent.titleLabel.textColor=[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                viw.hidden=YES;
                viw1.hidden=NO;
            }
            cell1 = cell;
        }
        else
        {
            
            clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexPath.row];
            
            
            
            
            if ([objCurrentOccution.strTypeOfCell intValue]==1)
            {
//                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                if (isCurrEntOccuction==1)
                {
                    
                    
                     CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected" forIndexPath:indexPath];
                    
                }
                else
                {
                    CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastSelected" forIndexPath:indexPath];
                }
                
                
                /*[UIView transitionWithView:CurrentDefultGridCell.contentView
                 duration:5
                 options:UIViewAnimationOptionTransitionFlipFromLeft
                 animations:^{
                 
                 CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
                 
                 
                 } completion:nil];*/
                CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
                CurrentSelectedGridCell.lblProductName.text= objCurrentOccution.strtitle;
                CurrentSelectedGridCell.lblMedium.text= objCurrentOccution.objMediaInfo.strMediumName;
                CurrentSelectedGridCell.lblCategoryName.text= objCurrentOccution.objCategoryInfo.strCategoryName;
                CurrentSelectedGridCell.lblYear.text= objCurrentOccution.strproductdate;
                CurrentSelectedGridCell.lblSize.text= objCurrentOccution.strproductsize;
                
//                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
//                NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
//                NSDate *todaydate = [dateFormat dateFromString:strToday];
//                NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
//                CurrentSelectedGridCell.lblCoundown.text=strCondown;
                
                NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                if ([timeStr isEqualToString:@""])
                    CurrentSelectedGridCell.lblCoundown.text=@"Auction Closed";
                else
                    CurrentSelectedGridCell.lblCoundown.text=timeStr;
                
                CurrentSelectedGridCell.lblEstimation.text=objCurrentOccution.strestamiate;
                CurrentSelectedGridCell.hidden=YES;
                CurrentSelectedGridCell.layer.borderWidth=1;
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentSelectedGridCell.btnbidNow.tag=indexPath.row;
                CurrentSelectedGridCell.btnproxy.tag=indexPath.row;
                
                CurrentSelectedGridCell.btnbidNow.hidden = YES;
                CurrentSelectedGridCell.btnproxy.hidden=YES;
                UILabel *leading_Lbl = (UILabel *)[CurrentSelectedGridCell viewWithTag:111];
                leading_Lbl.hidden = YES;

                CurrentSelectedGridCell.btnBidHistory.tag=indexPath.row;
                CurrentSelectedGridCell.btnDetail.tag=indexPath.row;
                CurrentSelectedGridCell.objCurrentOccution=objCurrentOccution;
                CurrentSelectedGridCell.CurrentOccutiondelegate=self;
                CurrentSelectedGridCell.btnGridSelectedDetail.tag = indexPath.row;
                
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
                
                if ([objCurrentOccution.strpricers intValue] > 10000000) // 10000000
                {
                    if (_iscurrencyInDollar==1)
                    {   [numberFormatter setMaximumFractionDigits:0];
                        numberFormatter.currencyCode = @"USD";
                        NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentOccution.strpriceus];
                        
                        
                        CurrentSelectedGridCell.lblCurrentBuild.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                        
                        
                        int price =[objCurrentOccution.strpriceus intValue];
                        int priceIncreaserete=(price*5)/100;
                        
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
                        int priceIncreaserete=(price*5)/100;
                        
                        int FinalPrice=price+priceIncreaserete;
                        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                        CurrentSelectedGridCell.lblNextValidBuild.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                        
                        
                        
                        NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                        NSArray *subStrings = [_objCurrentOccution.strestamiate componentsSeparatedByString:@"-"]; //or rather @" - "
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
                }
                else{
                    if (_iscurrencyInDollar==1)
                    {   [numberFormatter setMaximumFractionDigits:0];
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
                        NSArray *subStrings = [_objCurrentOccution.strestamiate componentsSeparatedByString:@"-"]; //or rather @" - "
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
                }
                cell1 = CurrentSelectedGridCell;
            }
            else
            {
                if (isCurrEntOccuction==1)
                {
                    
                
                CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentDefult" forIndexPath:indexPath];
                    
                }
                else
                {
                CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pastDefult" forIndexPath:indexPath];
                }
                CurrentDefultGridCell.btnMyGallery.tag=indexPath.row;
                CurrentDefultGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], objCurrentOccution.strthumbnail]];
                CurrentDefultGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOccution.strFirstName,_objCurrentOccution.strLastName];
                CurrentDefultGridCell.lblProductName.text= objCurrentOccution.strtitle;
                
                [self addTapGestureOnProductimage:CurrentDefultGridCell.imgProduct indexpathrow:indexPath.row];
                
                CurrentDefultGridCell.iSelectedIndex=(int)indexPath.row;
                CurrentDefultGridCell.btnDetail.tag=indexPath.row;
                CurrentDefultGridCell.objCurrentOccution=objCurrentOccution;

//                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                NSDate *Enddate = [dateFormat dateFromString:objCurrentOccution.strBidclosingtime];
//                NSString *strToday = [dateFormat  stringFromDate:[NSDate date]];
//                NSDate *todaydate = [dateFormat dateFromString:strToday];
//                NSString *strCondown=[self remaningTime:todaydate endDate:Enddate];
//                CurrentDefultGridCell.lblCoundown.text=strCondown;
                
                NSString *timeStr =[self timercount:objCurrentOccution.strBidclosingtime fromDate:objCurrentOccution.strCurrentDate];
                if ([timeStr isEqualToString:@""])
                    CurrentDefultGridCell.lblCoundown.text=@"Auction Closed";
                else
                    CurrentDefultGridCell.lblCoundown.text=timeStr;
                
                cell1.layer.borderWidth=1;
                CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
                [CurrentDefultGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",objCurrentOccution.strReference] forState:UIControlStateNormal];
                CurrentDefultGridCell.CurrentOccutiondelegate=self;
                
                [ClsSetting SetBorder:CurrentDefultGridCell.nextView cornerRadius:2 borderWidth:1];
                CurrentDefultGridCell.nextView.layer.borderColor = [UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1].CGColor;
                
                
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];
                if (_iscurrencyInDollar==1)
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
            cell1.layer.borderWidth=1;
            cell1.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            CurrentDefultGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
            
           
            
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
            //UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
            lblSelectedline.hidden=YES;
        }
        cell1=cell1;
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
-(void)btnShotinfoPressed:(int)iSelectedIndex
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iSelectedIndex inSection:2];
    NSMutableArray *arrindexpath=[[NSMutableArray alloc]initWithObjects:indexPath, nil];
    [self.clvArtistInfo reloadItemsAtIndexPaths: arrindexpath];
    
    //[_clvCurrentOccution reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:x section:0]];
    
}
- (IBAction)btnMaximizePressed:(UIButton*)sender
{
    clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
    objCurrentOccution=[arrOccution objectAtIndex:sender.tag];
    
    NSLog(@"%ld",(long)sender.tag);
    //UICollectionViewCell *cell = [_clvCurrentOccution ]
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:2];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL],objCurrentOccution.strimage]];//@"http://arttrust.southeastasia.cloudapp.azure.com/paintings/feb_auction2o.jpg"];
#endif
    CurrentDefultGridCollectionViewCell * cell = (CurrentDefultGridCollectionViewCell*)[_clvArtistInfo cellForItemAtIndexPath:indexPath];
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
    NSLog(@"ind %d",indexpath);
    [self showDetailPage:indexpath];
    
}
-(void)showDetailPage:(int)indexpath
{
    clsCurrentOccution *objCurrentOccution=[arrOccution objectAtIndex:indexpath];
    UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
    DetailProductViewController *objProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
    objProductViewController.objCurrentOccution=objCurrentOccution;
    objProductViewController.iscurrencyInDollar=_iscurrencyInDollar;
    objProductViewController.IsPast = _IsPast;
    [navcontroll pushViewController:objProductViewController animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnCurrentAuctionpressed:(UIButton*)sender
{
    isCurrEntOccuction=1;
    _IsPast = 0;
    arrOccution=arrCurrentAuction;
    [_clvArtistInfo reloadData];
}

- (IBAction)btnPastPressed:(UIButton*)sender
{
     isCurrEntOccuction=0;
    _IsPast = 1;
    arrOccution=arrpastAuction;
     [_clvArtistInfo reloadData];
}
- (IBAction)readMorePressed:(id)sender
{
    if (ISMore==0)
    {
        ISMore=1;
        
    }
    else
    {
     ISMore=0;
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
                objAuctionItemBidViewController.delegate = self;
                objAuctionItemBidViewController.objCurrentOuction=objCurrentOccution;
                objAuctionItemBidViewController.isBidNow=TRUE;
                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
                }
                objAuctionItemBidViewController.IsSort=1;
                [self addChildViewController:objAuctionItemBidViewController];
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have access to Bid. Please contact Astaguru"  preferredStyle:UIAlertControllerStyleAlert];
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
                if ([[NSUserDefaults standardUserDefaults]boolForKey: @"isUSD"]==YES)
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=1;
                }
                else
                {
                    objAuctionItemBidViewController.iscurrencyInDollar=0;
                }
                objAuctionItemBidViewController.IsSort=1;
                [self addChildViewController:objAuctionItemBidViewController];
                [self.view addSubview:objAuctionItemBidViewController.view];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:@"You don't have access to Bid. Please contact Astaguru"  preferredStyle:UIAlertControllerStyleAlert];
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
    /* NSDictionary *params = @{
     
     @"AuctionId":[[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentAuctionID"],
     @"Bidpricers":_objCurrentOuction.strpricers,
     @"Bidpriceus":_objCurrentOuction.strpriceus,
     @"Firstname":_objCurrentOuction.strFirstName,
     @"Lastname":_objCurrentOuction.strLastName,
     @"Reference":_objCurrentOuction.strReference,
     @"Thumbnail":_objCurrentOuction.strthumbnail,
     @"UserId":strUserid,
     @"Username":str,
     @"anoname":@"",
     @"currentbid":@"0",
     @"daterec":@"",
     @"earlyproxy":@"",
     @"productid":_objCurrentOuction.strproductid,
     @"proxy":@"",
     @"recentbid":@"",
     @"validbidpricers":@"",
     @"validbidpriceus":@"",
     @"Bidrecordid":@""
     
     };
     
     NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
     
     NSDictionary *pardsams = @{@"resource": arr};
     
     
     
     ClsSetting *objClssetting=[[ClsSetting alloc] init];
     // objClssetting.PassReseposeDatadelegate=self;
     objClssetting.PassReseposeDatadelegate=self;
     [objClssetting calllPostWeb:pardsams url:[NSString stringWithFormat:@"%@mygallery?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[objClssetting Url],str] view:self.view];*/
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
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spAddToGallery(%@,%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting UrlProcedure],objCurrentOccution.strproductid,strUserid];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict);
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [ClsSetting ValidationPromt:@"Item added to your auction gallery"];;
             [self myAuctionGallery];
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];

//                 if ([operation.response statusCode]==404)
//                 {
//                     [ClsSetting ValidationPromt:@"No Record Found"];
//                     
//                 }
//                 else
//                 {
//                     [ClsSetting internetConnectionPromt];
//                     
//                 }
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
    
    MyAuctionGalleryViewController *objAfterLoginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAuctionGalleryViewController"];
    [navcontroll pushViewController:objAfterLoginViewController animated:YES];
}

//// Here we refresh the view after bid submited;

-(void)refreshData
{
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    @try {
        
        //        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        //        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=artistid=%@&related=*",[objSetting Url],_objCurrentOccution.strartist_id];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
             NSLog(@"%@",dict1);
             NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
             arrOccution=[[NSMutableArray alloc]init];
             arrItemCount=[parese parseCurrentOccution:[dict1 valueForKey:@"resource"]];
             arrCurrentAuction=[[NSMutableArray alloc]init];
             arrpastAuction=[[NSMutableArray alloc]init];
             
             for (int i=0; i<arrItemCount.count ; i++)
             {
                 clsCurrentOccution *objCurrentOccution=[arrItemCount objectAtIndex:i];
                 if ([objCurrentOccution.strOnline intValue]==[[[NSUserDefaults standardUserDefaults]valueForKey:@"CurrentAuctionID"] intValue])
                 {
                     [arrCurrentAuction addObject:objCurrentOccution];
                 }
                 else
                 {
                     [arrpastAuction addObject:objCurrentOccution];
                 }
             }
             if (isCurrEntOccuction==1)
             {
                 for (int i=0; i<arrOccution.count; i++)
                 {
                     clsCurrentOccution *objacution=[arrOccution objectAtIndex:i];
                     for (int j=0; j<arrCurrentAuction.count; j++)
                     {
                         clsCurrentOccution *objFilterResult=[arrCurrentAuction objectAtIndex:j];
                         if ([objacution.strproductid intValue]==[objFilterResult.strproductid intValue])
                         {
//                             objFilterResult.IsSwapOn=objacution.IsSwapOn;
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             
                             break;
                         }
                     }
                 }
                 [arrOccution removeAllObjects];
                 arrOccution=arrCurrentAuction;
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
//                             objFilterResult.IsSwapOn=objacution.IsSwapOn;
                             objFilterResult.strTypeOfCell=objacution.strTypeOfCell;
                             
                             break;
                         }
                     }
                 }
                 [arrOccution removeAllObjects];
                 arrOccution=arrpastAuction;
             }
             [_clvArtistInfo reloadData];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
//                 [ClsSetting ValidationPromt:error.localizedDescription];
                 
                 //                 if ([operation.response statusCode]==404)
                 //                 {
                 //                     [ClsSetting ValidationPromt:@"No Record Found"];
                 //
                 //                 }
                 //                 else
                 //                 {
                 //                     [ClsSetting internetConnectionPromt];
                 //                     
                 //                 }
             }];
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}
@end
