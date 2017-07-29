//
//  TermsAndConditionsViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/11/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "HowToBuy.h"
#import "DataHolder.h"
#import "CollapsedHeaderView.h"
#import "TTTAttributedLabel.h"

@interface TermsAndConditionsViewController ()<TTTAttributedLabelDelegate>
{
    NSArray *arrTermsCondition;
}


@end

@implementation TermsAndConditionsViewController

-(void)setUpNavigationItem
{
    self.title=@"Contact Us";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    
    self.tableTandC.estimatedRowHeight = 100.0;
    self.tableTandC.rowHeight = UITableViewAutomaticDimension;
    self.tableTandC.estimatedSectionHeaderHeight = 44;
    self.tableTandC.sectionHeaderHeight = UITableViewAutomaticDimension;

    [self setupTermsConditionArray];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableTandC.delegate = self;
    self.tableTandC.dataSource = self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.tableTandC.delegate = nil;
    self.tableTandC.dataSource = nil;
}


-(void)setupTermsConditionArray
{
    //General Terms
    HowToBuy *tc1 = [[HowToBuy alloc] init];
    tc1.strTitle = @"General Terms";
    
    DataHolder *gen_data1 = [[DataHolder alloc] init];
    gen_data1.strDescription = @"By participating in this auction, you acknowledge that you are bound by the Conditions for Sale listed below and on the website www.astaguru.com\n";
    gen_data1.isSelected = 1;
    
    DataHolder *gen_data2 = [[DataHolder alloc] init];
    gen_data2.strDescription = @"Making a Winning Bid results in an enforceable contract of sale.";
    gen_data2.isSelected = 0;
    
    DataHolder *gen_data3 = [[DataHolder alloc] init];
    gen_data3.strDescription = @"AstaGuru is authorized by the seller to display at AstaGuru's discretion images and description of all lots in the catalogue and on the website.";
    gen_data3.isSelected = 0;
    
    DataHolder *gen_data4 = [[DataHolder alloc] init];
    gen_data4.strDescription = @"AstaGuru can grant record and reject any bids.";
    gen_data4.isSelected = 0;
    
    DataHolder *gen_data5 = [[DataHolder alloc] init];
    gen_data5.strDescription = @"Bidding access shall be given on AstaGuru's discretion . AstaGuru may ask for a deposit on lots prior to giving bidding access.";
    gen_data5.isSelected = 0;
    
    DataHolder *gen_data6 = [[DataHolder alloc] init];
    gen_data6.strDescription = @"AstaGuru may review bid histories of specific lots periodically to preserve the efficacy of the auction process.";
    gen_data6.isSelected = 0;
    
    DataHolder *gen_data7 = [[DataHolder alloc] init];
    gen_data7.strDescription = @"AstaGuru has the right to withdraw a Property before, during or after the bidding, if it has reason to believe that the authenticity of the Property or accuracy of description is in doubt.";
    gen_data7.isSelected = 0;
    
    DataHolder *gen_data8 = [[DataHolder alloc] init];
    gen_data8.strDescription = @"All proprieties shall be sold only if the reserve price in met. Reserve price is on each Property is confidential and shall not be disclosed . AstaGuru shall raise all invoices including buyers premium and related taxes.";
    gen_data8.isSelected = 0;
    
    DataHolder *gen_data9 = [[DataHolder alloc] init];
    gen_data9.strDescription = @"The Buyers Premium shall be calculated at 15% of the hammer price.";
    gen_data9.isSelected = 0;
    
    DataHolder *gen_data10 = [[DataHolder alloc] init];
    gen_data10.strDescription = @"All foreign currency exchange rates during the Auction are made on a constant of 1:60 (USD:INR) . All invoicing details shall be provided by the buyer prior to the auction.";
    gen_data10.isSelected = 0;
    
    DataHolder *gen_data11 = [[DataHolder alloc] init];
    gen_data11.strDescription = @"All payments shall be made within 7 days from the date of the invoice.";
    gen_data11.isSelected = 0;
    
    DataHolder *gen_data12 = [[DataHolder alloc] init];
    gen_data12.strDescription = @"In case payment is not made within the stated time period, it shall be treated as a breach of contract and the Seller may authorise AstaGuru to take any steps (including the institution of legal proceedings).";
    gen_data12.isSelected = 0;
    
    DataHolder *gen_data13 = [[DataHolder alloc] init];
    gen_data13.strDescription = @"AstaGuru may charge a 2% late payment fine per month. . If the buyer wishes to collect the property from AstaGuru, it must be collected within 30 Days from the date of the auction. The buyer shall be charged a 2% storage fee if the property is not collected.";
    gen_data13.isSelected = 0;
    
    DataHolder *gen_data14 = [[DataHolder alloc] init];
    gen_data14.strDescription = @"AstaGuru reserves the right not to award the Winning Bid to the Bidder with the highest Bid at Closing Date if it deems it necessary to do so. . In an unlikely event of any technical failure and the website is inaccessible. The lot closing time shall be extended.";
    gen_data14.isSelected = 0;
    
    DataHolder *gen_data15 = [[DataHolder alloc] init];
    gen_data15.strDescription = @"Bids recorded prior to the technical problem shall stand valid according to the terms of sale.";
    gen_data15.isSelected = 0;
    
    tc1.arrSub = @[gen_data1, gen_data2, gen_data3, gen_data4, gen_data5, gen_data6, gen_data7, gen_data8, gen_data9, gen_data10, gen_data11, gen_data12, gen_data13, gen_data14, gen_data15];
    
    //Authenticity Guarantee
    HowToBuy *tc2 = [[HowToBuy alloc] init];
    tc2.strTitle = @"Authenticity Guarantee";
    
    DataHolder *auth_data1 = [[DataHolder alloc] init];
    auth_data1.strDescription = @"AstaGuru assures on behalf of the seller that all properties on the website are genuine work of the artist listed.";
    auth_data1.isSelected = 0;
    
    DataHolder *auth_data2 = [[DataHolder alloc] init];
    auth_data2.strDescription = @"How ever in an unlikely event if the property is proved to be inauthentic to AstaGuru's satisfaction within a period of 6 months from the collection date. The seller shall be liable to pay back the full amount to the buyer. These claims will be handled on a case-by-case basis, and will require that examinable proof which clearly demonstrates that the Property is inauthentic is provided by an established and acknowledged authority. Only the actual Buyer (as registered with AstaGuru) makes the claim.";
    auth_data2.isSelected = 0;
    
    DataHolder *auth_data3 = [[DataHolder alloc] init];
    auth_data3.strDescription = @"The property, when returned, should be in the same condition as when it was purchased.";
    auth_data3.isSelected = 0;
    
    DataHolder *auth_data4 = [[DataHolder alloc] init];
    auth_data4.strDescription = @"In case the Buyer request for a certificate of authentication for a particular artwork, Astaguru will levy the expenditure of the same onto the Buyer.";
    auth_data4.isSelected = 0;
    
    DataHolder *auth_data5 = [[DataHolder alloc] init];
    auth_data5.strDescription = @"AstaGuru shall charge the buyer in case any steps are to be taken for special expenses shall take place in order to prove the authenticity of the property.";
    auth_data5.isSelected = 0;
    
    DataHolder *auth_data6 = [[DataHolder alloc] init];
    auth_data6.strDescription = @"In case the seller fails to refund the funds. Astaguru shall be authorized by the buyer to take legal action on behalf of the buyer to recover the money at the expense of the buyer.";
    auth_data6.isSelected = 0;
    
    tc2.arrSub = @[auth_data1, auth_data2, auth_data3, auth_data4, auth_data5, auth_data6];
    
    //Extent of AstaGuru's Liability
    HowToBuy *tc3 = [[HowToBuy alloc] init];
    tc3.strTitle = @"Extent of AstaGuru's Liability";
    
    DataHolder *extent_data1 = [[DataHolder alloc] init];
    extent_data1.strDescription = @"AstaGuru will obtain the money from the seller and thereafter refund to the buyer the amount of purchase in case the work is not authentic.";
    extent_data1.isSelected = 0;
    
    DataHolder *extent_data2 = [[DataHolder alloc] init];
    extent_data2.strDescription = @"All damages and loss during transit are covered by the insurance policy, AstaGuru is not liable.";
    extent_data2.isSelected = 0;
    
    DataHolder *extent_data3 = [[DataHolder alloc] init];
    extent_data3.strDescription = @"AstaGuru or any member of its team is not liable for any mistakes made in the catalogue.";
    extent_data3.isSelected = 0;
    
    DataHolder *extent_data4 = [[DataHolder alloc] init];
    extent_data4.strDescription = @"AstaGuru is not liable for any claims in insurance.";
    extent_data4.isSelected = 0;
    
    DataHolder *extent_data5 = [[DataHolder alloc] init];
    extent_data5.strDescription = @"AstaGuru is not liable in case the website has any technical problems.";
    extent_data5.isSelected = 0;
    
    DataHolder *extent_data6 = [[DataHolder alloc] init];
    extent_data6.strDescription = @"If any part of the Conditions for Sale between the Buyer and AstaGuru is found by any court to be invalid, illegal or unenforceable, that part may be discounted and the rest of the conditions shall be enforceable to the fullest extent permissible by law.";
    extent_data6.isSelected = 0;

    tc3.arrSub = @[extent_data1, extent_data2, extent_data3, extent_data4, extent_data5, extent_data6];
    
    //Law and Jurisdiction
    HowToBuy *tc4 = [[HowToBuy alloc] init];
    tc4.strTitle = @"Law and Jurisdiction";
    
    DataHolder *law_data1 = [[DataHolder alloc] init];
    law_data1.strDescription = @"The terms and conditions of this Auction are subject to the laws of India, which will apply to the construction and to the effect of the clauses. All parties are subject to the exclusive jurisdiction of the courts at Mumbai, Maharashtra, India.";
    law_data1.isSelected = 1;
    tc4.arrSub = @[law_data1];
    
    arrTermsCondition = @[tc1, tc2, tc3, tc4];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrTermsCondition.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HowToBuy *objHowToBuy = [arrTermsCondition objectAtIndex:section];
    return  objHowToBuy.arrSub.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    HowToBuy *objHowToBuy = [arrTermsCondition objectAtIndex:indexPath.section];
    
    DataHolder *objDataHolder = [objHowToBuy.arrSub objectAtIndex:indexPath.row];
    
    if (objDataHolder.isSelected == 0)
    {
        cell = [self.tableTandC dequeueReusableCellWithIdentifier:@"TextWithOutIconCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //NSString *text=objHowToBuy.Titlel;
        TTTAttributedLabel *lblDesc = (TTTAttributedLabel *)[cell viewWithTag:12];
        lblDesc.extendsLinkTouchArea = YES;
        lblDesc.textAlignment = NSTextAlignmentJustified;
        lblDesc.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblDesc.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblDesc.numberOfLines = 0;
        lblDesc.text = objDataHolder.strDescription; // Repository URL will be automatically detected and linked
    }
    else if (objDataHolder.isSelected == 1)
    {
        cell = [self.tableTandC dequeueReusableCellWithIdentifier:@"TextCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TTTAttributedLabel *lblSubtitle = (TTTAttributedLabel*)[cell viewWithTag:11];
        lblSubtitle.extendsLinkTouchArea = YES;
        lblSubtitle.textAlignment = NSTextAlignmentJustified;
        lblSubtitle.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblSubtitle.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblSubtitle.numberOfLines = 0;
        lblSubtitle.text = objDataHolder.strDescription; // Repository URL will be automatically detected and linked
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HowToBuy *objHowToBuy = [arrTermsCondition objectAtIndex:section] ;
    CollapsedHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if(headerView == nil)
    {
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"  owner:self  options:nil]objectAtIndex:0];
    }
    headerView.lblTitle.text = objHowToBuy.strTitle;
    
    BOOL sectionIsOpen = [self.tableTandC isOpenSection:section];
    
    if (sectionIsOpen)
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-expanded.png"];
    }else
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-collapsed.png"];
    }
    return headerView;
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    // Whilst this version will return you to your app once the phone call is over.
    NSURL *phoneNumber_Url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    
    // Now that we have our `phoneNumber` as a URL. We need to check that the device we are using can open the URL.
    // Whilst iPads, iPhone, iPod touchs can all open URLs in safari mobile they can't all
    // open URLs that are numbers this is why we have `tel://` or `telprompt://`
    if([[UIApplication sharedApplication] canOpenURL:phoneNumber_Url]) {
        // So if we can open it we can now actually open it with
        [[UIApplication sharedApplication] openURL:phoneNumber_Url];
    }
    
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
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
