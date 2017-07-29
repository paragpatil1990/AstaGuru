//
//  ArtistViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 18/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ArtistViewController.h"
#import "GlobalClass.h"
#import "BidNowViewController.h"
#import "CurrentProxyBidViewController.h"

#define font [UIFont fontWithName:@"WorkSans-Regular" size:16]

@interface ArtistViewController ()<BidNowViewControllerDelegate, ProxyBidViewControllerDelegate>
{
    BOOL isReadMore;

    AuctionType auctionType;

    NSArray *arrArtistAuction;
    NSArray *arrArtistAuctionItem;
    
    NSTimer *timer;
}
@end

@implementation ArtistViewController

-(void)setUpNavigationItem
{
    self.title=[NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName,self.currentAuction.strLastName];
    [self setNavigationBarBackButton];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    [self registerNibPastAuctionItemCollectionView:self.clvArtistInfo];
    [self registerNibCurrentAuctionCollectionView:self.clvArtistInfo];
    auctionType = AuctionTypeCurrent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"loading";
    [self spGetArtistDetailData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.task cancel];
    self.task = nil;
    [timer invalidate];
    timer = nil;
}

-(void)spGetArtistDetailData
{
    NSString  *strUrl=[NSString stringWithFormat:@"spGetArtistDetailData(%@)", self.currentAuction.strartistid];
    
    self.task = [GlobalClass call_procGETWebURL:strUrl parameters:nil view:nil success:^(id responseObject)
                 {
                     arrArtistAuctionItem = (NSArray*)responseObject;
                     if (arrArtistAuctionItem.count > 0)
                     {
                         [self reloadData:arrArtistAuctionItem];
                         if (auctionType == AuctionTypeCurrent)
                         {
                             if (timer == nil)
                             {
                                 timer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(spGetArtistDetailData) userInfo:nil repeats:YES];
                             }
                         }
                     }
                     else
                     {
                         [GlobalClass showTost:@"Information not available"];
                     }
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                 } failure:^(NSError *error){[MBProgressHUD hideHUDForView:self.view animated:YES];} callingCount:0];
}

-(void)reloadData:(NSArray*)auctionArray
{
    NSArray *pareseArray;
    if (auctionType == AuctionTypeCurrent)
    {
        pareseArray = [self getCurrentAuctionArray:auctionArray];
    }
    else
    {
        pareseArray = [self getPastAuctionArray:auctionArray];
    }
    arrArtistAuction = [self setUpCellValueWithArray:[pareseArray mutableCopy]];
    [self.clvArtistInfo reloadData];
}

-(NSMutableArray*)setUpCellValueWithArray:(NSMutableArray*)pareseArray
{
    if (arrArtistAuction.count == pareseArray.count)
    {
        for (int i=0; i < arrArtistAuction.count; i++)
        {
            CurrentAuction *objCurrentAcution = [arrArtistAuction objectAtIndex:i];
            for (int j=0; j<pareseArray.count; j++)
            {
                CurrentAuction *objParseAuction = [pareseArray objectAtIndex:j];
                if ([objCurrentAcution.strproductid intValue] == [objParseAuction.strproductid intValue])
                {
                    objParseAuction.isSwipOn = objCurrentAcution.isSwipOn;
                    objParseAuction.cellType = objCurrentAcution.cellType;
                    break;
                }
            }
        }
    }
    return pareseArray;
}


-(NSArray*)getCurrentAuctionArray:(NSArray*)auctionArray
{
    NSMutableArray *arrCurrentAuction = [[NSMutableArray alloc]init];
    for (int i=0; i<auctionArray.count ; i++)
    {
        NSDictionary *objAuction = [GlobalClass removeNullOnly:[auctionArray objectAtIndex:i]];
        
        if ([objAuction[@"status"] isEqualToString:@"Current"])
        {
            [arrCurrentAuction addObject:objAuction];
        }
    }
    NSArray *parseArray = [CurrentAuction parseAuction:arrCurrentAuction auctionType:AuctionTypeCurrent];
    
    return parseArray;
}

-(NSArray*)getPastAuctionArray:(NSArray*)auctionArray
{
    NSMutableArray *arrPastAuction = [[NSMutableArray alloc]init];
    for (int i=0; i<auctionArray.count ; i++)
    {
        NSDictionary *objAuction = [GlobalClass removeNullOnly:[auctionArray objectAtIndex:i]];
        
        if ([objAuction[@"status"] isEqualToString:@"Past"])
        {
            [arrPastAuction addObject:objAuction];
        }
    }
    NSArray *parseArray = [CurrentAuction parseAuction:arrPastAuction auctionType:AuctionTypePast];
    return parseArray;
}



//-(CGFloat)getAttributedStringHeight:(NSAttributedString*)str
//{
  //  CGFloat width = self.clvArtistInfo.frame.size.width - 16; // whatever your desired width is
   // CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
   // return rect.size.height;
//}

-(CGFloat)heightOf:(CGFloat)width
{
    return (width*60)/100;
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 3)
    {
        return 1;
    }
    else
    {
        if (arrArtistAuction.count == 0)
        {
            return 1;
        }
        return  arrArtistAuction.count;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 3)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        CGFloat ih = [self heightOf:collectionView.frame.size.width];
   
        CGFloat dheight = 8+ih+8+30+10+30+2+1;
        
        if (isReadMore)
        {
            CGFloat width = self.clvArtistInfo.frame.size.width - 16; // whatever your desired width is
            CGFloat artistDescHeight = [GlobalClass heightForNSAttributedString:[GlobalClass getAttributedString:self.currentAuction.strProfile havingFont:font] havingWidth:width];
            dheight = dheight + artistDescHeight;
            return CGSizeMake(collectionView.frame.size.width, dheight);
        }
        dheight = dheight + font.lineHeight*3;
        return   CGSizeMake(collectionView.frame.size.width, dheight);
    }
    else  if (indexPath.section == 1 || indexPath.section == 3)
    {
        return   CGSizeMake(collectionView.frame.size.width, 10);
    }
    else  if (indexPath.section == 2)
    {
        if (arrArtistAuction.count == 0)
        {
            return  CGSizeMake(collectionView.frame.size.width, 50);
        }
        else if (self.isList)
        {
            return   CGSizeMake(collectionView.frame.size.width - 16, 160);
        }
        else if (auctionType == AuctionTypeCurrent)
        {
            return   CGSizeMake((collectionView.frame.size.width/2) - 12, 355);
        }
        else
        {
            return   CGSizeMake((collectionView.frame.size.width/2) - 12, 300);
        }
    }
    else
    {
        return  CGSizeMake(collectionView.frame.size.width, 0);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (collectionView == _clvArtistInfo)
    {
        if (indexPath.section==0)
        {
            AuctionItemTopBannerCollectionViewCell *tcell = [self configureAuctionItemTopBannerCollectionViewCell:collectionView indexPath:indexPath bannerName:self.currentAuction.strauctionBanner];
            
            tcell.delegate = self;
            
            CGFloat ih = [self heightOf:collectionView.frame.size.width];
            tcell.imgeArtist_Height.constant = ih;
            tcell.imgArtist.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], self.currentAuction.strPicture]];
            
            tcell.lblArtistName.text = [NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName,self.currentAuction.strLastName];

            tcell.lblArtistProfile.attributedText = [GlobalClass getAttributedString:self.currentAuction.strProfile havingFont:font];
            
            if(isReadMore)
            {
                tcell.lblArtistProfile.numberOfLines = 0;
                [tcell.btnMore setTitle:@"Read Less" forState:UIControlStateNormal];
            }
            else
            {
//                tcell.lblArtistProfile.numberOfLines = 3;
                [tcell.btnMore setTitle:@"Read More" forState:UIControlStateNormal];
            }
            if (auctionType == AuctionTypeCurrent)
            {
                tcell.btnCurrentAuction.selected = YES;
                tcell.btnPastAuction.selected = NO;
                tcell.lblCurrentAuctionSelectedLine.hidden = NO;
                tcell.lblPastAuctionSelectedLine.hidden = YES;
            }
            else
            {
                tcell.btnCurrentAuction.selected = NO;
                tcell.btnPastAuction.selected = YES;
                tcell.lblCurrentAuctionSelectedLine.hidden = YES;
                tcell.lblPastAuctionSelectedLine.hidden = NO;
            }

            cell = tcell;
        }
        else  if (indexPath.section == 1 || indexPath.section == 3)
        {
            cell = [self configureBlankCell:collectionView indexPath:indexPath];
        }
        else
        {
            if (arrArtistAuction.count == 0)
            {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StaticCell" forIndexPath:indexPath];
            }
            else
            {
                CurrentAuction *objCurrentAccution = [arrArtistAuction objectAtIndex:indexPath.row];
                if (objCurrentAccution.cellType  == 0)
                {
                    cell = [self configureDefalutGridCell:collectionView indexPath:indexPath currentAuction:objCurrentAccution];
                }
                else
                {
                    cell = [self configureShortInfoCell:collectionView indexPath:indexPath currentAuction:objCurrentAccution];
                }
                [GlobalClass setBorder:cell cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
            }
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
}

-(void)didChangedAuctionType
{
    if (auctionType == AuctionTypeCurrent)
    {
        auctionType = AuctionTypePast;
    }
    else
    {
        auctionType = AuctionTypeCurrent;
    }
    [self reloadData:arrArtistAuctionItem];
}

-(void)didReadMoreChanged
{
    if (isReadMore)
    {
        isReadMore = 0;
    }
    else
    {
        isReadMore = 1;
    }
    [self.clvArtistInfo reloadData];
}

-(void)didBidCancel
{
    
}
-(void)didBidConfirm
{
    
}
-(void)didProxyBidCancel
{
    
}
-(void)didProxyBidConfirm
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
