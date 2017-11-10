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
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "ClsSetting.h"
@interface AboutUsViewController ()<MFMailComposeViewControllerDelegate,AboutUs>
{
    NSMutableArray *arrManagement;
    NSMutableArray *arrSpecialities;
    int height;
    NSString *strintro;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad
{
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
    
//    [self createArrayManagement];
//    [self createArraySpecialities];
    
//    int NoOfCol, NoOfCol2;
//    if (arrManagement.count/3==0)
//    {
//        NoOfCol=(int)arrManagement.count/3;
//    }
//    else
//    {
//        NoOfCol=(int)(arrManagement.count/3)+1;
//    }
//    
//    if (arrSpecialities.count/2==0)
//    {
//        NoOfCol2 = (int)arrSpecialities.count/2;
//    }
//    else
//    {
//        NoOfCol2 = (int)(arrSpecialities.count/2)+1;
//    }
    
//    strintro = @"\nAstaGuru was conceptualised in the year 2008 functioning as a safe and secure platform to conduct online auctions for 'Contemporary & Modern Indian Art', as well as vintage collectibles and rear antiques such as sculptures, classic miniatures paintings, fine writing instruments, timepieces, celebrity memorabilia and aristocratic jewelry. The word AstaGuru is a combination of Asta which means auction in Italian and Guru which indicates our mastery at conducting the same.\n\nWith the world becoming whole on a digital level, we are able to showcase Indian Art & Antiques, hereby successfully linking the perspective buyer and consignor without any geographic constraints. Our stringent selection process ensures only prime artworks & exquisite antiques are part of our auctions. Numerous parameters such as the provenance of the work, the rarity of the work, and its physical condition are assessed before their inclusion in our auctions.\n\nUnder the leadership of Mr Vickram Sethi, founder & chairman of The Arts Trust, Institute of Contemporary Indian Art Gallery, Mumbai & AstaGuru and Mr Tushar Sethi, CEO AstaGuru, we are treading towards a horizon filled with Art, Antiques & Bliss.\n\nTheir keen eye and impeccable knowledge leverages us with insights of current & future trends. Our aim is to manifest Indian Art globally and create a conducive environment that spurts its growth.";
    
    [self spGetAboutUs];
    
//    float height11 = [self getHeightForText:_txtAboutUs.text
//                                 withFont:_txtAboutUs.font
//                                 andWidth:_txtAboutUs.frame.size.width];
//   
//    // Do any additional setup after loading the view.
//    height=(NoOfCol*147)+(NoOfCol2*147)+80+height11;
//    _scrContent.contentSize= CGSizeMake(_scrContent.frame.size.width, height);
//    _viwinner.frame=CGRectMake(_viwinner.frame.origin.x, _viwinner.frame.origin.y, _viwinner.frame.size.width,height);
}
-(void)closePressed
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}


-(void)spGetAboutUs
{
    //-------
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetAboutUs?api_key=%@",[ClsSetting procedureURL],[ClsSetting apiKey]];
        
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
            // NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSMutableArray *arrElement = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",arrElement);
             
             NSArray *arrAboutus = arrElement[0];
             
             strintro = [arrAboutus[0] valueForKey:@"Aboutus"];
             
             NSArray *arrEmploye = arrElement[1];
             
//             NSMutableArray *arrManagements = [[NSMutableArray alloc] init];
//             NSMutableArray *arrSpecialities = [[NSMutableArray alloc] init];
             
             
             [arrManagement removeAllObjects];
             [arrSpecialities removeAllObjects];
             for (int i = 0; i < arrEmploye.count; i++)
             {
                 NSDictionary *emp = arrEmploye[i];
                 clsAboutUs *objclsAboutus=[[clsAboutUs alloc]init];
                 objclsAboutus.strimage = emp[@"empimageurl"];
                 objclsAboutus.strName = emp[@"Empname"];
                 objclsAboutus.strPost = emp[@"empdesc"];
                 objclsAboutus.strType = emp[@"empmanagement"];
                 objclsAboutus.strEmail = emp[@"empemail"];
                 
                 if ([emp[@"empmanagement"] isEqualToString:@"1"])
                 {
                     [arrManagement addObject:objclsAboutus];
                 }
                 else
                 {
                     [arrSpecialities addObject:objclsAboutus];
                 }
             }
             
             [self.clv_aboutus reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];
             }];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}


-(void)createArrayManagement
{
    clsAboutUs *objclsAboutus1=[[clsAboutUs alloc]init];
    objclsAboutus1.strimage=@"img-vickram-1";
    objclsAboutus1.strName=@"Vickram Sethi";
    objclsAboutus1.strPost=@"Chairman";
    objclsAboutus1.strType=@"1";
    [arrManagement addObject:objclsAboutus1];
    
    clsAboutUs *objclsAboutus2=[[clsAboutUs alloc]init];
    objclsAboutus2.strimage=@"img-tushar-2";
    objclsAboutus2.strName=@"Tushar Sethi";
    objclsAboutus2.strPost=@"CEO";
    objclsAboutus2.strType=@"1";
    [arrManagement addObject:objclsAboutus2];
    
    clsAboutUs *objclsAboutus3=[[clsAboutUs alloc]init];
    objclsAboutus3.strimage=@"img-digamber-3";
    objclsAboutus3.strName=@"Digamber Sethi";
    objclsAboutus3.strPost=@"COO";
    objclsAboutus3.strType=@"1";
    [arrManagement addObject:objclsAboutus3];
}

-(void)createArraySpecialities
{
    clsAboutUs *objclsAboutus1=[[clsAboutUs alloc]init];
    objclsAboutus1.strimage=@"img-sunny-v.p.client_relation.png";
    objclsAboutus1.strName=@"Sunny Chandiramani";
    objclsAboutus1.strPost=@"V.P.Client Relations";
    objclsAboutus1.strType=@"2";
    objclsAboutus1.strEmail=@"sunny@astaguru.com";
    [arrSpecialities addObject:objclsAboutus1];
    
    clsAboutUs *objclsAboutus2=[[clsAboutUs alloc]init];
    objclsAboutus2.strimage=@"img-sonal-v.p.client_relation.png";
    objclsAboutus2.strName=@"Sonal Patel";
    objclsAboutus2.strPost=@"V.P.Client Relations";
    objclsAboutus2.strType=@"2";
    objclsAboutus2.strEmail=@"sonal@astaguru.com";
    [arrSpecialities addObject:objclsAboutus2];
    
    clsAboutUs *objclsAboutus3=[[clsAboutUs alloc]init];
    objclsAboutus3.strimage=@"img-sneha-v.p.client_relation.png";
    objclsAboutus3.strName=@"Sneha Gautam";
    objclsAboutus3.strPost=@"V.P.Client Relations";
    objclsAboutus3.strType=@"2";
    objclsAboutus3.strEmail=@"sneha@astaguru.com";
    [arrSpecialities addObject:objclsAboutus3];
    
    clsAboutUs *objclsAboutus4=[[clsAboutUs alloc]init];
    objclsAboutus4.strimage=@"img-razia-client_relation";
    objclsAboutus4.strName=@"Razia Parveen";
    objclsAboutus4.strPost=@"Client Relations";
    objclsAboutus4.strType=@"2";
    objclsAboutus4.strEmail=@"razia@astaguru.com";
    [arrSpecialities addObject:objclsAboutus4];
    
    clsAboutUs *objclsAboutus5=[[clsAboutUs alloc]init];
    objclsAboutus5.strimage=@"img-ankita-client_relation";
    objclsAboutus5.strName=@"Ankita Talreja";
    objclsAboutus5.strPost=@"Client Relations";
    objclsAboutus5.strType=@"2";
    objclsAboutus5.strEmail=@"ankita@astaguru.com";
    [arrSpecialities addObject:objclsAboutus5];
    
    clsAboutUs *objclsAboutus6=[[clsAboutUs alloc]init];
    objclsAboutus6.strimage=@"img-tahmina-client_relation";
    objclsAboutus6.strName=@"Tahmina Lakhani";
    objclsAboutus6.strPost=@"Client Relations";
    objclsAboutus6.strType=@"2";
    objclsAboutus6.strEmail=@"tahmina@astaguru.com";
    [arrSpecialities addObject:objclsAboutus6];
    
    clsAboutUs *objclsAboutus7=[[clsAboutUs alloc]init];
    objclsAboutus7.strimage=@"img-siddanth-business_strategy";
    objclsAboutus7.strName=@"Siddanth Shetty";
    objclsAboutus7.strPost=@"V.P. Business Strategy & Operations";
    objclsAboutus7.strType=@"2";
    objclsAboutus7.strEmail=@"siddanth@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus7];

    clsAboutUs *objclsAboutus8=[[clsAboutUs alloc]init];
    objclsAboutus8.strimage=@"img-anthony-administrator";
    objclsAboutus8.strName=@"Anthony Diniz";
    objclsAboutus8.strPost=@"Administrator";
    objclsAboutus8.strType=@"2";
    objclsAboutus8.strEmail=@"anthony@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus8];
    
    clsAboutUs *objclsAboutus9=[[clsAboutUs alloc]init];
    objclsAboutus9.strimage=@"img-karthik-logistics";
    objclsAboutus9.strName=@"Karthik Lynch";
    objclsAboutus9.strPost=@"Logistics";
    objclsAboutus9.strType=@"2";
    objclsAboutus9.strEmail=@"karthik@atheartstrust.com";
    [arrSpecialities addObject:objclsAboutus9];

    clsAboutUs *objclsAboutus10=[[clsAboutUs alloc]init];
    objclsAboutus10.strimage=@"img-sidhant-content_Editor";
    objclsAboutus10.strName=@"Sidhant Nayangara";
    objclsAboutus10.strPost=@"Content Editor";
    objclsAboutus10.strType=@"2";
    objclsAboutus10.strEmail=@"s.nayangara@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus10];
    
    clsAboutUs *objclsAboutus11=[[clsAboutUs alloc]init];
    objclsAboutus11.strimage=@"img-radhika-research";
    objclsAboutus11.strName=@"Radhika Kerkar";
    objclsAboutus11.strPost=@"Research";
    objclsAboutus11.strType=@"2";
    objclsAboutus11.strEmail=@"radhika@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus11];
    
    clsAboutUs *objclsAboutus12=[[clsAboutUs alloc]init];
    objclsAboutus12.strimage=@"img-snehal-human_resource";
    objclsAboutus12.strName=@"Snehal Pednekar";
    objclsAboutus12.strPost=@"Human Resource";
    objclsAboutus12.strType=@"2";
    objclsAboutus12.strEmail=@"snehal@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus12];

    clsAboutUs *objclsAboutus13=[[clsAboutUs alloc]init];
    objclsAboutus13.strimage=@"img-abhay-online_marketing";
    objclsAboutus13.strName=@"Abhay Menon";
    objclsAboutus13.strPost=@"Online Marketing Manager";
    objclsAboutus13.strType=@"2";
    objclsAboutus13.strEmail=@"abhay@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus13];
    
    clsAboutUs *objclsAboutus14=[[clsAboutUs alloc]init];
    objclsAboutus14.strimage=@"img-rupesh-market_analysts";
    objclsAboutus14.strName=@"Rupesh Khanna";
    objclsAboutus14.strPost=@"Market Analyst";
    objclsAboutus14.strType=@"2";
    objclsAboutus14.strEmail=@"rupesh@theartstrust.com";
    [arrSpecialities addObject:objclsAboutus14];

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
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellone" forIndexPath:indexPath];
        cell1.lblTitle.text = strintro;
        cell1.lblTitle.textAlignment = NSTextAlignmentJustified;
        cell3=cell1;
        
    }
    else if (indexPath.section==2)
    {
        UICollectionViewCell  *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellline" forIndexPath:indexPath];
        cell3=cell2;
    }
    else
    {
        AboutUsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        clsAboutUs *objAboutUs=[[clsAboutUs alloc]init];
        
        if (indexPath.section==1)
        {
            objAboutUs=[arrManagement objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==3)
        {
            objAboutUs=[arrSpecialities objectAtIndex:indexPath.row];
        }
        
        cell.img.imageURL=[NSURL URLWithString:objAboutUs.strimage];
        
        //cell.img.image=[UIImage imageNamed:objAboutUs.strimage];
        cell.lblTitle.text=objAboutUs.strName;
        cell.lblDesignation.text=objAboutUs.strPost;
        
        if (indexPath.section==1)
        {
            cell.btnEmail.hidden = YES;
        }
        else
        {
           cell.btnEmail.hidden = NO;
        }
        cell.objAboutUs=objAboutUs;
        cell.AboutUsdelegate=self;
        cell3=cell;
    }
    return cell3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        float width=(collectionView1.frame.size.width/3);
        return CGSizeMake(width-6, 164);
    }
    else if (indexPath.section==2)
    {
        return CGSizeMake(collectionView1.frame.size.width, 10);
    }
    else if(indexPath.section==3)
    {
        float width=(collectionView1.frame.size.width/2);
        return CGSizeMake(width-6, 182);
    }
    else
    {
        CGSize maximumLabelSize = CGSizeMake(collectionView1.frame.size.width-16, FLT_MAX);
        
        CGRect labelRect = [strintro
                            boundingRectWithSize:maximumLabelSize
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{
                                         NSFontAttributeName : [UIFont systemFontOfSize:17]
                                         }
                            context:nil];
        float height11 = labelRect.size.height;
        return CGSizeMake(collectionView1.frame.size.width, height11);
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
