//
//  BidHistoryViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 13/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "BidHistoryViewController.h"
#import "BidNowViewController.h"
#import "CurrentProxyBidViewController.h"

#define FONT [UIFont fontWithName:@"WorkSans-Regular" size:14]

@interface BidHistoryViewController ()<BidNowViewControllerDelegate, ProxyBidViewControllerDelegate>
{
    NSArray *arrBidHistoryData;
    NSTimer *timer;
}

@end

@implementation BidHistoryViewController

-(void)setUpNavigationItem
{
    self.title=@"Bid History";
    [self setNavigationBarBackButton];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    [self spGetBidByLatest];
    timer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(getBidPrice) userInfo:nil repeats:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [timer invalidate];
    timer = nil;
}

//// Here we refresh the view after bid submited;

-(void)getBidPrice
{
    [self getAuctionByID:self.currentAuction view:nil auction:^(CurrentAuction *currentAuction){
        self.currentAuction = currentAuction;
        [self.clvBidHistory reloadData];
    }];
}

-(void)spGetBidByLatest
{
    NSString  *strUrl = [NSString stringWithFormat:@"spGetBidByLatest(%@)", self.currentAuction.strproductid];
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         NSMutableArray *auctionArray = (NSMutableArray*)responseObject;
         if (auctionArray.count > 0)
         {
             NSArray *parseArray = [CurrentAuction parseAuction:auctionArray auctionType:AuctionTypeCurrent];
             
             arrBidHistoryData = parseArray;
             
//             if (self.myPurchaseArray.count == 0)
//             {
//                 self.clvMyPurchase.hidden = YES;
//                 _noRecords_Lbl.hidden = NO;
//                 _noRecords_Lbl.text = @"There is no any past auction still yet.";
//             }
//             else
//             {
//                 self.clvMyPurchase.hidden = NO;
//                 _noRecords_Lbl.hidden = YES;
//             }
             
             [self.clvBidHistory reloadData];
         }
     } failure:^(NSError *error){
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_clvBidHistory)
    {
        return 3;
        
    }
    else
    {
        return 1;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.clvBidHistory)
    {
        if (indexPath.section==0)
        {
            //fixedH = T8+lot20+lotB5+ArtH+ArtB5+MediH+MediB5+YearH+YearB5+SizeH+SizeB5+EstH+EstB5+CurrentTextH17+CurrentTextB2+CurrentTextH17+CurrentTextB5+NextTextH17+NextTextB2+NexttTextH17+NexttTextB5+LeadingTextH32+LeadingTextB8+LineVH1+LineVB5
            CGFloat fixedH = 8+20+5+5+5+5+5+5+17+2+17+5+17+2+17+5+17+5+32+8+1+5;
            
            //fixedW = L8+img100+imgB8+widthoftext+T5
            CGFloat fixedW = 8+100+8+5;
            
            if ([self.currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
            {
                CGSize textSizeT = [@"Title:" sizeWithAttributes:@{NSFontAttributeName:FONT}];
                CGFloat wT = fixedW+textSizeT.width;
                CGFloat tw = collectionView.frame.size.width - wT;
                CGFloat th = [GlobalClass heightForNSString:self.currentAuction.strtitle havingWidth:tw font:FONT];
                [GlobalClass heightForNSString:self.currentAuction.strtitle havingWidth:tw font:FONT];
                fixedH = fixedH + th;
                
                CGSize textSizeD = [@"Description:" sizeWithAttributes:@{NSFontAttributeName:FONT}];
                CGFloat wD = fixedW+textSizeD.width;
                CGFloat dw = collectionView.frame.size.width - wD;
                CGFloat dh = [GlobalClass heightForNSString:self.currentAuction.strPrdescription havingWidth:dw font:FONT];
                fixedH = fixedH + dh;

            }
            else
            {
                CGSize textSizeA = [@"Artist:" sizeWithAttributes:@{NSFontAttributeName:FONT}];
                CGFloat wA = fixedW+textSizeA.width;
                CGFloat aw = collectionView.frame.size.width - wA;
                NSString *an = [NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName, self.currentAuction.strLastName];
                CGFloat ah = [GlobalClass heightForNSString:an havingWidth:aw font:FONT];
                fixedH = fixedH + ah;

                CGSize textSizeM = [@"Medium:" sizeWithAttributes:@{NSFontAttributeName:FONT}];
                CGFloat wM = fixedW+textSizeM.width;
                CGFloat mw = collectionView.frame.size.width - wM;
                CGFloat mh = [GlobalClass heightForNSString:self.currentAuction.strmedium havingWidth:mw font:FONT];
                fixedH = fixedH + mh;

                CGSize textSizeY = [@"Medium:" sizeWithAttributes:@{NSFontAttributeName:FONT}];
                CGFloat wY = fixedW+textSizeY.width;
                CGFloat yw = collectionView.frame.size.width - wY;
                CGFloat yh = [GlobalClass heightForNSString:self.currentAuction.strproductdate havingWidth:yw font:FONT];
                fixedH = fixedH + yh;

            }
            
            CGSize textSizeS = [@"Size:" sizeWithAttributes:@{NSFontAttributeName:FONT}];
            CGFloat wS = fixedW+textSizeS.width;
            CGFloat sw = collectionView.frame.size.width - wS;
            CGFloat sh = [GlobalClass heightForNSString:self.currentAuction.strproductsize havingWidth:sw font:FONT];
            fixedH = fixedH + sh;
            return   CGSizeMake(collectionView.frame.size.width,fixedH+10);
        }
       else if (indexPath.section == 1)
        {
            return   CGSizeMake(collectionView.frame.size.width,75);
        }
        else
        {
            CGFloat wPading = 5+2+2+2+5;
            CGFloat hPading = 5+5;

            CGFloat maxWidth = collectionView.frame.size.width - wPading;
            CGFloat maxLableWidth = maxWidth/4;

            CurrentAuction *objCurrentAuction = [arrBidHistoryData objectAtIndex:indexPath.row];
            CGFloat lableUserNameHeight = [GlobalClass heightForNSString:objCurrentAuction.strUsername havingWidth:maxLableWidth font:FONT];

            CGFloat lablePriceRSHeight = [GlobalClass heightForNSString:objCurrentAuction.formatedCurrentBidPriceRS havingWidth:maxLableWidth font:FONT];
            
            CGFloat lablePriceUSHeight = [GlobalClass heightForNSString:objCurrentAuction.formatedCurrentBidPriceUS havingWidth:maxLableWidth font:FONT];

            CGFloat labelDateHeight = [GlobalClass heightForNSString:objCurrentAuction.strdaterec havingWidth:maxLableWidth font:FONT];
         
            CGFloat maxHeight = MAX(MAX(MAX(lableUserNameHeight, lablePriceRSHeight),  lablePriceUSHeight), labelDateHeight);
            CGFloat height = maxHeight + hPading;
            return   CGSizeMake(collectionView.frame.size.width,height);
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        return CGSizeMake(width, collectionView.frame.size.height);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _clvBidHistory)
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
        return [self arrBottomMenu].count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
   
    if (collectionView==_clvBidHistory)
    {
        if (indexPath.section==0)
        {
            CurrentAuctionCollectionViewCell *defaultCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DefaultGridCell" forIndexPath:indexPath];
            
            defaultCell.currentAuction = self.currentAuction;
            defaultCell.cellClv = self.clvBidHistory;
            defaultCell.cellIndexPath = indexPath;
            defaultCell.delegate = self;

            defaultCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], self.currentAuction.strthumbnail]];
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
            {
                defaultCell.lblCurrentBid.text = self.currentAuction.formatedCurrentBidPriceUS;
                defaultCell.lblNextValidBid.text = self.currentAuction.formatedNextValidBidPriceUS;
                defaultCell.lblEstimate.text = self.currentAuction.strestamiate;
            }
            else
            {
                defaultCell.lblCurrentBid.text = self.currentAuction.formatedCurrentBidPriceRS;
                defaultCell.lblNextValidBid.text = self.currentAuction.formatedNextValidBidPriceRS;
                defaultCell.lblEstimate.text = self.currentAuction.strcollectors;
            }
            
            defaultCell.lblLot.text = [NSString stringWithFormat:@"Lot:%@",self.currentAuction.strreference];
            
            [GlobalClass setBorder:defaultCell.lblLot cornerRadius:8 borderWidth:1 color:[UIColor clearColor]];
            
            if ([self.currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
            {
                defaultCell.lblArtistText.text = @"Title:";
                defaultCell.lblArtistName.text = self.currentAuction.strtitle;
                defaultCell.lblMediumText.text = @"Description";
                defaultCell.lblMedium.text= [GlobalClass convertHTMLTextToPlainText:self.currentAuction.strPrdescription];;
                defaultCell.lblYearText.text = @"";
                defaultCell.lblYear.text = @"";
            }
            else
            {
                defaultCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName, self.currentAuction.strLastName];
                defaultCell.lblMedium.text = self.currentAuction.strmedium;
                defaultCell.lblYear.text = self.currentAuction.strproductdate;
            }
            
            defaultCell.lblSize.text = [NSString stringWithFormat:@"%@ in",self.currentAuction.strproductsize];
            
            if ([GlobalClass isAuctionClosed:self.currentAuction.strtimeRemains])
            {
                defaultCell.lblCountdown.text = @"Auction Closed";
                
                defaultCell.btnBidNow.enabled = NO;
                defaultCell.btnProxy.enabled = NO;
                
                defaultCell.btnBidNow.backgroundColor = [UIColor grayColor];
                defaultCell.btnProxy.backgroundColor = [UIColor grayColor];
            }
            else
            {
                defaultCell.lblCountdown.text = self.currentAuction.strmyBidClosingTime;
                
                defaultCell.btnBidNow.enabled = YES;
                defaultCell.btnProxy.enabled = YES;
                
                defaultCell.btnBidNow.backgroundColor = [UIColor blackColor];
                defaultCell.btnProxy.backgroundColor = [UIColor blackColor];
            }
            
            if ([GlobalClass isUserLeadingOnLot:[self.currentAuction.strmyuserid intValue]])
            {
                defaultCell.lblLot.backgroundColor = [UIColor colorWithRed:71.0f/255.0f green:185.0f/255.0f blue:124.0f/255.0f alpha:1];
                defaultCell.lblLeadingText.hidden = NO;
                if ([GlobalClass isAuctionClosed:self.currentAuction.strtimeRemains])
                {
                    defaultCell.lblLeadingText.text = @"Lot won";
                }
                else
                {
                    defaultCell.lblLeadingText.text = @"You are currently the highest bidder.";
                }
                defaultCell.btnBidNow.hidden = YES;
                defaultCell.btnProxy.hidden = YES;
            }
            else
            {
                defaultCell.lblLot.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:142.0f/255.0f blue:104.0f/255.0f alpha:1];
                defaultCell.btnBidNow.hidden = NO;
                defaultCell.btnProxy.hidden = NO;
                defaultCell.lblLeadingText.hidden = YES;
            }
            cell = defaultCell;
        }
        else if (indexPath.section==1)
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleBid" forIndexPath:indexPath];
            UILabel *lblUsername = (UILabel *)[cell viewWithTag:21];
            lblUsername.text=[NSString stringWithFormat:@"No of Bids: %lu",(unsigned long)arrBidHistoryData.count];
        }
        else
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BidCell" forIndexPath:indexPath];
            
            CurrentAuction *objCurrentAuction = [arrBidHistoryData objectAtIndex:indexPath.row];
            
            UILabel *lblUsername = (UILabel *)[cell viewWithTag:11];
            lblUsername.text=[NSString stringWithFormat:@"%@", objCurrentAuction.stranoname];
            
            UILabel *lblBidpriceus = (UILabel *)[cell viewWithTag:12];
            lblBidpriceus.text = objCurrentAuction.formatedCurrentBidPriceUS;

            UILabel *lblBidpricers = (UILabel *)[cell viewWithTag:13];
            lblBidpricers.text = objCurrentAuction.formatedCurrentBidPriceRS;
            
            UILabel *lbldaterec = (UILabel *)[cell viewWithTag:14];
            lbldaterec.text=[NSString stringWithFormat:@"%@",objCurrentAuction.strdaterec];
        }
    }
    else
    {
        cell = [self configureBottomMenuCell:_clvBottomMenu IndexPath:indexPath];
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
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 20);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView == self.clvBottomMenu)
    {
        [self didSelectBottomMenu:indexPath.row];
    }
}
-(void)didBidCancel
{
    
}
-(void)didProxyBidConfirm
{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
