//
//  AdditionalChargesViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 13/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AdditionalChargesViewController.h"
#import "AdditionalChargesCollectionViewCell.h"
#import "MyProfileViewController.h"
#import "UserInfoCollectionViewCell.h"

@interface AdditionalChargesViewController ()
{
    NSDictionary *dictUserProfile;
}
@end

@implementation AdditionalChargesViewController

-(void)setUpNavigationItem
{
    self.title=@"Additional Charges";
    [self setNavigationBarBackButton];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    if ([GlobalClass isUserLogin])
    {
        [self getUserProfile];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)getUserProfile
{
    [self getUserProfile:^(NSDictionary *userProfile){
        dictUserProfile = userProfile;
        [_clvViewAdditionalCgharges reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _clvViewAdditionalCgharges)
    {
        if ([GlobalClass isUserLogin])
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([GlobalClass isUserLogin])
    {
        if (indexPath.section==0)
        {
            return   CGSizeMake(collectionView1.frame.size.width,270);
        }
    }
    return   CGSizeMake(collectionView1.frame.size.width,410);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if ([GlobalClass isUserLogin])
    {
        if (indexPath.section==0)
        {
            UserInfoCollectionViewCell *userInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BillingInfo" forIndexPath:indexPath];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"name"] label:userInfoCell.lblBillingName];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"address1"] label:userInfoCell.lblBillingAddress];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"city"] label:userInfoCell.lblBillingCity];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"zip"] label:userInfoCell.lblBillingZip];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"state"] label:userInfoCell.lblBillingState];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"country"] label:userInfoCell.lblBillingCountry];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"Mobile"] label:userInfoCell.lblBillingPhone];
            [self checkBlankOrNot:[dictUserProfile valueForKey:@"email"] label:userInfoCell.lblBillingEmail];
            cell=userInfoCell;
        }
        else
        {
            AdditionalChargesCollectionViewCell *lotCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LotDetail" forIndexPath:indexPath];
            [self configrueLotDetailCell:lotCell];
            cell = lotCell;
        }
    }
    else
    {
        AdditionalChargesCollectionViewCell *lotCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LotDetail" forIndexPath:indexPath];
        [self configrueLotDetailCell:lotCell];
        cell = lotCell;
    }
    return cell;
}

-(void)configrueLotDetailCell:(AdditionalChargesCollectionViewCell*)lotCell
{
    lotCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[GlobalClass imageURL], self.currentAuction.strthumbnail]];
    [lotCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",[GlobalClass trimWhiteSpaceAndNewLine:self.currentAuction.strreference]] forState:UIControlStateNormal];
    if ([self.currentAuction.strAuctionname isEqualToString:@"Collectibles Auction"])
    {
        lotCell.lblArtistText.text = @"Title: ";
        lotCell.lblMediumText.text = @"Description: ";
        lotCell.lblYearText.text = @"";
        lotCell.lblArtistName.text = self.currentAuction.strtitle;
        lotCell.lblMedium.text= [GlobalClass convertHTMLTextToPlainText:self.currentAuction.strPrdescription];
        lotCell.lblYear.text = @"";
    }
    else
    {
        lotCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",self.currentAuction.strFirstName,self.currentAuction.strLastName];
        lotCell.lblMedium.text=[NSString stringWithFormat:@"%@",self.currentAuction.strmedium];
        lotCell.lblSize.text=[NSString stringWithFormat:@"%@ in",self.currentAuction.strproductsize];
        lotCell.lblYear.text=[NSString stringWithFormat:@"%@",self.currentAuction.strproductdate];
    }
    lotCell.lblSize.text = [NSString stringWithFormat:@"%@ in",self.currentAuction.strproductsize];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        lotCell.lblEstimation.text = self.currentAuction.strestamiate;
    }
    else
    {
        lotCell.lblEstimation.text = self.currentAuction.strcollectors;
    }
    
    NSInteger price;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:0];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        numberFormatter.currencyCode = @"USD";
        lotCell.lblHammerPrice.text = self.currentAuction.formatedCurrentBidPriceUS;
        price =[self.currentAuction.strBidpriceus integerValue];
    }
    else
    {
        numberFormatter.currencyCode = @"INR";
        lotCell.lblHammerPrice.text = self.currentAuction.formatedCurrentBidPriceRS;
        price =[self.currentAuction.strBidpricers integerValue];
    }
    
    NSInteger primium = (price*15)/100;
    NSInteger vat = (price*12)/100;
    NSInteger gstOnPrimium = (primium*15)/100;
    NSInteger grandTotal = price+primium+vat+gstOnPrimium;
    
    NSString *strPrimium = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:primium]];
    NSString *strVat = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:vat]];
    NSString *strGSTOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInteger:gstOnPrimium]];
    NSString *strGrandTotal = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:grandTotal]];
    
    lotCell.lblBuyerPremium.text = strPrimium;
    lotCell.lblVatOnHammerPrice.text = strVat;
    lotCell.lblGSTOnPremium.text = strGSTOnPrimium;
    lotCell.lblGrandTotal.text = strGrandTotal;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updateBillingAddress:(id)sender
{
    if ([GlobalClass isUserLogin])
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        MyProfileViewController *objMyProfileViewController = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
        [self.navigationController pushViewController:objMyProfileViewController animated:YES];
    }
    else
    {
        [self gotoLoginVC];
    }
}

-(void)checkBlankOrNot:(NSString*)string label:(UILabel*)lable;
{
    if (string.length==0)
    {
        lable.text = @"--";
    }
    else
    {
        lable.text = string;
    }
}

@end
