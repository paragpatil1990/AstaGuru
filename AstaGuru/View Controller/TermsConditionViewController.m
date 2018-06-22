//
//  TermsConditionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 05/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "TermsConditionViewController.h"
#import "clsAboutUs.h"
#import "OurValutionCollectionViewCell.h"
#import "SectionHeaderReusableView.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
@interface TermsConditionViewController ()
{
    NSMutableArray *arrFirst;
    NSMutableArray *arrSecond;
    NSMutableArray *arrThired;
     NSMutableArray *arrFouth;
}
@end

@implementation TermsConditionViewController

- (void)viewDidLoad
{
    //UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopNavigation"]];
    //[self.navigationItem setTitleView:titleView];
    
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    self.navigationItem.title=@"Terms & Conditions";
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    arrFirst=[[NSMutableArray alloc]init];
    arrSecond=[[NSMutableArray alloc]init];
    arrThired=[[NSMutableArray alloc]init];
    arrFouth=[[NSMutableArray alloc]init];
    [self CreateArray];
    [super viewDidLoad];
    
    
}
-(void)closePressed
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}
-(void)CreateArray
{
    clsAboutUs *objclsAboutus1=[[clsAboutUs alloc]init];
    objclsAboutus1.strName=@"By participating in this auction, you acknowledge that you are bound by the Conditions for Sale listed below and on the website www.astaguru.com\n";
    objclsAboutus1.strType=@"1";
    [arrFirst addObject:objclsAboutus1];
    
    clsAboutUs *objclsAboutus2=[[clsAboutUs alloc]init];
    objclsAboutus2.strName=@"Making a Winning Bid results in an enforceable contract of sale.";
    objclsAboutus2.strType=@"2";
    [arrFirst addObject:objclsAboutus2];
    
    clsAboutUs *objclsAboutus3=[[clsAboutUs alloc]init];
    objclsAboutus3.strName=@"AstaGuru is authorized to display at AstaGuru's discretion images and description of all lots in the catalogue and on the website.";
    objclsAboutus3.strType=@"2";
    [arrFirst addObject:objclsAboutus3];
    
    clsAboutUs *objclsAboutus4=[[clsAboutUs alloc]init];
    objclsAboutus4.strName=@"AstaGuru can grant record and reject any bids and/or proxy bids.";
    objclsAboutus4.strType=@"2";
    [arrFirst addObject:objclsAboutus4];
    
    clsAboutUs *objclsAboutus5=[[clsAboutUs alloc]init];
    objclsAboutus5.strName=@"Bidding access shall be given on AstaGuru's discretion. AstaGuru may ask for a deposit on lots prior to giving bidding access.";
    objclsAboutus5.strType=@"2";
    [arrFirst addObject:objclsAboutus5];
    
    clsAboutUs *objclsAboutus6=[[clsAboutUs alloc]init];
    objclsAboutus6.strName=@"AstaGuru may review bid histories of specific lots periodically to preserve the efficacy of the auction process.";
    objclsAboutus6.strType=@"2";
    [arrFirst addObject:objclsAboutus6];
    
    clsAboutUs *objclsAboutus7=[[clsAboutUs alloc]init];
    objclsAboutus7.strName=@"AstaGuru has the right to withdraw a Property before, during or after the bidding, if it has reason to believe that the authenticity of the Property or accuracy of description is in doubt.";
    objclsAboutus7.strType=@"2";
    [arrFirst addObject:objclsAboutus7];
    
    clsAboutUs *objclsAboutus8=[[clsAboutUs alloc]init];
    objclsAboutus8.strName=@"All proprieties shall be sold only if the reserve price in met. Reserve price is on each Property is confidential and shall not be disclosed . AstaGuru shall raise all invoices including its margin and related taxes.";
    objclsAboutus8.strType=@"2";
    [arrFirst addObject:objclsAboutus8];
    
    
    clsAboutUs *objclsAboutus9=[[clsAboutUs alloc]init];
    objclsAboutus9.strName=@"The Margin shall be calculated at 15% of the hammer price, excluding related tax.";
    objclsAboutus9.strType=@"2";
    [arrFirst addObject:objclsAboutus9];
    
    clsAboutUs *objclsAboutus10=[[clsAboutUs alloc]init];
    objclsAboutus10.strName=@"All foreign currency exchange rates during the Auction are made on a constant of 1:64 (USD:INR). All invoicing details shall be provided by the buyer prior to the auction.";
    objclsAboutus10.strType=@"2";
    [arrFirst addObject:objclsAboutus10];
    
    
    clsAboutUs *objclsAboutus11=[[clsAboutUs alloc]init];
    objclsAboutus11.strName=@"All payments shall be made within 7 days from the date of the invoice.";
    objclsAboutus11.strType=@"2";
    [arrFirst addObject:objclsAboutus11];
    
    clsAboutUs *objclsAboutus12=[[clsAboutUs alloc]init];
    objclsAboutus12.strName=@"In case payment is not made within the stated time period, it shall be treated as a breach of contract and AstaGuru to take any steps (including the institution of legal proceedings).";
    objclsAboutus12.strType=@"2";
    [arrFirst addObject:objclsAboutus12];
    
    clsAboutUs *objclsAboutus13=[[clsAboutUs alloc]init];
    objclsAboutus13.strName=@"AstaGuru may charge a 2% late payment fine per month. If the buyer wishes to collect the property from AstaGuru, it must be collected within 30 Days from the date of the auction. The buyer shall be charged a 2% storage fee if the property is not collected.";
    objclsAboutus13.strType=@"2";
    [arrFirst addObject:objclsAboutus13];
    
    clsAboutUs *objclsAboutus14=[[clsAboutUs alloc]init];
    objclsAboutus14.strName=@"AstaGuru reserves the right not to award the Winning Bid to the Bidder with the highest Bid at Closing Date if it deems it necessary to do so. In an unlikely event of any technical failure and the website is inaccessible. The lot closing time shall be extended.";
    objclsAboutus14.strType=@"2";
    [arrFirst addObject:objclsAboutus14];
    
    clsAboutUs *objclsAboutus15=[[clsAboutUs alloc]init];
    objclsAboutus15.strName=@"Bids recorded prior to the technical problem shall stand valid according to the terms of sale.";
    objclsAboutus15.strType=@"2";
    [arrFirst addObject:objclsAboutus15];
    
    
    
    
    
    
    clsAboutUs *objclsAboutus16=[[clsAboutUs alloc]init];
    objclsAboutus16.strName=@"AstaGuru assures that all properties on the website are genuine work of the artist listed.";
    objclsAboutus16.strType=@"2";
    [arrSecond addObject:objclsAboutus16];
    
    clsAboutUs *objclsAboutus17=[[clsAboutUs alloc]init];
    objclsAboutus17.strName=@"How ever in an unlikely event if the property is proved to be inauthentic to AstaGuru's satisfaction within a period of 6 months from the collection date. AstaGuru shall pay back the full amount to the buyer. These claims will be handled on a case-by-case basis, and will require that examinable proof which clearly demonstrates that the Property is inauthentic is provided by an established and acknowledged authority. Only the actual Buyer (as registered with AstaGuru) makes the claim.";
    objclsAboutus17.strType=@"2";
    [arrSecond addObject:objclsAboutus17];
    
    clsAboutUs *objclsAboutus18=[[clsAboutUs alloc]init];
    objclsAboutus18.strName=@"The property, when returned, should be in the same condition as when it was purchased.";
    objclsAboutus18.strType=@"2";
    [arrSecond addObject:objclsAboutus18];
    
    clsAboutUs *objclsAboutus19=[[clsAboutUs alloc]init];
    objclsAboutus19.strName=@"In case the Buyer request for a certificate of authentication for a particular artwork, Astaguru will levy the expenditure of the same onto the Buyer.";
    objclsAboutus19.strType=@"2";
    [arrSecond addObject:objclsAboutus19];
    
    clsAboutUs *objclsAboutus20=[[clsAboutUs alloc]init];
    objclsAboutus20.strName=@"AstaGuru shall charge the buyer in case any steps are to be taken for special expenses shall take place in order to prove the authenticity of the property.";
    objclsAboutus20.strType=@"2";
    [arrSecond addObject:objclsAboutus20];
    
//    clsAboutUs *objclsAboutus21=[[clsAboutUs alloc]init];
//    objclsAboutus21.strName=@"In case the seller fails to refund the funds. Astaguru shall be authorized by the buyer to take legal action on behalf of the buyer to recover the money at the expense of the buyer.";
//    objclsAboutus21.strType=@"2";
//    [arrSecond addObject:objclsAboutus21];
    
    
    clsAboutUs *objclsAboutus22=[[clsAboutUs alloc]init];
    objclsAboutus22.strName=@"AstaGuru will refund to the buyer the amount of purchase in case the work is not authentic.";
    objclsAboutus22.strType=@"2";
    [arrThired addObject:objclsAboutus22];
    
    clsAboutUs *objclsAboutus23=[[clsAboutUs alloc]init];
    objclsAboutus23.strName=@"All damages and loss during transit are covered by the insurance policy, AstaGuru is not liable.";
    objclsAboutus23.strType=@"2";
    [arrThired addObject:objclsAboutus23];
    clsAboutUs *objclsAboutus24=[[clsAboutUs alloc]init];
    objclsAboutus24.strName=@"AstaGuru or any member of its team is not liable for any mistakes made in the catalogue.";
    objclsAboutus24.strType=@"2";
    [arrThired addObject:objclsAboutus24];
    clsAboutUs *objclsAboutus25=[[clsAboutUs alloc]init];
    objclsAboutus25.strName=@"AstaGuru is not liable for any claims in insurance.";
    objclsAboutus25.strType=@"2";
    [arrThired addObject:objclsAboutus25];

    clsAboutUs *objclsAboutus26=[[clsAboutUs alloc]init];
    objclsAboutus26.strName=@"AstaGuru is not liable in case the website has any technical problems.";
    objclsAboutus26.strType=@"2";
    [arrThired addObject:objclsAboutus26];
    clsAboutUs *objclsAboutus27=[[clsAboutUs alloc]init];
    objclsAboutus27.strName=@"If any part of the Conditions for Sale between the Buyer and AstaGuru is found by any court to be invalid, illegal or unenforceable, that part may be discounted and the rest of the conditions shall be enforceable to the fullest extent permissible by law.";
    objclsAboutus27.strType=@"2";
    [arrThired addObject:objclsAboutus27];
    
    clsAboutUs *objclsAboutus28=[[clsAboutUs alloc]init];
    objclsAboutus28.strName=@"The terms and conditions of this Auction are subject to the laws of India, which will apply to the construction and to the effect of the clauses. All parties are subject to the exclusive jurisdiction of the courts at Mumbai, Maharashtra, India.";
    objclsAboutus28.strType=@"1";
    [arrFouth addObject:objclsAboutus28];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 5;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return arrFirst.count;
       
    }
    else if (section==2)
    {
         return arrSecond.count;
        
    }
    else if (section==3)
    {
       return arrThired.count;
    }
    else 
    {
    return arrFouth.count;
    }
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell3;
    OurValutionCollectionViewCell *OurValutioncell;
    
    //static NSString *identifier = @"Cell";
    
    if (indexPath.section==0)
    {
        
        // static NSString *identifier = @"cellone";
        
        UICollectionViewCell  *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellline" forIndexPath:indexPath];
        //UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:12];
        
        return cell2;
        
        
    }
    else
    {
        OurValutioncell= [collectionView dequeueReusableCellWithReuseIdentifier:@"valuation" forIndexPath:indexPath];
        
        clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
        
        if (indexPath.section==1)
        {
            objAboutUs=[arrFirst objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==2)
        {
            objAboutUs=[arrSecond objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==3)
        {
            objAboutUs=[arrThired objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==4)
        {
            objAboutUs=[arrFouth objectAtIndex:indexPath.row];
        }
        
        if ([objAboutUs.strType intValue]==1)
        {
            OurValutioncell.wtImageConstant.constant=-10;
        }
        else
        {
            OurValutioncell.wtImageConstant.constant=15;
        }
        
        OurValutioncell.lblTitle.text=objAboutUs.strName;
        OurValutioncell.lblTitle.textAlignment = NSTextAlignmentJustified;
        
        
        
        return OurValutioncell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
    
    if (indexPath.section==0)
    {
        return CGSizeMake(collectionView1.frame.size.width, 20);
    }
    else
    {
        if (indexPath.section==1)
        {
            objAboutUs=[arrFirst objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==2)
        {
            objAboutUs=[arrSecond objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==3)
        {
            objAboutUs=[arrThired objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==4)
        {
            objAboutUs=[arrFouth objectAtIndex:indexPath.row];
        }
        
        
        CGSize maximumLabelSize;
        if ([objAboutUs.strType intValue]==1)
        {
            maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-29, FLT_MAX);
            CGRect labelRect = [objAboutUs.strName
                                boundingRectWithSize:maximumLabelSize
                                options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{
                                             NSFontAttributeName : [UIFont systemFontOfSize:16]
                                             }
                                context:nil];
            float height11= labelRect.size.height+20;
            return CGSizeMake(collectionView1.frame.size.width, height11);
        }
        else
        {
            maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-44, FLT_MAX);
            CGRect labelRect = [objAboutUs.strName
                                boundingRectWithSize:maximumLabelSize
                                options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{
                                             NSFontAttributeName : [UIFont systemFontOfSize:16]
                                             }
                                context:nil];
            
            float height11= labelRect.size.height+5;
            return CGSizeMake(collectionView1.frame.size.width, height11+10);
        }
        
        
        
    }
    
    
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        SectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (indexPath.section==1)
        {
            headerView.title.hidden=NO;
            headerView.title.text =@"General Terms";
        }
       else if (indexPath.section==2)
        {
            headerView.title.hidden=NO;
            headerView.title.text =@"Authenticity Guarantee";
        }
        else  if (indexPath.section==3)
        {
            headerView.title.text =@"Extent of AstaGuru's Liability";
            headerView.title.hidden=NO;
            
        }
        else  if (indexPath.section==4)
        {
            headerView.title.text =@"Law and Jurisdiction";
            headerView.title.hidden=NO;
            
        }
        else
        {
            headerView.title.hidden=YES;
        }
        
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
     return CGSizeMake(CGRectGetWidth(collectionView.bounds), 0);
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
