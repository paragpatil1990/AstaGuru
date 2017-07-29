//
//  AboutUsViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUs.h"
#import "SectionHeaderReusableView.h"
#import "AboutUsCollectionViewCell.h"

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface AboutUsViewController ()<MFMailComposeViewControllerDelegate, AboutUsDelegate>
{
    NSMutableArray *arrManagement;
    NSMutableArray *arrSpecialities;
//    int height;
    NSString *strintro;
}
@end

@implementation AboutUsViewController

-(void)setUpNavigationItem
{
    self.title=@"About Us";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self createArrayManagement];
    [self createArraySpecialities];
    
    strintro = @"\nAstaGuru was conceptualised in the year 2008 functioning as a safe and secure platform to conduct online auctions for 'Contemporary & Modern Indian Art', as well as vintage collectibles and rear antiques such as sculptures, classic miniatures paintings, fine writing instruments, timepieces, celebrity memorabilia and aristocratic jewelry. The word AstaGuru is a combination of Asta which means auction in Italian and Guru which indicates our mastery at conducting the same.\n\nWith the world becoming whole on a digital level, we are able to showcase Indian Art & Antiques, hereby successfully linking the perspective buyer and consignor without any geographic constraints. Our stringent selection process ensures only prime artworks & exquisite antiques are part of our auctions. Numerous parameters such as the provenance of the work, the rarity of the work, and its physical condition are assessed before their inclusion in our auctions.\n\nUnder the leadership of Mr Vickram Sethi, founder & chairman of The Arts Trust, Institute of Contemporary Indian Art Gallery, Mumbai & AstaGuru and Mr Tushar Sethi, CEO AstaGuru, we are treading towards a horizon filled with Art, Antiques & Bliss.\n\nTheir keen eye and impeccable knowledge leverages us with insights of current & future trends. Our aim is to manifest Indian Art globally and create a conducive environment that spurts its growth.";
}

-(void)closePressed
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}

-(void)createArrayManagement
{
    arrManagement = [[NSMutableArray alloc]init];

    AboutUs *objclsAboutus1=[[AboutUs alloc]init];
    objclsAboutus1.strimage=@"img-vickram-1";
    objclsAboutus1.strName=@"Vickram Sethi";
    objclsAboutus1.strPost=@"Chairman";
    objclsAboutus1.strType=@"1";
    [arrManagement addObject:objclsAboutus1];
    
    AboutUs *objclsAboutus2=[[AboutUs alloc]init];
    objclsAboutus2.strimage=@"img-tushar-2";
    objclsAboutus2.strName=@"Tushar Sethi";
    objclsAboutus2.strPost=@"CEO";
    objclsAboutus2.strType=@"1";
    [arrManagement addObject:objclsAboutus2];
    
    AboutUs *objclsAboutus3=[[AboutUs alloc]init];
    objclsAboutus3.strimage=@"img-digamber-3";
    objclsAboutus3.strName=@"Digamber Sethi";
    objclsAboutus3.strPost=@"COO";
    objclsAboutus3.strType=@"1";
    [arrManagement addObject:objclsAboutus3];
}

-(void)createArraySpecialities
{
    arrSpecialities = [[NSMutableArray alloc]init];

    AboutUs *objclsAboutus1=[[AboutUs alloc]init];
    objclsAboutus1.strimage=@"img-sunny-4";
    objclsAboutus1.strName=@"Sunny Chandiramani";
    objclsAboutus1.strPost=@"Client Relations";
    objclsAboutus1.strType=@"2";
    objclsAboutus1.strEmail=@"sunny@astaguru.com";
    [arrSpecialities addObject:objclsAboutus1];
    
    AboutUs *objclsAboutus2=[[AboutUs alloc]init];
    objclsAboutus2.strimage=@"img-sonal-5";
    objclsAboutus2.strName=@"Sonal Patel";
    objclsAboutus2.strPost=@"Client Relations";
    objclsAboutus2.strType=@"2";
    objclsAboutus2.strEmail=@"sonal@astaguru.com";
    [arrSpecialities addObject:objclsAboutus2];
    
    AboutUs *objclsAboutus3=[[AboutUs alloc]init];
    objclsAboutus3.strimage=@"img-sneha-6";
    objclsAboutus3.strName=@"Sneha Gautam";
    objclsAboutus3.strPost=@"Client Relations";
    objclsAboutus3.strType=@"2";
    objclsAboutus3.strEmail=@"sneha@astaguru.com";
    [arrSpecialities addObject:objclsAboutus3];
    
    AboutUs *objclsAboutus4=[[AboutUs alloc]init];
    objclsAboutus4.strimage=@"img-razia-7";
    objclsAboutus4.strName=@"Razia Parveen";
    objclsAboutus4.strPost=@"Client Relations";
    objclsAboutus4.strType=@"2";
    objclsAboutus4.strEmail=@"razia@astaguru.com";
    [arrSpecialities addObject:objclsAboutus4];
    
    AboutUs *objclsAboutus5=[[AboutUs alloc]init];
    objclsAboutus5.strimage=@"img-ankita-8";
    objclsAboutus5.strName=@"Ankita Talreja";
    objclsAboutus5.strPost=@"Client Relations";
    objclsAboutus5.strType=@"2";
    objclsAboutus5.strEmail=@"ankita@astaguru.com";
    [arrSpecialities addObject:objclsAboutus5];
    
    AboutUs *objclsAboutus6=[[AboutUs alloc]init];
    objclsAboutus6.strimage=@"img-tahmina-9";
    objclsAboutus6.strName=@"Tahmina Lakhani";
    objclsAboutus6.strPost=@"Client Relations";
    objclsAboutus6.strType=@"2";
    objclsAboutus6.strEmail=@"tahmina@astaguru.com";
    [arrSpecialities addObject:objclsAboutus6];
    
    AboutUs *objclsAboutus7=[[AboutUs alloc]init];
    objclsAboutus7.strimage=@"img-siddanth-10";
    objclsAboutus7.strName=@"Siddanth Shetty";
    objclsAboutus7.strPost=@"V.P. Business Strategy & Operations";
    objclsAboutus7.strType=@"2";
    objclsAboutus7.strEmail=@"siddanth@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus7];

    AboutUs *objclsAboutus8=[[AboutUs alloc]init];
    objclsAboutus8.strimage=@"img-anthony-11";
    objclsAboutus8.strName=@"Anthony Diniz";
    objclsAboutus8.strPost=@"Administrator";
    objclsAboutus8.strType=@"2";
    objclsAboutus8.strEmail=@"anthony@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus8];
    
    AboutUs *objclsAboutus9=[[AboutUs alloc]init];
    objclsAboutus9.strimage=@"img-karthik-12";
    objclsAboutus9.strName=@"Karthik Lynch";
    objclsAboutus9.strPost=@"Logistics";
    objclsAboutus9.strType=@"2";
    objclsAboutus9.strEmail=@"karthik@atheartstrust.com";
    [arrSpecialities addObject:objclsAboutus9];

    AboutUs *objclsAboutus10=[[AboutUs alloc]init];
    objclsAboutus10.strimage=@"img-sidhant-13";
    objclsAboutus10.strName=@"Sidhant Nayangara";
    objclsAboutus10.strPost=@"Content Editor";
    objclsAboutus10.strType=@"2";
    objclsAboutus10.strEmail=@"s.nayangara@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus10];
    
    AboutUs *objclsAboutus11=[[AboutUs alloc]init];
    objclsAboutus11.strimage=@"img-radhika-14";
    objclsAboutus11.strName=@"Radhika Kerkar";
    objclsAboutus11.strPost=@"Research";
    objclsAboutus11.strType=@"2";
    objclsAboutus11.strEmail=@"radhika@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus11];
    
    AboutUs *objclsAboutus12=[[AboutUs alloc]init];
    objclsAboutus12.strimage=@"img-snehal-15";
    objclsAboutus12.strName=@"Snehal Pednekar";
    objclsAboutus12.strPost=@"Human Resource";
    objclsAboutus12.strType=@"2";
    objclsAboutus12.strEmail=@"snehal@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus12];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return arrManagement.count;
    }
    else if (section==2)
    {
        return 1;
    }
    else
    {
        return arrSpecialities.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.section==0)
    {
        AboutUsCollectionViewCell *descriptionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionCell" forIndexPath:indexPath];
        descriptionCell.lblTitle.text=strintro;
        descriptionCell.lblTitle.textAlignment = NSTextAlignmentJustified;
        cell = descriptionCell;
        
    }
    else if (indexPath.section==2)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LlineCell" forIndexPath:indexPath];
    }
    else
    {
        AboutUsCollectionViewCell *employeeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmployeeCell" forIndexPath:indexPath];
        
        AboutUs *objAboutUs;//=[[AboutUs alloc]init];
        
        if (indexPath.section==1)
        {
            objAboutUs = [arrManagement objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==3)
        {
            objAboutUs=[arrSpecialities objectAtIndex:indexPath.row];
        }
        
        employeeCell.img.image=[UIImage imageNamed:objAboutUs.strimage];
        employeeCell.lblTitle.text=objAboutUs.strName;
        employeeCell.lblDesignation.text=objAboutUs.strPost;
        
        if (indexPath.section==1)
        {
            employeeCell.btnEmail.hidden = YES;
        }
        else
        {
           employeeCell.btnEmail.hidden = NO;
        }
        employeeCell.objAboutUs = objAboutUs;
        employeeCell.delegate = self;
        cell = employeeCell;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        CGFloat width = (collectionView.frame.size.width/3);
        return CGSizeMake(width-6, 164);
    }
    else if (indexPath.section==2)
    {
        return CGSizeMake(collectionView.frame.size.width, 10);
    }
    else if(indexPath.section==3)
    {
        CGFloat width=(collectionView.frame.size.width/2);
        return CGSizeMake(width-6, 178);
    }
    else
    {
        CGSize maximumLabelSize = CGSizeMake(collectionView.frame.size.width-16, FLT_MAX);
        
        CGRect labelRect = [strintro
                            boundingRectWithSize:maximumLabelSize
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{
                                         NSFontAttributeName : [UIFont systemFontOfSize:17]
                                         }
                            context:nil];
        CGFloat height = labelRect.size.height;
        return CGSizeMake(collectionView.frame.size.width, height);
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
           headerView.title.text =@"Management";
        }
        else  if (indexPath.section==3)
        {
            headerView.title.hidden=NO;
            headerView.title.text =@"Specialists";
        }
        else
        {
            headerView.title.hidden=YES;
        }
        reusableview = headerView;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0 ||section==2)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 44);
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

-(void)didSendEmail:(AboutUs *)aboutus
{
    MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]) {
        [composer setToRecipients:[NSArray arrayWithObjects:aboutus.strEmail, nil]];
        [composer setSubject:[NSString stringWithFormat:@"Inquiry from Astaguru app"]];
        NSString *message=[NSString stringWithFormat:@"Hello %@,\n",aboutus.strName];
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
