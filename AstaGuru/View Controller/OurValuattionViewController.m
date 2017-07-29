//
//  OurValuattionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "OurValuattionViewController.h"
//#import "AboutUs.h"
//#import "SectionHeaderReusableView.h"
//#import "SWRevealViewController.h"
//#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import "TTTAttributedLabel.h"
#import "DataHolder.h"

@interface OurValuattionViewController ()<MFMailComposeViewControllerDelegate, TTTAttributedLabelDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *arrHeader;
    NSArray *arrValuation;
    NSMutableArray *arrValuationProcress;
    NSMutableArray *arrValuationNeed;
    NSArray *arrValuationDsec;
}
@end

@implementation OurValuattionViewController

-(void)setUpNavigationItem
{
    self.title=@"Our Valuation";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNavigationItem];

    self.tableValuation.estimatedRowHeight = 100.0;
    self.tableValuation.rowHeight = UITableViewAutomaticDimension;
    self.tableValuation.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableValuation.estimatedSectionHeaderHeight = 44;
    self.tableValuation.sectionFooterHeight = 0;
    UIView *view = [[UIView alloc] init] ;
    view.backgroundColor = [UIColor whiteColor];
    CGRect hFrame = self.tableValuation.tableHeaderView.frame;
    hFrame.size.height = 10;
    view.frame = hFrame;
    [self.tableValuation setTableHeaderView:view];
    [self.tableValuation setTableFooterView:view];
    
    [self createArray];
}

-(void)createArray
{
    //Array header
    arrHeader = [[NSArray alloc] initWithObjects:@"", @"The valuation process involves the following", @"What we need for a valuation?", @"", @"", nil];
    //Array Valuation.
    arrValuation = [[NSArray alloc] initWithObjects:@"Numerous criteria such as the historical significance of the work, the rarity of the work, and its physical condition, have to be assessed before a true value can be assigned to the piece. Upon a thorough analysis of these numerous criteria, AstaGuru will provide the client with an estimated value of the work.", nil];
    
    //Array Valuation Procress.
    arrValuationProcress = [[NSMutableArray alloc]init];
    DataHolder *data2 = [[DataHolder alloc] init];
    data2.strDescription = @"Detailed study of pricing history for the artist since 1987";
    [arrValuationProcress addObject:data2];
    
    DataHolder *data3 = [[DataHolder alloc] init];
    data3.strDescription = @"Price comparison with other works of the artist from similar periods";
    [arrValuationProcress addObject:data3];
    
    DataHolder *data4 = [[DataHolder alloc] init];
    data4.strDescription = @"Price comparison with works by other contemporary artists";
    [arrValuationProcress addObject:data4];
    
    
    DataHolder *data5 = [[DataHolder alloc] init];
    data5.strDescription = @"Research on historical significance of the work.";
    [arrValuationProcress addObject:data5];
    
    DataHolder *data6 = [[DataHolder alloc] init];
    data6.strDescription = @"Previous auction price references";
    [arrValuationProcress addObject:data6];
    
    DataHolder *data7 = [[DataHolder alloc] init];
    data7.strDescription = @"Current value estimation";
    [arrValuationProcress addObject:data7];
    
    DataHolder *data8 = [[DataHolder alloc] init];
    data8.strDescription = @"Liquidity rating & analysis (if required)";
    [arrValuationProcress addObject:data8];
    
    DataHolder *data9 = [[DataHolder alloc] init];
    data9.strDescription = @"Rarity & availability analysis (if required)";
    [arrValuationProcress addObject:data9];
    
    DataHolder *data10 = [[DataHolder alloc] init];
    data10.strDescription = @"Investment rationale (if required)";
    [arrValuationProcress addObject:data10];
    
    //Valuation need.
    arrValuationNeed = [[NSMutableArray alloc] init];
    DataHolder *data11 = [[DataHolder alloc] init];
    data11.strDescription = @"A digital image";
    [arrValuationNeed addObject:data11];
    
    DataHolder *data12 = [[DataHolder alloc] init];
    data12.strDescription = @"Complete description (artist's name, date, medium, measurements)";
    [arrValuationNeed addObject:data12];
    
    DataHolder *data13 = [[DataHolder alloc] init];
    data13.strDescription = @"Provenance";
    [arrValuationNeed addObject:data13];
    
    DataHolder *data14 = [[DataHolder alloc] init];
    data14.strDescription = @"Exhibition and publication history";
    [arrValuationNeed addObject:data14];
    
    //Array valuation Desc.
    arrValuationDsec = [[NSArray alloc] initWithObjects:@"We charge per hour or per artwork. Our fees are not related to the value of the collection. We are happy to provide estimates without obligation before beginning a valuation.\n\nClient confidentiality is of paramount importance to us. We work with insurers, banks, and law firms who greatly value client privacy and rely on us to preserve it", nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {
        return arrValuation.count;
    }
    else if (section == 1)
    {
        return arrValuationProcress.count;
    }
    else if (section == 2)
    {
        return arrValuationNeed.count;
    }
    else if (section == 3)
    {
        return arrValuationDsec.count;
    }
    else
    {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([arrHeader[section] isEqualToString:@""])
    {
        return 0;
    }
    return UITableViewAutomaticDimension;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 4)
//    {
//        return 10;
//    }
//    return 0;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    UILabel *lblHeader = (UILabel*)[headerCell viewWithTag:11];
    lblHeader.text = arrHeader[section];
    headerCell.backgroundColor = [UIColor whiteColor];
    return headerCell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] init] ;//]WithFrame:hFrame];
////    view.backgroundColor = [UIColor redColor];
//    CGRect hFrame = self.tableValuation.tableFooterView.frame;
//    hFrame.size.height = 1;
//    view.frame = hFrame;
//    return view;//[UIView new];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            UILabel *lblValuation = (UILabel*)[cell viewWithTag:11];
            lblValuation.text = arrValuation[indexPath.row];
        }
        break;
        case 1:
        {
            DataHolder *data = arrValuationProcress[indexPath.row];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ValuationCell"];
            UILabel *lblValuation = (UILabel*)[cell viewWithTag:12];
            lblValuation.text = data.strDescription;
        }
        break;
        case 2:
        {
            DataHolder *data = arrValuationNeed[indexPath.row];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ValuationCell"];
            UILabel *lblvaluation = (UILabel*)[cell viewWithTag:12];
            lblvaluation.text = data.strDescription;
        }
        break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            UILabel *lblValuation = (UILabel*)[cell viewWithTag:11];
            lblValuation.text = arrValuationDsec[indexPath.row];
        }
        break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
            
            TTTAttributedLabel *lblEmail = (TTTAttributedLabel*)[cell viewWithTag:11];
            lblEmail.extendsLinkTouchArea = YES;
            lblEmail.userInteractionEnabled = YES;
            lblEmail.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
            lblEmail.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
            lblEmail.text = lblEmail.text;
            
            TTTAttributedLabel *lblMob = (TTTAttributedLabel*)[cell viewWithTag:12];
            lblMob.extendsLinkTouchArea = YES;
            lblMob.userInteractionEnabled = YES;
            lblMob.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
            lblMob.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
            lblMob.text = lblMob.text;
        }
        break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    
//    return 4;
//    
//}


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    UICollectionViewCell *cell3;
//    OurValutionCollectionViewCell *OurValutioncell;
//    
//    //static NSString *identifier = @"Cell";
//    
//    if (indexPath.section==3)
//    {
//        UICollectionViewCell  *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"contactcell" forIndexPath:indexPath];
//        
//        TTTAttributedLabel *lblemail = (TTTAttributedLabel *)[cell2 viewWithTag:12];
//        lblemail.userInteractionEnabled = YES;
//        lblemail.extendsLinkTouchArea = YES;
//        lblemail.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
//        lblemail.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
//        lblemail.text = @"siddanth@theartstrust.com";
//        TTTAttributedLabel *lblphone = (TTTAttributedLabel *)[cell2 viewWithTag:11];
//        lblphone.userInteractionEnabled = YES;
//        lblphone.extendsLinkTouchArea = YES;
//        lblphone.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
//        lblphone.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
//        lblphone.text = @"+91 22 2204 8138 / 39 , +91 22 2204 8140";
//        return cell2;
//    }
//}


#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    NSString *numberString = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",numberString]];
    // Now that we have our `phoneNumber` as a URL. We need to check that the device we are using can open the URL.
    // Whilst iPads, iPhone, iPod touchs can all open URLs in safari mobile they can't all
    // open URLs that are numbers this is why we have `tel://` or `telprompt://`
    if([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        // So if we can open it we can now actually open it with
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];
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

- (IBAction)btnEmail:(id)sender
{
    
    MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
    [composer setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail]) {
        [composer setToRecipients:[NSArray arrayWithObjects:@"siddanth@theartstrust.com", nil]];
        [composer setSubject:[NSString stringWithFormat:@""]];
        
        //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
        NSString *message=@"";
        
        [composer setMessageBody:message isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
    }
    else {
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
