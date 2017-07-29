//
//  HowToBuyViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/10/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "HowToBuyViewController.h"
#import "HowToBuy.h"
#import "DataHolder.h"
#import "CollapsedHeaderView.h"
#import "TTTAttributedLabel.h"
@interface HowToBuyViewController ()<TTTAttributedLabelDelegate>
{
    NSArray *arrHowToBuy;
}
@end

@implementation HowToBuyViewController

-(void)setUpNavigationItem
{
    self.title=@"How To Buy";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    
    self.tableHowToBuy.estimatedRowHeight = 100.0;
    self.tableHowToBuy.rowHeight = UITableViewAutomaticDimension;
    self.tableHowToBuy.estimatedSectionHeaderHeight = 44;
    self.tableHowToBuy.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    [self setupArray];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableHowToBuy.delegate = self;
    self.tableHowToBuy.dataSource = self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.tableHowToBuy.delegate = nil;
    self.tableHowToBuy.dataSource = nil;
}
-(void)setupArray
{
    //Estimates
    DataHolder *data_est1 = [[DataHolder alloc] init];
    data_est1.strDescription = @"Estimates are based on an average market value of the lot.";
    data_est1.isSelected = 0;
    
    DataHolder *data_est2 = [[DataHolder alloc] init];
    data_est2.strDescription = @"These are provided only as a guide for buyers.";
    data_est2.isSelected = 0;

    DataHolder *data_est3 = [[DataHolder alloc] init];
    data_est3.strDescription = @"Buyers should not rely on estimates as a prediction of actual price.";
    data_est3.isSelected = 0;

    DataHolder *data_est4 = [[DataHolder alloc] init];
    data_est4.strDescription = @"Estimates do not include Buyers Premium.";
    data_est4.isSelected = 0;

    HowToBuy *data1 = [[HowToBuy alloc] init];
    data1.strTitle = @"Estimates";
    data1.arrSub = [[NSArray alloc] initWithObjects:data_est1,data_est2,data_est3,data_est4, nil];
    
    
    //Reserves
    DataHolder *data_res1 = [[DataHolder alloc] init];
    data_res1.strDescription = @"The Reserve price is the minimum price at which the lot shall be sold.";
    data_res1.isSelected = 0;
    
    DataHolder *data_res2 = [[DataHolder alloc] init];
    data_res2.strDescription = @"The reserve price is confidential and will not be disclosed.";
    data_res2.isSelected = 0;
    
    HowToBuy *data2 = [[HowToBuy alloc] init];
    data2.strTitle = @"Reserves";
    data2.arrSub = [[NSArray alloc] initWithObjects:data_res1, data_res2, nil];
    
    //Buyers Premium
    DataHolder *data_buy1 = [[DataHolder alloc] init];
    data_buy1.strDescription = @"In addition to the hammer price, the buyer agrees to pay Astaguru the buyer's premium calculated at 15% of the winning bid value on each lot.";
    data_buy1.isSelected = 0;
    
    DataHolder *data_buy2 = [[DataHolder alloc] init];
    data_buy2.strDescription = @"Service tax on the buyer's premium shall be applicable for paintings purchased within India.";
    data_buy2.isSelected = 0;
    
    HowToBuy *data3 = [[HowToBuy alloc] init];
    data3.strTitle = @"Buyers Premium";
    data3.arrSub = [[NSArray alloc] initWithObjects:data_buy1, data_buy2, nil];
    
    //Bidding
    //Bidding -> Pre-Registration and Verification.
    DataHolder *data_bid10 = [[DataHolder alloc] init];
    data_bid10.strDescription = @"Pre-Registration and Verification";
    data_bid10.isSelected = 1;
    
    DataHolder *data_bid11 = [[DataHolder alloc] init];
    data_bid11.strDescription = @"Prospective buyers should be registered and verified in order to bid.";
    data_bid11.isSelected = 0;
    
    DataHolder *data_bid12 = [[DataHolder alloc] init];
    data_bid12.strDescription = @"If you have already registered before, you will still need to pre-register and accept the terms and conditions for the sale. (Use your previous login Id).";
    data_bid12.isSelected = 0;
    
    DataHolder *data_bid13 = [[DataHolder alloc] init];
    data_bid13.strDescription = @"Fill the form online in order to pre-register, or call AstaGuru.";
    data_bid13.isSelected = 0;
    
    DataHolder *data_bid14 = [[DataHolder alloc] init];
    data_bid14.strDescription= @"Once you have pre-registered a representative will call you to verify your details.";
    data_bid14.isSelected = 0;
    
    DataHolder *data_bid15 = [[DataHolder alloc] init];
    data_bid15.strDescription = @"If the representative cannot reach you an email will be sent.";
    data_bid15.isSelected = 0;
    
    DataHolder *data_bid16 = [[DataHolder alloc] init];
    data_bid16.strDescription = @"Please note that if this process has not taken place you shall not be given bidding access.";
    data_bid16.isSelected = 0;
    
    DataHolder *data_bid17 = [[DataHolder alloc] init];
    data_bid17.strDescription = @"All bidding access shall be provided 24 hours before the auction.";
    data_bid17.isSelected = 0;
    
    DataHolder *data_bid18 = [[DataHolder alloc] init];
    data_bid18.strDescription = @"Once your application has been accepted you shall receive an email confirming your bidding access along with your Login Id and password.";
    data_bid18.isSelected = 0;
 
    //Bidding -> Absentee Bids
    DataHolder *data_bid19 = [[DataHolder alloc] init];
    data_bid19.strDescription = @"Absentee Bids";
    data_bid19.isSelected = 1;
    
    DataHolder *data_bid20 = [[DataHolder alloc] init];
    data_bid20.strDescription = @"You may place an absentee bid, by faxing the written bid form available online and in the printed catalogue.";
    data_bid20.isSelected = 0;
    
    DataHolder *data_bid21 = [[DataHolder alloc] init];
    data_bid21.strDescription = @"All bids must come in 24 hours before the auction.";
    data_bid21.isSelected = 0;
   
    //Bidding -> Proxy Bids
    DataHolder *data_bid22 = [[DataHolder alloc] init];
    data_bid22.strDescription = @"Proxy Bids";
    data_bid22.isSelected = 1;

    DataHolder *data_bid23 = [[DataHolder alloc] init];
    data_bid23.strDescription = @"Proxy bids shall be placed on the website once the auction catalogue goes live and will be available until the end of the auction.";
    data_bid23.isSelected = 0;
    
    DataHolder *data_bid24 = [[DataHolder alloc] init];
    data_bid24.strDescription = @"Once you have identified the lot that you would like to bid on, click on 'Proxy bid' and enter desired amount(10% more than the previous bid) and confirm your bid at the value submitted.";
    data_bid24.isSelected = 0;
    
    DataHolder *data_bid25 = [[DataHolder alloc] init];
    data_bid25.strDescription = @"In case of the 'No Reserve' auction all proxy bid values start at Rs 20,000.";
    data_bid25.isSelected = 0;
    
    DataHolder *data_bid26 = [[DataHolder alloc] init];
    data_bid26.strDescription = @"Proxy bid placed on a lot before an auction cannot be resubmitted online. Users can update such proxy bids by submitting a duly signed written bid form provided on the website.";
    data_bid26.isSelected = 0;
    
    DataHolder *data_bid27 = [[DataHolder alloc] init];
    data_bid27.strDescription = @"In case a user is outbid on their proxy, they will be intimated of the same and can update the proxy online if they wish to so.";
    data_bid27.isSelected = 0;
    
    DataHolder *data_bid28 = [[DataHolder alloc] init];
    data_bid28.strDescription = @"Astaguru reserves the right to reject any proxy bid at its discretion without having to provide any explaination.";
    data_bid28.isSelected = 0;
    
    //Bidding -> Opening Bid
    DataHolder *data_bid29 = [[DataHolder alloc] init];
    data_bid29.strDescription = @"Opening Bid";
    data_bid29.isSelected = 1;
    
    DataHolder *data_bid30 = [[DataHolder alloc] init];
    data_bid30.strDescription = @"Opening Bid is the value at which the auction house starts the bidding of each lot.";
    data_bid30.isSelected = 0;
    
    DataHolder *data_bid31 = [[DataHolder alloc] init];
    data_bid31.strDescription = @"Opening bid is 20% lower than value of the lower estimate.";
    data_bid31.isSelected = 0;
    
    DataHolder *data_bid32 = [[DataHolder alloc] init];
    data_bid32.strDescription = @"In case of the 'No Reserve' auction all bids start at Rs 20,000.";
    data_bid32.isSelected = 0;
  
    //Bidding -> Bidding Online
    DataHolder *data_bid33 = [[DataHolder alloc] init];
    data_bid33.strDescription = @"Bidding Online";
    data_bid33.isSelected = 1;
    
    DataHolder *data_bid34 = [[DataHolder alloc] init];
    data_bid34.strDescription = @"Once you have identified the lot that you would like to bid on, click on 'Bid Now' confirm your bid at the value listed";
    data_bid34.isSelected = 0;
    
    DataHolder *data_bid35 = [[DataHolder alloc] init];
    data_bid35.strDescription = @"This is where you participate in the bidding process, by entering the next valid bid each time you are out-bid.";
    data_bid35.isSelected = 0;
    
    DataHolder *data_bid36 = [[DataHolder alloc] init];
    data_bid36.strDescription = @"The next valid bid will be a 10% increment in value of the last valid bid.";
    data_bid36.isSelected = 0;
    
    DataHolder *data_bid37 = [[DataHolder alloc] init];
    data_bid37.strDescription = @"All lots bid history will be made available to be viewed.";
    data_bid37.isSelected = 0;
    
    //Bidding -> Bid Increments
    DataHolder *data_bid38 = [[DataHolder alloc] init];
    data_bid38.strDescription = @"Bid Increments";
    data_bid38.isSelected = 1;
    
    DataHolder *data_bid39 = [[DataHolder alloc] init];
    data_bid39.strDescription = @"All bids will have an increment of 10% of the current valid bid";
    data_bid39.isSelected = 0;

    //Bidding -> Personalized Bid Notifications";
    DataHolder *data_bid40 = [[DataHolder alloc] init];
    data_bid40.strDescription = @"Personalized Bid Notifications";
    data_bid40.isSelected = 1;
    
    DataHolder *data_bid41 = [[DataHolder alloc] init];
    data_bid41.strDescription = @"In case you're outbid on a particular lot you will be notified of the same on your registered email and mobile number.";
    data_bid41.isSelected = 0;
    
    DataHolder *data_bid42 = [[DataHolder alloc] init];
    data_bid42.strDescription = @"In case you've won a particular lot in an auction you will be notified of the same on your registered email and mobile number.";
    data_bid42.isSelected = 0;
  
    //Bidding -> Bid History
    DataHolder *data_bid43 = [[DataHolder alloc] init];
    data_bid43.strDescription = @"Bid History";
    data_bid43.isSelected = 1;
    
    DataHolder *data_bid44 = [[DataHolder alloc] init];
    data_bid44.strDescription = @"Bid history indicates the value recorded for each lot since the start of the auction";
    data_bid44.isSelected = 0;
    
    DataHolder *data_bid45 = [[DataHolder alloc] init];
    data_bid45.strDescription = @"Bid History will not be displayed once the auction has closed.";
    data_bid45.isSelected = 0;
    
    //Bidding -> Currency of Bidding"
    DataHolder *data_bid46 = [[DataHolder alloc] init];
    data_bid46.strDescription = @"Bids can be placed in US Dollars (USD) or Indian Rupees (INR).";
    data_bid46.isSelected = 1;
    
    DataHolder *data_bid47 = [[DataHolder alloc] init];
    data_bid47.strDescription = @"Bids can be placed in US Dollars (USD) or Indian Rupees (INR).";
    data_bid47.isSelected = 0;
    
    DataHolder *data_bid48 = [[DataHolder alloc] init];
    data_bid48.strDescription = @"Buyers in India must pay for their purchase in INR and all other buyers must pay in USD";
    data_bid48.isSelected = 0;
    
    //Bidding -> Closing and Winning Bid
    DataHolder *data_bid49 = [[DataHolder alloc] init];
    data_bid49.strDescription = @"Closing and Winning Bid";
    data_bid49.isSelected = 1;

    DataHolder *data_bid50 = [[DataHolder alloc] init];
    data_bid50.strDescription = @"Winning bid is the last and highest bid at which the lot has closed.";
    data_bid50.isSelected = 0;
    
    DataHolder *data_bid51 = [[DataHolder alloc] init];
    data_bid51.strDescription = @"No new bids cannot be placed after the close of a lot.";
    data_bid51.isSelected = 0;
    
    DataHolder *data_bid52 = [[DataHolder alloc] init];
    data_bid52.strDescription = @"The closing bid is considered the winning bid only if the bid exceeds the reserve price.";
    data_bid52.isSelected = 0;
    
    DataHolder *data_bid53 = [[DataHolder alloc] init];
    data_bid53.strDescription = @"All winning bids shall be posted on the website after the close of the auction.";
    data_bid53.isSelected = 0;
    
    //Bidding -> Bid Cancellation
    DataHolder *data_bid54 = [[DataHolder alloc] init];
    data_bid54.strDescription = @"Bid Cancellation";
    data_bid54.isSelected = 1;
    
    DataHolder *data_bid55 = [[DataHolder alloc] init];
    data_bid55.strDescription = @"Once any bid and/or proxy bid has been placed, it cannot be cancelled. AstaGuru reserves the rights to cancel any bids in order to protect the efficacy of the bidding process.";
    data_bid55.isSelected = 0;
    
    //Bidding -> Buyers Premium
    DataHolder *data_bid56 = [[DataHolder alloc] init];
    data_bid56.strDescription = @"Buyers Premium";
    data_bid56.isSelected = 1;
    
    DataHolder *data_bid57 = [[DataHolder alloc] init];
    data_bid57.strDescription = @"In addition to the hammer price, the buyer agrees to pay to us the buyers premium calculated at 15% of the winning bid value on each lot.";
    data_bid57.isSelected = 0;
    
    DataHolder *data_bid58 = [[DataHolder alloc] init];
    data_bid58.strDescription = @"Service tax on the buyers premium shall be applicable for paintings purchased within India.";
    data_bid58.isSelected = 0;
    
    //Bidding
    HowToBuy *data4 = [[HowToBuy alloc] init];
    data4.strTitle = @"Bidding";
    data4.arrSub = [[NSArray alloc] initWithObjects:data_bid10, data_bid11, data_bid12, data_bid13, data_bid14, data_bid15, data_bid16, data_bid17, data_bid18, data_bid19, data_bid20, data_bid21, data_bid22, data_bid23, data_bid24, data_bid25, data_bid26, data_bid27, data_bid28, data_bid29, data_bid30, data_bid31, data_bid32, data_bid33, data_bid34, data_bid35, data_bid36, data_bid37, data_bid38, data_bid39, data_bid40, data_bid41, data_bid42, data_bid43, data_bid44, data_bid45, data_bid46, data_bid47, data_bid48, data_bid49, data_bid50, data_bid51, data_bid52, data_bid53, data_bid54, data_bid55, data_bid56, data_bid57, data_bid58, nil];
    
    
    //After Sale
    
    //After Sale ->
    DataHolder *data_aft1 = [[DataHolder alloc] init];
    data_aft1.strDescription = @"If you have won a lot you shall be informed via email after the auction has closed.";
    data_aft1.isSelected = 0;
    
    DataHolder *data_aft2 = [[DataHolder alloc] init];
    data_aft2.strDescription = @"You shall there after receive an email with the invoice stating buyers premium along with related taxes.";
    data_aft2.isSelected = 0;
    
    DataHolder *data_aft3 = [[DataHolder alloc] init];
    data_aft3.strDescription = @"If you are the winning bidder, you are legally bound to purchase the item from AstaGuru. Please note that purchases will not be shipped out until full payment has been received and cleared.";
    data_aft3.isSelected = 0;
    
    //After Sale -> Invoicing
    DataHolder *data_aft4 = [[DataHolder alloc] init];
    data_aft4.strDescription = @"Invoicing";
    data_aft4.isSelected = 1;
    
    DataHolder *data_aft5 = [[DataHolder alloc] init];
    data_aft5.strDescription = @"All details for the invoice are to be provided prior to the auction.";
    data_aft5.isSelected = 0;
    
    DataHolder *data_aft6 = [[DataHolder alloc] init];
    data_aft6.strDescription = @"After the sale, the Buyer as invoiced is required to pay the amounts in full (including the additional charges).";
    data_aft6.isSelected = 0;
    
    DataHolder *data_aft7 = [[DataHolder alloc] init];
    data_aft7.strDescription = @"No lots shall be sent without payment made in full.";
    data_aft7.isSelected = 0;
    
    //After Sale -> Shipping and Insurance
    DataHolder *data_aft8 = [[DataHolder alloc] init];
    data_aft8.strDescription = @"Shipping and Insurance";
    data_aft8.isSelected = 1;
    
    DataHolder *data_aft9 = [[DataHolder alloc] init];
    data_aft9.strDescription = @"Price estimates do not include any packing, insurance, shipping or handling charges, all of which will be borne by the buyer.";
    data_aft9.isSelected = 0;
    
    DataHolder *data_aft10 = [[DataHolder alloc] init];
    data_aft10.strDescription = @"Shipping will be charged on courier rates and are determined by the size, weight and destination of the package.";
    data_aft10.isSelected = 0;
    
    DataHolder *data_aft11 = [[DataHolder alloc] init];
    data_aft11.strDescription = @"Please also note for international shipments from India the additional charges calculated are only till the destination port. Import-related duties, taxes delivery and any other charges, wherever applicable, will be directly paid by the buyer.";
    data_aft11.isSelected = 0;
    
    //After Sale -> Duties & Taxes
    DataHolder *data_aft12 = [[DataHolder alloc] init];
    data_aft12.strDescription = @"Duties & Taxes";
    data_aft12.isSelected = 1;
    
    DataHolder *data_aft13 = [[DataHolder alloc] init];
    data_aft13.strDescription = @"All duties and taxes shall be borne by the buyer.";
    data_aft13.isSelected = 0;
    
    DataHolder *data_aft14 = [[DataHolder alloc] init];
    data_aft14.strDescription = @"All sales in India shall attract 13.5% VAT on the winning bid and 14% service tax and 0.5% swachh bharat cess and 0.5% krishi kalyan cess on the buyer's premium International sales.";
    data_aft14.isSelected = 0;
    
    DataHolder *data_aft15 = [[DataHolder alloc] init];
    data_aft15.strDescription = @"There shall be no VAT and Service tax in International sales.";
    data_aft15.isSelected = 0;
    
    HowToBuy *data5 = [[HowToBuy alloc] init];
    data5.strTitle = @"After Sale";
    data5.arrSub = [[NSArray alloc] initWithObjects:data_aft1, data_aft2, data_aft3, data_aft4, data_aft5, data_aft6, data_aft7, data_aft8, data_aft9, data_aft10, data_aft11,
                    data_aft12, data_aft13, data_aft14, data_aft15, nil];
    
    //Payment
    DataHolder *str_pay = [[DataHolder alloc] init];
    str_pay.strDescription = @"Buyers will be required to complete payment within a period of 7 business days from the receipt of the invoice via email.";
    str_pay.isSelected = 0;
    
    HowToBuy *data6 = [[HowToBuy alloc] init];
    data6.strTitle = @"Payment";
    data6.arrSub = [[NSArray alloc] initWithObjects:str_pay, nil];
    
    //Delivery / collection of purchase
    DataHolder *str_deli1 = [[DataHolder alloc] init];
    str_deli1.strDescription = @"Works will be shipped within 7 days of the payment being cleared. Buyers may choose to collect their purchase from AstaGuru in Mumbai within 7 days from the date of the sale.";
    str_deli1.isSelected = 0;
    
    DataHolder *str_deli2 = [[DataHolder alloc] init];
    str_deli2.strDescription = @"Buyers who have completed payment formalities and have not taken delivery of their art works from AstaGuru within 30 days of the completion of payment formalities will be charged demurrage @ 2% per month on the value of the artworks. ";
    str_deli2.isSelected = 0;
    
    HowToBuy *data7 = [[HowToBuy alloc] init];
    data7.strTitle = @"Delivery / collection of purchase";
    data7.arrSub = [[NSArray alloc] initWithObjects:str_deli1, str_deli2, nil];
    
    //Participate in our next auctionarrParticipate
    DataHolder *str_part1 = [[DataHolder alloc] init];
    str_part1.strDescription = @"If you are interested in consigning works from your collection to our next sale, please contact us at contact@astaguru.com or at the auction help desk +912222048138 / 39";
    str_part1.isSelected = 0;
    
    DataHolder *str_part2 = [[DataHolder alloc] init];
    str_part2.strDescription =@"If you would like to stay informed of AstaGuru's upcoming events, please register with us online.";
    str_part2.isSelected = 0;
    
    HowToBuy *data8 = [[HowToBuy alloc] init];
    data8.strTitle = @"Participate in our next auction";
    data8.arrSub = [[NSArray alloc] initWithObjects:str_part1, str_part2, nil];
    
    arrHowToBuy = [[NSArray alloc] initWithObjects:data1, data2, data3, data4, data5, data6, data7, data8, nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrHowToBuy.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HowToBuy *objHowToBuy = [arrHowToBuy objectAtIndex:section];
    return  objHowToBuy.arrSub.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
   
   
        HowToBuy *objHowToBuy = [arrHowToBuy objectAtIndex:indexPath.section];
    
        DataHolder *objDataHolder = [objHowToBuy.arrSub objectAtIndex:indexPath.row];
    
        if (objDataHolder.isSelected == 0)
        {
            cell = [self.tableHowToBuy dequeueReusableCellWithIdentifier:@"TextWithOutIconCell"];
            
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
            cell = [self.tableHowToBuy dequeueReusableCellWithIdentifier:@"TitlesInSubTitlesCell"];
     
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TTTAttributedLabel *lblSubtitle = (TTTAttributedLabel*)[cell viewWithTag:11];
            lblSubtitle.extendsLinkTouchArea = YES;
            lblSubtitle.textAlignment = NSTextAlignmentJustified;
            lblSubtitle.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
            lblSubtitle.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
            lblSubtitle.numberOfLines = 0;
            lblSubtitle.text = objDataHolder.strDescription; // Repository URL will be automatically detected and linked
            return cell;
        }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HowToBuy *objHowToBuy = [arrHowToBuy objectAtIndex:section] ;
    CollapsedHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if(headerView == nil)
    {
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"  owner:self  options:nil] objectAtIndex:0];
    }
    headerView.lblTitle.text = objHowToBuy.strTitle;
    
    BOOL sectionIsOpen = [self.tableHowToBuy isOpenSection:section];
    
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

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
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
