//
//  OurValuattionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "OurValuattionViewController.h"
#import "clsAboutUs.h"
#import "OurValutionCollectionViewCell.h"
#import "SectionHeaderReusableView.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import "TTTAttributedLabel.h"
@interface OurValuattionViewController ()<MFMailComposeViewControllerDelegate, TTTAttributedLabelDelegate>
{
    NSMutableArray *arrFirst;
    NSMutableArray *arrSecond;
    NSMutableArray *arrThired;
}
@end

@implementation OurValuattionViewController

- (void)viewDidLoad
{
    //UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopNavigation"]];
    //[self.navigationItem setTitleView:titleView];
    
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    self.navigationItem.title=@"Our Valuation";
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    arrFirst=[[NSMutableArray alloc]init];
    arrSecond=[[NSMutableArray alloc]init];
    arrThired=[[NSMutableArray alloc]init];
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
    objclsAboutus1.strName=@"\nNumerous criteria such as the historical significance of the work, the rarity of the work, and its physical condition, have to be assessed before a true value can be assigned to the piece. Upon a thorough analysis of these numerous criteria, AstaGuru will provide the client with an estimated value of the work.";
    objclsAboutus1.strType=@"1";
    [arrFirst addObject:objclsAboutus1];
    
    clsAboutUs *objclsAboutus2=[[clsAboutUs alloc]init];
    objclsAboutus2.strName=@"Detailed study of pricing history for the artist since 1987";
    objclsAboutus2.strType=@"2";
    [arrSecond addObject:objclsAboutus2];
    
    clsAboutUs *objclsAboutus3=[[clsAboutUs alloc]init];
    objclsAboutus3.strName=@"Price comparison with other works of the artist from similar periods";
    objclsAboutus3.strType=@"2";
    [arrSecond addObject:objclsAboutus3];
    
    clsAboutUs *objclsAboutus4=[[clsAboutUs alloc]init];
    objclsAboutus4.strName=@"Price comparison with works by other contemporary artists";
    objclsAboutus4.strType=@"2";
    [arrSecond addObject:objclsAboutus4];
    
    clsAboutUs *objclsAboutus5=[[clsAboutUs alloc]init];
    objclsAboutus5.strName=@"Research on historical significance of the work.";
    objclsAboutus5.strType=@"2";
    [arrSecond addObject:objclsAboutus5];
    
    clsAboutUs *objclsAboutus6=[[clsAboutUs alloc]init];
    objclsAboutus6.strName=@"Previous auction price references";
    objclsAboutus6.strType=@"2";
    [arrSecond addObject:objclsAboutus6];
    
    clsAboutUs *objclsAboutus7=[[clsAboutUs alloc]init];
    objclsAboutus7.strName=@"Current value estimation";
    objclsAboutus7.strType=@"2";
    [arrSecond addObject:objclsAboutus7];
    
    clsAboutUs *objclsAboutus8=[[clsAboutUs alloc]init];
    objclsAboutus8.strName=@"Liquidity rating & analysis (if required)";
    objclsAboutus8.strType=@"2";
    [arrSecond addObject:objclsAboutus8];
    
    
    clsAboutUs *objclsAboutus9=[[clsAboutUs alloc]init];
    objclsAboutus9.strName=@"Rarity & availability analysis (if required)";
    objclsAboutus9.strType=@"2";
    [arrSecond addObject:objclsAboutus9];
    
    clsAboutUs *objclsAboutus10=[[clsAboutUs alloc]init];
    objclsAboutus10.strName=@"Investment rationale (if required)";
    objclsAboutus10.strType=@"2";
    [arrSecond addObject:objclsAboutus10];
    
    
    clsAboutUs *objclsAboutus11=[[clsAboutUs alloc]init];
    objclsAboutus11.strName=@"A digital image";
    objclsAboutus11.strType=@"2";
    [arrThired addObject:objclsAboutus11];
    
    clsAboutUs *objclsAboutus12=[[clsAboutUs alloc]init];
    objclsAboutus12.strName=@"Complete description (artist's name, date, medium, measurements)";
    objclsAboutus12.strType=@"2";
    [arrThired addObject:objclsAboutus12];
    clsAboutUs *objclsAboutus13=[[clsAboutUs alloc]init];
    objclsAboutus13.strName=@"Provenance";
    objclsAboutus13.strType=@"2";
    [arrThired addObject:objclsAboutus13];
    clsAboutUs *objclsAboutus14=[[clsAboutUs alloc]init];
    objclsAboutus14.strName=@"Exhibition and publication history";
    objclsAboutus14.strType=@"2";
    [arrThired addObject:objclsAboutus14];
    
    clsAboutUs *objclsAboutus15=[[clsAboutUs alloc]init];
    objclsAboutus15.strName=@"We charge per hour or per artwork. Our fees are not related to the value of the collection. We are happy to provide estimates without obligation before beginning a valuation.";
    objclsAboutus15.strType=@"1";
    [arrThired addObject:objclsAboutus15];
    
    clsAboutUs *objclsAboutus16=[[clsAboutUs alloc]init];
    objclsAboutus16.strName=@"Client confidentiality is of paramount importance to us. We work with insurers, banks, and law firms who greatly value client privacy and rely on us to preserve it";
    objclsAboutus16.strType=@"1";
    [arrThired addObject:objclsAboutus16];
    
    
   
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return arrFirst.count;
    }
    else if (section==1)
    {
        return arrSecond.count;
    }
    else if (section==2)
    {
        return arrThired.count;
    }
    else
    {
    return 1;
    }
    
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell *cell3;
    OurValutionCollectionViewCell *OurValutioncell;
    
    //static NSString *identifier = @"Cell";
    
    if (indexPath.section==3)
    {
        UICollectionViewCell  *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"contactcell" forIndexPath:indexPath];
        
        TTTAttributedLabel *lblemail = (TTTAttributedLabel *)[cell2 viewWithTag:12];
        lblemail.userInteractionEnabled = YES;
        lblemail.extendsLinkTouchArea = YES;
        lblemail.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblemail.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblemail.text = @"siddanth@theartstrust.com";
        TTTAttributedLabel *lblphone = (TTTAttributedLabel *)[cell2 viewWithTag:11];
        lblphone.userInteractionEnabled = YES;
        lblphone.extendsLinkTouchArea = YES;
        lblphone.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
        lblphone.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
        lblphone.text = @"+91 22 2204 8138 / 39 , +91 22 2204 8140";
        return cell2;
    }
    else
    {
        OurValutioncell= [collectionView dequeueReusableCellWithReuseIdentifier:@"valuation" forIndexPath:indexPath];
        
        clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
        
        if (indexPath.section==0)
        {
            objAboutUs=[arrFirst objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==1)
        {
            objAboutUs=[arrSecond objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==2)
        {
            objAboutUs=[arrThired objectAtIndex:indexPath.row];
        }
        
        if ([objAboutUs.strType intValue]==1)
        {
            OurValutioncell.wtImageConstant.constant=-8;
        }
        else
        {
            OurValutioncell.wtImageConstant.constant=15;
        }
        
        //OurValutioncell.lblTitle.text=objAboutUs.strName;
        
        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
        paragraphStyles.alignment                = NSTextAlignmentJustified;    // To justified text
        paragraphStyles.firstLineHeadIndent      = 0.05;    // IMP: must have a value to make it work
        
        NSString *stringTojustify                = objAboutUs.strName;
        NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles};
        NSAttributedString *attributedString     = [[NSAttributedString alloc] initWithString:stringTojustify attributes:attributes];
        
        OurValutioncell.lblTitle.attributedText             = attributedString;
        OurValutioncell.lblTitle.numberOfLines              = 0;
        [OurValutioncell.lblTitle sizeToFit];
        
        
        
        return OurValutioncell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
    
    if (indexPath.section==3)
    {
       return CGSizeMake(collectionView1.frame.size.width, 145);
    }
    else
    {
    if (indexPath.section==0)
    {
        objAboutUs=[arrFirst objectAtIndex:indexPath.row];
    }
    else if(indexPath.section==1)
    {
        objAboutUs=[arrSecond objectAtIndex:indexPath.row];
    }
    else if(indexPath.section==2)
    {
        objAboutUs=[arrThired objectAtIndex:indexPath.row];
    }

    
    CGSize maximumLabelSize;
    if ([objAboutUs.strType intValue]==1)
    {
        maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-29, FLT_MAX);
        CGRect labelRect = [objAboutUs.strName
                            boundingRectWithSize:maximumLabelSize
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{
                                         NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Regular" size:16]
                                         }
                            context:nil];
        float height11= labelRect.size.height;
        return CGSizeMake(collectionView1.frame.size.width, height11+10);
    }
    else
    {
            maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-44, FLT_MAX);
        CGRect labelRect = [objAboutUs.strName
                            boundingRectWithSize:maximumLabelSize
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{
                                         NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Regular" size:16]
                                         }
                            context:nil];
        
        float height11= labelRect.size.height;
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
            headerView.title.text =@"The valuation process involves the following";
        }
        else  if (indexPath.section==2)
        {
            headerView.title.text =@" What we need for a valuation?";
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
        return CGSizeZero;
    }
   else if (section==3)
    {
       return CGSizeMake(CGRectGetWidth(collectionView.bounds), 20);
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50);
    }
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    NSString *numberString = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]; //@"+91 7875512881";
    //        NSURL *phoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", numberString]];
    
    //        // Whilst this version will return you to your app once the phone call is over.
//    NSURL *phoneNumber_Url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    
    
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
    
    //    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
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

- (IBAction)btnPhone:(id)sender
{
    NSString *phNo = @"+912222048138";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    [[UIApplication sharedApplication] openURL:phoneUrl];
    /*if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
       UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }*/
}

@end
