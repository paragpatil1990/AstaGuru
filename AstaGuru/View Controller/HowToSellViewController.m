//
//  HowToSellViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/11/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "HowToSellViewController.h"
#import "HowToBuy.h"
#import "DataHolder.h"
#import "CollapsedHeaderView.h"
#import "TTTAttributedLabel.h"
#import "HowToSellSubmitDetailViewController.h"
@interface HowToSellViewController ()<TTTAttributedLabelDelegate>
{
    NSArray *arrHowToSell;
}


@end

@implementation HowToSellViewController

-(void)setUpNavigationItem
{
    self.title=@"How To Sell";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    [self setupHowToSellArray];
    
    self.tableHowToSell.estimatedRowHeight = 100.0;
    self.tableHowToSell.rowHeight = UITableViewAutomaticDimension;
    self.tableHowToSell.estimatedSectionHeaderHeight = 44;
    self.tableHowToSell.sectionHeaderHeight = UITableViewAutomaticDimension;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableHowToSell.delegate = self;
    self.tableHowToSell.dataSource = self;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.tableHowToSell.delegate = nil;
    self.tableHowToSell.dataSource = nil;

}

-(void)setupHowToSellArray
{
    //Evaluation
    DataHolder *eva_Data1 = [[DataHolder alloc]init];
    eva_Data1.strDescription = @"The first step in the process is to arrange a consultation with one of our representatives. You can contact us or email us with details of your property. We shall then study the property and give you a valuation on the same. We will respond to your auction estimate request within 3 working days. It is very important to AstaGuru to provide the highest level of service; accordingly, we cannot rush valuations.";
    eva_Data1.isSelected = 0;
    
    HowToBuy *data1 = [[HowToBuy alloc] init];
    data1.strTitle = @"Evaluation";
    data1.arrSub = @[eva_Data1];
    
    //Decision to sell
    DataHolder *deci_Data1 = [[DataHolder alloc]init];
    deci_Data1.strDescription = @"Based on the valuation result, you and AstaGuru' s experts will decide whether your property is appropriate for sale at auction. We will also recommend an appropriate venue and possible sale timing. If you decide to proceed, you will sign a contract, and AstaGuru will take the property in for cataloguing and photography.";
    deci_Data1.isSelected = 0;

    HowToBuy *data2 = [[HowToBuy alloc] init];
    data2.strTitle = @"Decision to sell";
    data2.arrSub = @[deci_Data1];
    
    //Logistics
    DataHolder *log_Data1 = [[DataHolder alloc]init];
    log_Data1.strDescription = @"Our Art Transport or Shipping Department can help you arrange to have your property delivered to our offices, if necessary. As the consignor, you are responsible for packing, shipping and insurance charges.";
    log_Data1.isSelected = 0;
    
    HowToBuy *data3 = [[HowToBuy alloc] init];
    data3.strTitle = @"Logistics";
    data3.arrSub = @[log_Data1];
    
    //Reserve Price
    DataHolder *res_Data1 = [[DataHolder alloc]init];
    res_Data1.strDescription = @"The reserve is the confidential minimum selling price to which a consignor (you) and AstaGuru agree before the sale - your property's 'floor' price, below which no bid will be accepted. If bidding on your item fails to reach the reserve, we will not sell the piece and will advise you of your options. It is important to consider the reserve price in light of the fact that AstaGuru will assess fees and handling costs for unsold lots.";
    res_Data1.isSelected = 0;
    
    HowToBuy *data4 = [[HowToBuy alloc] init];
    data4.strTitle = @"Reserve Price";
    data4.arrSub = @[res_Data1];
    
    
    //Seller’s Contract
    DataHolder *sell_Data1 = [[DataHolder alloc]init];
    sell_Data1.strDescription = @"The seller contract covers two important issues that will affect your bottom line: the reserve price and AstaGuru's commissions.";
    sell_Data1.isSelected = 0;
    
    DataHolder *sell_Data2 = [[DataHolder alloc]init];
    sell_Data2.strDescription = @"Reserve price.";
    sell_Data2.isSelected = 1;
    
    DataHolder *sell_Data3 = [[DataHolder alloc]init];
    sell_Data3.strDescription = @"The reserve is the confidential minimum selling price to which a consignor (you) and AstaGuru agree before the sale - your property's 'floor' price, below which no bid will be accepted. If bidding on your item fails to reach the reserve, we will not sell the piece and will advise you of your options. It is important to consider the reserve price in light of the fact that AstaGuru will assess fees and handling costs for unsold lots.";
    sell_Data3.isSelected = 0;
    
    DataHolder *sell_Data4 = [[DataHolder alloc]init];
    sell_Data4.strDescription = @"Seller's commission";
    sell_Data4.isSelected = 1;
    
    DataHolder *sell_Data5 = [[DataHolder alloc]init];
    sell_Data5.strDescription = @"Sellers pay a commission that is deducted, along with any agreed-upon expenses, from the hammer price. Should you have any specific questions regarding the selling commission, please call the appropriate representative for more information.";
    sell_Data5.isSelected = 0;
    
    HowToBuy *data5 = [[HowToBuy alloc] init];
    data5.strTitle = @"Seller’s Contract";
    data5.arrSub = @[sell_Data1, sell_Data2, sell_Data3, sell_Data4, sell_Data5];
    
    //Payment
    DataHolder *pay_Data1 = [[DataHolder alloc]init];
    pay_Data1.strDescription = @"Shortly after the sale, you will receive a listing of the final hammer price for each item you consigned. We will issue the payment within 40 days from the day of the sale provided we are in receipt of the buyer's payment.";
    pay_Data1.isSelected = 0;
    
    HowToBuy *data6 = [[HowToBuy alloc] init];
    data6.strTitle = @"Payment";
    data6.arrSub = @[pay_Data1];
    
    arrHowToSell = @[data1, data2, data3, data4, data5, data6];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrHowToSell.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == arrHowToSell.count)
    {
        return 0;
    }
    HowToBuy *objHowToBuy = [arrHowToSell objectAtIndex:section];
    return  objHowToBuy.arrSub.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;

    HowToBuy *objHowToBuy = [arrHowToSell objectAtIndex:indexPath.section];
    
    DataHolder *objDataHolder = [objHowToBuy.arrSub objectAtIndex:indexPath.row];
    
    if (objDataHolder.isSelected == 0)
    {
        cell = [self.tableHowToSell dequeueReusableCellWithIdentifier:@"TextWithOutIconCell"];
        
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
        cell = [self.tableHowToSell dequeueReusableCellWithIdentifier:@"TitlesInSubTitlesCell"];
        
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
    if (section == arrHowToSell.count)
    {
        //  return [UIView new];;
        UITableViewCell* cell = [self.tableHowToSell dequeueReusableCellWithIdentifier:@"HowToSellCell"];
        return cell;
    }
    
    HowToBuy *objHowToBuy = [arrHowToSell objectAtIndex:section] ;
    CollapsedHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if(headerView == nil)
    {
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"  owner:self  options:nil]objectAtIndex:0];
    }
    headerView.lblTitle.text = objHowToBuy.strTitle;
    
    BOOL sectionIsOpen = [self.tableHowToSell isOpenSection:section];
    
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

- (IBAction)btnSubmitDetailPressed:(UIButton*)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HowToSellSubmitDetailViewController *objHowToSellSubmitDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"HowToSellSubmitDetailViewController"];
    [self.navigationController pushViewController:objHowToSellSubmitDetailViewController animated:YES];
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
