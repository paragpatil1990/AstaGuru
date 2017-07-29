//
//  VacanciesViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/11/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "VacanciesViewController.h"
#import "HowToBuy.h"
#import "DataHolder.h"
#import "CollapsedHeaderView.h"
#import "TTTAttributedLabel.h"
#import "ApplyNowViewController.h"

@interface VacanciesViewController ()<TTTAttributedLabelDelegate>
{
    NSArray *arrVacanicies;
}


@end

@implementation VacanciesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableVacancies.estimatedRowHeight = 100.0;
    self.tableVacancies.rowHeight = UITableViewAutomaticDimension;
    self.tableVacancies.estimatedSectionHeaderHeight = 44;
    self.tableVacancies.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    [self getVacancies];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableVacancies.delegate = self;
    self.tableVacancies.dataSource = self;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.tableVacancies.delegate = nil;
    self.tableVacancies.dataSource = nil;
    
}


-(void)getVacancies
{
    NSString  *url = [NSString stringWithFormat:@"jobs?api_key=%@", [GlobalClass apiKey]];
        [GlobalClass call_tableGETWebURL:url parameters:nil view:self.view success:^(id responseObject){
            arrVacanicies = [self parseVacancies:[responseObject valueForKey:@"resource"]];
            if (arrVacanicies.count == 0)
            {
                [GlobalClass showTost:@"There is no vacancies"];
            }
            [self.tableVacancies reloadData];
        } failure:^(NSError *error){
            [GlobalClass showTost:error.localizedDescription];
        } callingCount:0];
}

-(NSArray*)parseVacancies:(NSArray*)json
{
    NSMutableArray *arrVacancie = [[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        NSDictionary *dictLib = [json objectAtIndex:j];
        dictLib=[GlobalClass removeNullOnly:dictLib];
        
        NSArray *arrkeys = [dictLib allKeys];
        
        NSArray *arrSubTitle = @[@"Job Salary",@"Joining Time",@"Job Description",@"Functional Skills",@"Job Experience",@"Job Title",@"Technical Skills",@"Business Unit",@"Job Responsibility"];
        
        NSMutableArray *arrSub = [[NSMutableArray alloc] init];
        
        for (int i=0; i<arrkeys.count; i++)
        {
            NSString *strKey  = [[arrkeys objectAtIndex:i] lowercaseString];
            for (int k=0; k < arrSubTitle.count; k++)
            {
                NSString *strSubTitle  = [[arrSubTitle objectAtIndex:k] lowercaseString];
                NSString *strSubTitleWithoutspace = [strSubTitle stringByReplacingOccurrencesOfString:@" " withString:@""];
                if ([strKey containsString:strSubTitleWithoutspace])
                {
                    DataHolder *data = [[DataHolder alloc] init];
                    data.strDescription = [arrSubTitle objectAtIndex:k];
                    data.isSelected = 1;
                    
                    if (![strKey isEqualToString:@"jobID"])
                    {
                        DataHolder *dataDesc = [[DataHolder alloc] init];
                        dataDesc.strDescription = [dictLib valueForKey:[arrkeys objectAtIndex:i]];
                        dataDesc.isSelected = 0;
                        
                        [arrSub addObject:data];
                        [arrSub addObject:dataDesc];
                    }
                    break;
                }
            }
        }
        
        DataHolder *dataApply = [[DataHolder alloc] init];
        dataApply.isSelected = 3;
        [arrSub addObject:dataApply];
        
        HowToBuy *objHowtoby=[[HowToBuy alloc]init];
        objHowtoby.strTitle = [dictLib valueForKey:@"jobTitle"];
        objHowtoby.arrSub = arrSub;

        [arrVacancie addObject:objHowtoby];
    }
    return arrVacancie;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrVacanicies.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HowToBuy *objHowToBuy = [arrVacanicies objectAtIndex:section];
    return  objHowToBuy.arrSub.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    HowToBuy *objHowToBuy = [arrVacanicies objectAtIndex:indexPath.section];
    
    DataHolder *objDataHolder = [objHowToBuy.arrSub objectAtIndex:indexPath.row];
    
    if (objDataHolder.isSelected == 0)
    {
        cell = [self.tableVacancies dequeueReusableCellWithIdentifier:@"TextCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //NSString *text=objHowToBuy.Titlel;
        TTTAttributedLabel *lblDesc = (TTTAttributedLabel *)[cell viewWithTag:11];
        lblDesc.extendsLinkTouchArea = YES;
        lblDesc.textAlignment = NSTextAlignmentJustified;
        lblDesc.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblDesc.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblDesc.numberOfLines = 0;
        lblDesc.text = objDataHolder.strDescription; // Repository URL will be automatically detected and linked
    }
    else if (objDataHolder.isSelected == 1)
    {
        cell = [self.tableVacancies dequeueReusableCellWithIdentifier:@"TitlesInSubTitlesCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TTTAttributedLabel *lblSubtitle = (TTTAttributedLabel*)[cell viewWithTag:11];
        lblSubtitle.extendsLinkTouchArea = YES;
        lblSubtitle.textAlignment = NSTextAlignmentJustified;
        lblSubtitle.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblSubtitle.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblSubtitle.numberOfLines = 0;
        lblSubtitle.text = objDataHolder.strDescription; // Repository URL will be automatically detected and linked
    }
    else
    {
        cell = [self.tableVacancies dequeueReusableCellWithIdentifier:@"ApplyNowCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == arrdata.count)
//    {
//        return 118;
//    }
//    else
//    {
//        return 40;
//    }
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HowToBuy *objHowToBuy = [arrVacanicies objectAtIndex:section] ;
    CollapsedHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if(headerView == nil)
    {
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"  owner:self  options:nil]objectAtIndex:0];
    }
    headerView.lblTitle.text = objHowToBuy.strTitle;
    
    BOOL sectionIsOpen = [self.tableVacancies isOpenSection:section];
    
    if (sectionIsOpen)
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-expanded.png"];
    }else
    {
        headerView.imgCheckbox.image=[UIImage imageNamed:@"icon-collapsed.png"];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    //    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
}

- (IBAction)btnApplyNowPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ApplyNowViewController *objClientRelationViewController = [storyboard instantiateViewControllerWithIdentifier:@"ApplyNowViewController"];
    [self.navigationController pushViewController:objClientRelationViewController animated:YES];
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
