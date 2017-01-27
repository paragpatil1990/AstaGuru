//
//  AboutUsViewController.m
//  AstaGuru
//
//  Created by sumit mashalkar on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AboutUsViewController.h"
#import "clsAboutUs.h"
#import "EGOImageView.h"
#import "SectionHeaderReusableView.h"
#import "AboutUsCollectionViewCell.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
@interface AboutUsViewController ()<MFMailComposeViewControllerDelegate,AboutUs>
{
    NSMutableArray *arrManagement;
    NSMutableArray *arrSpecialities;
    int height;
    NSString *strintro;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrManagement=[[NSMutableArray alloc]init];
    arrSpecialities=[[NSMutableArray alloc]init];
    //UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopNavigation"]];
    //[self.navigationItem setTitleView:titleView];
    self.navigationItem.title=@"About Us";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self CreateArray];
    int NoOfCol, NoOfCol2;
    if (arrManagement.count/3==0)
    {
        NoOfCol=(int)arrManagement.count/3;
    }
    else
    {
        NoOfCol=(int)(arrManagement.count/3)+1;
    }
    
    if (arrSpecialities.count/2==0)
    {
        NoOfCol2 = (int)arrSpecialities.count/2;
    }
    else
    {
        NoOfCol2 = (int)(arrSpecialities.count/2)+1;
    }
    
    
    strintro=@"\n\nAstaGuru was conceptualised in the year 2008, with the sole purpose of creating a safe and secure platform to conduct online auctions for 'Contemporary & Modern Indian Art', however we are constantly innovating & venturing into exciting new spectrums such as vintage collectibles and rear antiques, which include fine writing instruments, timepieces, celebrity memorabilia & aristocratic jewelry. The word AstaGuru is a combination of Asta which means auction in Italian and Guru which indicates our mastery at conducting the same. With the world becoming whole on a digital level, we are able to showcase Indian Art & Antiques with a prevalent legacy, on a global scale. Successfully linking the perspective buyer and consignor without any geographic constraints. With AstaGuru it is now possible for Art collectors and admirers to par take and get their fill of the exploding Indian Art culture. Our stringent selection process ensures only prime artworks & exquisite antiques are part of our auctions. Numerous criteria such as the provenance of the work, the rarity of the work, and its physical condition are assessed before their inclusion in our auctions.\n\nUnder the leadership of Mr Vickram Sethi, founder & chairman of The Arts Trust, Institute of Contemporary Indian Art Gallery, Mumbai & AstaGuru and Mr Tushar Sethi, CEO AstaGuru, we are treading towards a horizon filled with Art, Antiques & Bliss.\n\n Their keen eye and impeccable knowledge leverages us with insights of current & future trends. Our aim is to manifest Indian Art globally and create a conducive environment that spurts it's growth and to constantly reinvent ourselves in order to cater to the needs of our esteemed clientele.";
    
    float height11 = [self getHeightForText:_txtAboutUs.text
                                 withFont:_txtAboutUs.font
                                 andWidth:_txtAboutUs.frame.size.width];
   
    // Do any additional setup after loading the view.
    height=(NoOfCol*147)+(NoOfCol2*147)+80+height11;
    _scrContent.contentSize= CGSizeMake(_scrContent.frame.size.width, height);
    _viwinner.frame=CGRectMake(_viwinner.frame.origin.x, _viwinner.frame.origin.y, _viwinner.frame.size.width,height);
}
-(void)closePressed
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}
-(float) getHeightForText:(NSString*) text withFont:(UIFont*) font andWidth:(float)width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector])
    {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"WorkSans-Medium" size:17] }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    }
    else
    {
//        title_size = [text sizeWithFont:font
//                      constrainedToSize:constraint
//                          lineBreakMode:NSLineBreakByWordWrapping];
        
#ifdef __IPHONE_7_0
        
        title_size = [self frameForText:text sizeWithFont:font constrainedToSize:CGSizeMake(width,font.lineHeight) lineBreakMode:NSLineBreakByWordWrapping];
        
#else
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];

#endif
        totalHeight = title_size.height ;
    }
    CGFloat height1 = MAX(totalHeight, 40.0f);
    return height1;
}

-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17],
                                  NSParagraphStyleAttributeName:paragraphStyle
                                  };
    
    
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

-(void)CreateArray
{
    clsAboutUs *objclsAboutus1=[[clsAboutUs alloc]init];
    objclsAboutus1.strimage=@"img-vickram-sethi";
    objclsAboutus1.strName=@"Vickram Sethi";
    objclsAboutus1.strPost=@"Chairman";
    objclsAboutus1.strType=@"1";
    [arrManagement addObject:objclsAboutus1];
    
    clsAboutUs *objclsAboutus2=[[clsAboutUs alloc]init];
    objclsAboutus2.strimage=@"img-tushar-sethi";
    objclsAboutus2.strName=@"Tushar Sethi";
    objclsAboutus2.strPost=@"CEO";
    objclsAboutus2.strType=@"1";
    [arrManagement addObject:objclsAboutus2];
    
    clsAboutUs *objclsAboutus3=[[clsAboutUs alloc]init];
    objclsAboutus3.strimage=@"img-digamber-sethi";
    objclsAboutus3.strName=@"Digamber Sethi";
    objclsAboutus3.strPost=@"COO";
    objclsAboutus3.strType=@"1";
    [arrManagement addObject:objclsAboutus3];
    
    clsAboutUs *objclsAboutus4=[[clsAboutUs alloc]init];
    objclsAboutus4.strimage=@"img-sunny";
    objclsAboutus4.strName=@"Sunny Chandiramani";
    objclsAboutus4.strPost=@"Client Relations";
    objclsAboutus4.strType=@"2";
    objclsAboutus4.strEmail=@"sunny@theartstrust.com";
    
    [arrSpecialities addObject:objclsAboutus4];
    
    clsAboutUs *objclsAboutus9=[[clsAboutUs alloc]init];
    objclsAboutus9.strimage=@"img-sonal";
    objclsAboutus9.strName=@"Sonal Patel";
    objclsAboutus9.strPost=@"Client Relations";
    objclsAboutus9.strType=@"2";
    objclsAboutus9.strEmail=@"sonal@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus9];
    
    clsAboutUs *objclsAboutus5=[[clsAboutUs alloc]init];
    objclsAboutus5.strimage=@"img-sneha";
    objclsAboutus5.strName=@"Sneha Gautam";
    objclsAboutus5.strPost=@"Client Relations";
    objclsAboutus5.strType=@"2";
    objclsAboutus5.strEmail=@"sneha@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus5];
    
    clsAboutUs *objclsAboutus6=[[clsAboutUs alloc]init];
    objclsAboutus6.strimage=@"img-mamta";
    objclsAboutus6.strName=@"Mamta Rahate";
    objclsAboutus6.strPost=@"Client Relations";
    objclsAboutus6.strType=@"2";
    objclsAboutus6.strEmail=@"mamta@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus6];
    
    clsAboutUs *objclsAboutus7=[[clsAboutUs alloc]init];
    objclsAboutus7.strimage=@"img-siddanth";
    objclsAboutus7.strName=@"Siddanth Shetty";
    objclsAboutus7.strPost=@"V.P. Business Strategy & Operations";
    objclsAboutus7.strType=@"2";
    objclsAboutus7.strEmail=@"siddanth@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus7];
    
    clsAboutUs *objclsAboutus8=[[clsAboutUs alloc]init];
    objclsAboutus8.strimage=@"img-anthony";
    objclsAboutus8.strName=@"Anthony Diniz";
    objclsAboutus8.strPost=@"Administrator";
    objclsAboutus8.strType=@"2";
    objclsAboutus8.strEmail=@"anthony@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus8];
    
    clsAboutUs *objclsAboutus10=[[clsAboutUs alloc]init];
    objclsAboutus10.strimage=@"img-anandita";
    objclsAboutus10.strName=@"Anandita De";
    objclsAboutus10.strPost=@"Marketing PR & Business Developement";
    objclsAboutus10.strType=@"2";
    objclsAboutus10.strEmail=@"anandita@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus10];
    
    clsAboutUs *objclsAboutus11=[[clsAboutUs alloc]init];
    objclsAboutus11.strimage=@"img-tushar";
    objclsAboutus11.strName=@"Tushar Dalvi";
    objclsAboutus11.strPost=@"Marketing PR & Business Developement";
    objclsAboutus11.strType=@"2";
    objclsAboutus11.strEmail=@"tushar.dalvi@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus11];
    
    clsAboutUs *objclsAboutus12=[[clsAboutUs alloc]init];
    objclsAboutus12.strimage=@"nayangara.png";
    objclsAboutus12.strName=@"Sidhant Nayangara";
    objclsAboutus12.strPost=@"Content Editor";
    objclsAboutus12.strType=@"2";
    objclsAboutus12.strEmail=@"s.nayangara@theartstrust.com";
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
    UICollectionViewCell *cell3;
    AboutUsCollectionViewCell *cell1;
    if (indexPath.section==0)
    {
       // static NSString *identifier = @"cellone";
       
       cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellone" forIndexPath:indexPath];
      //  UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:12];
        cell1.lblTitle.text=strintro;
        cell1.lblTitle.textAlignment = NSTextAlignmentJustified;
        cell3=cell1;
        
    }
   else if (indexPath.section==2)
    {
        // static NSString *identifier = @"cellone";
        
      UICollectionViewCell  *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellline" forIndexPath:indexPath];
        //UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:12];

        cell3=cell2;
        
    }
    else
    {
    //static NSString *identifier = @"Cell";
    AboutUsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //AboutUsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
    
    if (indexPath.section==1)
    {
        objAboutUs=[arrManagement objectAtIndex:indexPath.row];
    }
    else if(indexPath.section==3)
    {
    objAboutUs=[arrSpecialities objectAtIndex:indexPath.row];
    }
    
    //EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
    //imgServices.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];
   cell.img.image=[UIImage imageNamed:objAboutUs.strimage];
    
    //UILabel *lblTitle = (UILabel *)[cell viewWithTag:12];
        //UIButton *btnEmail = (UIButton *)[cell viewWithTag:101];
        //btnEmail.tag=indexPath.row;
        /*[btnEmail addTarget:self
                   action:@selector(btnEmailClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        */
        
   cell.lblTitle.text=objAboutUs.strName;
    //lblPrice.text=[]
//    UILabel *lblDesignamtion = (UILabel *)[cell viewWithTag:13];
    cell.lblDesignation.text=objAboutUs.strPost;
        
//        UIImageView *imgemail = (EGOImageView *)[cell viewWithTag:14];
        if (indexPath.section==1)
        {
            cell.imgEmail.hidden=YES;
            cell.btnEmail.enabled = NO;
        }
        else
        {
            cell.imgEmail.hidden=NO;
            cell.btnEmail.enabled = YES;
        }
        cell.objAboutUs=objAboutUs;
        cell.AboutUsdelegate=self;
        cell3=cell;
    }
    return cell3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 2
    if (indexPath.section==1)
    {
        float width=(collectionView1.frame.size.width/3);
        NSLog(@"%f",width);
        
        return CGSizeMake(width-6, 145);
        
    }
    if (indexPath.section==2)
    {
        float width=(collectionView1.frame.size.width);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, 20);
        
    }
    else if(indexPath.section==3)
    {
        float width=(collectionView1.frame.size.width/2);
        NSLog(@"%f",width);
        
        return CGSizeMake(width-6, 147);
    }
    else
    {
        CGSize maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-16, FLT_MAX);
        
      // UIFont *font = [UIFont fontWithName:@"WorkSans-Regular" size:9.0];
        CGRect labelRect = [strintro
                            boundingRectWithSize:maximumLabelSize
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{
                                         NSFontAttributeName : [UIFont systemFontOfSize:16]
                                         }
                            context:nil];
        float height11= labelRect.size.height;
        return CGSizeMake(collectionView1.frame.size.width, height11);
    
    }
    
    
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    
    
    if (kind == UICollectionElementKindSectionHeader) {
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
    
    if (kind == UICollectionElementKindSectionFooter) {
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
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 38);
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
- (IBAction)btnEmailClicked:(UIButton*)sender
{
    clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
    objAboutUs=[arrSpecialities objectAtIndex:sender.tag];
    
    MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]) {
        [composer setToRecipients:[NSArray arrayWithObjects:objAboutUs.strEmail, nil]];
        [composer setSubject:[NSString stringWithFormat:@"Inquiry from Astaguru app"]];//@"Astaguru: %@",objAboutUs.strName]];
        
        //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
        NSString *message=[NSString stringWithFormat:@"Hello %@,\n",objAboutUs.strName];
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
-(void)btnEmail:(clsAboutUs *)objAboutUS
{
    MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]) {
        [composer setToRecipients:[NSArray arrayWithObjects:objAboutUS.strEmail, nil]];
        [composer setSubject:[NSString stringWithFormat:@"Inquiry from Astaguru app"]];//@"Astaguru: %@",objAboutUS.strName]];
        
        //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
        NSString *message=[NSString stringWithFormat:@"Hello %@,\n",objAboutUS.strName];
        [composer setMessageBody:message isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
    }
    else {
    }

}
@end
