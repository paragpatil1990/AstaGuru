//
//  ServicesViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ServicesViewController.h"
#import "DataHolder.h"
#import "TTTAttributedLabel.h"
#import "CollapsedHeaderView.h"

@interface ServicesViewController ()<TTTAttributedLabelDelegate>
{
    NSMutableArray *servicesArray;
}
@end

@implementation ServicesViewController

-(void)setUpNavigationItem
{
    self.title=@"Services";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    
    self.tableServices.estimatedRowHeight = 100.0;
    self.tableServices.rowHeight = UITableViewAutomaticDimension;
    self.tableServices.estimatedSectionHeaderHeight = 44;
    self.tableServices.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableServices.sectionFooterHeight = 1;

    [self setupServices];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableServices.delegate = self;
    self.tableServices.dataSource = self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.tableServices.delegate = nil;
    self.tableServices.dataSource = nil;
}

-(void)setupServices
{
    servicesArray = [[NSMutableArray alloc] init];
    
    DataHolder *data1 = [[DataHolder alloc] init];
    data1.strTitle = @"Auction";
    data1.strDescription = @"Established in the year 2008 AstaGuru, India's premium online auction house caters to a global clientele by conducting auctions for Modern & Contemporary Indian Art and have diversified over the period of time and curate auctions for Collectibles & Antiques as well. With an overall art management experience spanning over three decades we have amalgamated all our industry related knowledge and have molded it to function on a digital structure.\n\nWith the world becoming one big market place we provide a safe and secure platform ensuring the ambitions of art collectors are achieved. With a well trained and highly efficient team, artworks & collectible antiques are filtered and only the best creations are part of our auctions. Art is always born with a soul and it is our prerogative to safeguard its sanctity.";
    data1.isSelected = 0;
    [servicesArray addObject:data1];
    
    DataHolder *data2 = [[DataHolder alloc] init];
    data2.strTitle = @"Consultation";
    data2.strDescription = @"Knowledge translates into wisdom when shared, therefore our doors are always open for individuals who are keen about enriching their lives through art. Our knowledge and industry experience equips us to guide you with regards to your art & collectibles related conundrums, based on your preferences and needs we help you understand which artwork will best suit your senses or which artifact will blend in with your commercial or residential space.\n\nOur guiding force, Mr Vickram Sethi is an art connoisseur and has been associated with the world of art for over three decades. His valued insights are crucial, he not only takes into account the provenance but also has developed a keen eye to deduce and ascertain works with immense potential and seminal attributes. Art gets intertwined within the home it dwells in and its owner, we take pride in consulting and presiding this communion of joy.";
    data2.isSelected = 0;
    [servicesArray addObject:data2];

    
    DataHolder *data3 = [[DataHolder alloc] init];
    data3.strTitle = @"Restoration";
    data3.strDescription = @"Restoration is best left to the experts, considering this service entails the longevity of the artwork. Exposure to direct sunlight or moisture are deterrents and do not facilitate a conducive environment for storage and showcasing artworks of various mediums.\n\nWe therefore undertake restoration operations not only to salvage an artwork which may be tampered but also in order to give it a protective shield. Work of such delicacy is entrusted to our high skilled restoration team, so you can be at complete peace of mind when your possession is in our care.";
    data3.isSelected = 0;
    [servicesArray addObject:data3];
    
    DataHolder *data4 = [[DataHolder alloc] init];
    data4.strTitle = @"Valuation";
    data4.strDescription = @"Various parameters such as provenance, medium, period, subject, whether the artwork has been published and the overall condition, influence the value of the art work or collectibles. Since it is a niche market the advice and inputs from market experts are imperative to ascertain the true value of the creation.\n\nAt AstaGuru, we have a stringent process in place, research and investigation done by our team looks into all the impactful aspects, be it a piece of art ranging from canvas to paper or artifacts such as rare pens & exquisite timepieces. Once the condition and authenticity is looked into, its value is determined. Through the course of our journey we have horned our skills, combined with a structurally sound and real time process, we conduct an in depth analysis of the artwork or collectible before calculating its value.";
    data4.isSelected = 0;
    [servicesArray addObject:data4];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return servicesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;//servicesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataHolder *objDataHolder = servicesArray[indexPath.section];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TTTAttributedLabel *lbldesc = (TTTAttributedLabel*)[cell viewWithTag:11];
    lbldesc.extendsLinkTouchArea = YES;
    lbldesc.textAlignment = NSTextAlignmentJustified;
    lbldesc.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
    lbldesc.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    lbldesc.numberOfLines = 0;
    lbldesc.text = objDataHolder.strDescription; // Repository URL will be automatically detected and linked
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DataHolder *objDataHolder = servicesArray[section];
    CollapsedHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if(headerView == nil)
    {
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"  owner:self  options:nil]objectAtIndex:0];
    }
    headerView.lblTitle.text = objDataHolder.strTitle;
    
    BOOL sectionIsOpen = [self.tableServices isOpenSection:section];
    
    if (sectionIsOpen)
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-expanded.png"];
    }else
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-collapsed.png"];
    }
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    return v;//[UIView new];
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

- (void)didReceiveMemoryWarning
{
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
