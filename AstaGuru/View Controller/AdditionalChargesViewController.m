//
//  AdditionalChargesViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 13/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AdditionalChargesViewController.h"
#import "ClsSetting.h"
#import "AdditionalChargesCollectionViewCell.h"
#import "MyProfileViewController.h"
#import "BforeLoginViewController.h"
#import "UserInfoCollectionViewCell.h"
@interface AdditionalChargesViewController ()<PassResepose>
{
   
    NSMutableArray *arrBottomMenu;
    NSMutableDictionary *dictUserProfile;
    int tag;
}
@end

@implementation AdditionalChargesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarBackButton];

    tag = 0;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    /* self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];*/

    [self getAuction];
    
//    else
//    {
//        [self GetProfile];
//    }
    //self.navigationController.navigationBar.backItem.title = @"Back";
}
-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
  //  [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
  //  [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
  //  [_backButton setTitle:@"Back" forState:UIControlStateNormal];
   // [[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
  //  [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationItem];
}
-(void)searchPressed
{
     [ClsSetting Searchpage:self.navigationController];
}
-(void)myastaguru
{
    
    [ClsSetting myAstaGuru:self.navigationController];
    
}

-(void)getAuction
{
    tag = 1;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"acution/%@/?api_key=%@&filter=online=%@&related=*",_objCurrentOuction.strproductid,[ClsSetting apiKey],_objCurrentOuction.strOnline] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)GetProfile
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=%@&filter=userid=%@",[ClsSetting apiKey],[[NSUserDefaults standardUserDefaults] valueForKey:USER_id]] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    if(tag == 1)
    {
        NSString *isMargin = [dict1 valueForKey:@"isMargin"];
        _objCurrentOuction.isMargin = isMargin;
        //_objCurrentOuction = [parese parseCurrentAuctionObj:dict1];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] > 0)
        {
            tag = 2;
            [self GetProfile];
        }
        [_clvViewAdditionalCgharges reloadData];
    }
    else
    {
        NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
        if (arr1.count>0)
        {
            NSMutableDictionary *dict=[arr1 objectAtIndex:0];
            dict=[ClsSetting RemoveNullOnly:dict];
            //        NSString *strname=[dict valueForKey:@"name"];
            dictUserProfile=dict;
            
            [_clvViewAdditionalCgharges reloadData];
        }
        else
        {
            [ClsSetting ValidationPromt:@"Some thing went wrong"];
        }
    }
}


-(void)setUpNavigationItem
{
    // self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    // self.sidebarButton.tintColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"Additional Charges";
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, -20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    
    UIButton *btnBack1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, -20)];
    [btnBack1 setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [btnBack1 addTarget:self action:@selector(myastaguru) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnBack1];
    UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -12;
    UIBarButtonItem *spaceFix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -8;
    [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem,spaceFix1, barButtonItem1]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _clvViewAdditionalCgharges)
    {
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView==_clvViewAdditionalCgharges)
    {
        if (section==0)
        {
            return 1;
        }
        else
        {
            return  1;
        }
    }
    else
    {
        return arrBottomMenu.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
   
    AdditionalChargesCollectionViewCell *CurrentSelectedGridCell;
    UserInfoCollectionViewCell *UserInfoCell;
    UICollectionViewCell *cell1;
    
    if (collectionView==_clvViewAdditionalCgharges)
    {
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
        {
            if (indexPath.section==0)
            {
                UserInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BillingInfo" forIndexPath:indexPath];
                [self setupProfileCell:UserInfoCell];
                cell = UserInfoCell;
            }
            else if (indexPath.section==1)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected1234" forIndexPath:indexPath];
                [self setupAdditionalChargesCell:CurrentSelectedGridCell];
                cell = CurrentSelectedGridCell;
            }
        }
        else
        {
            if (indexPath.section==0)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected1234" forIndexPath:indexPath];
                [self setupAdditionalChargesCell:CurrentSelectedGridCell];
                cell = CurrentSelectedGridCell;
            }
        }
    }
    else
    {
        static NSString *identifier = @"Cell11";
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:20];
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        lblSelectedline.hidden=YES;
        
        UIButton *btnLive = (UIButton *)[cell1 viewWithTag:23];
        btnLive.layer.cornerRadius = 4;
        btnLive.hidden = YES;
        
        UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];

        if (indexPath.row == 1)
        {
            btnLive.hidden = NO;
        }
        
        if (indexPath.row==1)
        {
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden=NO;
        }
        else
        {
            lblTitle.textColor=[UIColor blackColor];//[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
            lblline.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
            lblSelectedline.hidden=YES;
        }
        cell=cell1;
    }
    return cell;
}

-(void)setupProfileCell:(UserInfoCollectionViewCell*)UserInfoCell
{
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"name"] label:UserInfoCell.lblBillingName];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"address1"] label:UserInfoCell.lblBillingAddress];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"city"] label:UserInfoCell.lblBillingCity];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"zip"] label:UserInfoCell.lblBillingZip];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"state"] label:UserInfoCell.lblBillingState];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"country"] label:UserInfoCell.lblBillingCountry];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"Mobile"] label:UserInfoCell.lblBillingPhone];
    [self checkBlackOrNot:[dictUserProfile valueForKey:@"email"] label:UserInfoCell.lblBillingEmail];
}

-(void)setupAdditionalChargesCell:(AdditionalChargesCollectionViewCell*)CurrentSelectedGridCell
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:0];
    
    NSInteger margin = 0;
    NSInteger gstOnArtWork = 0;
    NSInteger gstOnBuyersPremium = 0;
    NSInteger grandTotal = 0;
    NSInteger gstValueArtwork = 0;
    NSInteger gstValueBuyersPremium = 0;
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        numberFormatter.currencyCode = @"USD";
        
        NSInteger price =[_objCurrentOuction.strpriceus integerValue];
        gstValueArtwork = 0;
        gstValueBuyersPremium = 0;
        
        NSNumber *num = [NSNumber numberWithInteger:price];
        NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
        CurrentSelectedGridCell.lbl_hammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
        
        NSLog(@"%@", _objCurrentOuction.isMargin);
        if ([_objCurrentOuction.isMargin integerValue]  == 1)
        {
            margin = (price*15)/100;
            gstOnArtWork = (price*gstValueArtwork)/100;
            gstOnBuyersPremium = (margin*gstValueBuyersPremium)/100;
            
            grandTotal = price + margin + gstOnArtWork + gstOnBuyersPremium;
            
            CurrentSelectedGridCell.lbl_gstOnBuyersPremiumTxt.hidden = NO;
            CurrentSelectedGridCell.lbl_gstOnBuyersPremium.hidden = NO;
        }
        else
        {
            margin = (price*15)/100;
            
            NSInteger total = price + margin;
            
            gstOnArtWork = (total*gstValueArtwork)/100;
            
            grandTotal = price + margin + gstOnArtWork;
            CurrentSelectedGridCell.lbl_gstOnBuyersPremiumTxt.hidden = YES;
            CurrentSelectedGridCell.lbl_gstOnBuyersPremium.hidden = YES;
        }
    }
    else
    {
        numberFormatter.currencyCode = @"INR";
        NSInteger price =[_objCurrentOuction.strpricers integerValue];
        gstValueArtwork = [_objCurrentOuction.strprVat integerValue];
        gstValueBuyersPremium = 18;
        
        NSNumber *num = [NSNumber numberWithInteger:price];
        NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
        CurrentSelectedGridCell.lbl_hammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
        
        if ([_objCurrentOuction.isMargin integerValue] == 1)
        {
            margin = (price*15)/100;
            gstOnArtWork = (price*gstValueArtwork)/100;
            gstOnBuyersPremium = (margin*gstValueBuyersPremium)/100;
            
            grandTotal = price + margin + gstOnArtWork + gstOnBuyersPremium;
            
            CurrentSelectedGridCell.lbl_gstOnBuyersPremiumTxt.hidden = NO;
            CurrentSelectedGridCell.lbl_gstOnBuyersPremium.hidden = NO;
        }
        else
        {
            margin = (price*15)/100;
            
            NSInteger total = price + margin;
            
            gstOnArtWork = (total*gstValueArtwork)/100;
            
            grandTotal = price + margin + gstOnArtWork;
            
            CurrentSelectedGridCell.lbl_gstOnBuyersPremiumTxt.hidden = YES;
            CurrentSelectedGridCell.lbl_gstOnBuyersPremium.hidden = YES;
        }
    }
    
    NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInteger:grandTotal]];
    
    CurrentSelectedGridCell.lbl_marginTxt.text = @"15% Margin";
    NSString *strPrimium = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:margin]];
    CurrentSelectedGridCell.lbl_margin.text = [NSString stringWithFormat:@"%@",strPrimium];
    
    CurrentSelectedGridCell.lbl_gstOnArtworkTxt.text = [NSString stringWithFormat:@"GST on Art Work (%ld %s)",(long)gstValueArtwork,"%"];
    NSString *strGSTOnArtWork = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:gstOnArtWork]];
    CurrentSelectedGridCell.lbl_gstOnArtwork.text = [NSString stringWithFormat:@"%@",strGSTOnArtWork];
    
    CurrentSelectedGridCell.lbl_gstOnBuyersPremiumTxt.text = [NSString stringWithFormat:@"%ld %s GST on Buyers Premium", (long)gstValueBuyersPremium, "%"];
    NSString *strGSTOnBuyersPremium = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:gstOnBuyersPremium]];
    CurrentSelectedGridCell.lbl_gstOnBuyersPremium.text = [NSString stringWithFormat:@"%@",strGSTOnBuyersPremium];
    CurrentSelectedGridCell.lbl_GrandTotal.text = [NSString stringWithFormat:@"%@",strFinalPrice];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
    {
        CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
    }
    else
    {
        CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strcollectors;
    }
    
    //if ([_objCurrentOuction.strAuctionname isEqualToString:@"Collectibles Auction"])
    if ([_objCurrentOuction.auctionType intValue] != 1)
    {
        UIView *subvuew = (UIView*) [CurrentSelectedGridCell viewWithTag:10];
        UILabel *Lbl_1 = (UILabel *)[subvuew viewWithTag:1];
        Lbl_1.text = @"Title: ";
        UILabel *Lbl_2 = (UILabel *)[subvuew viewWithTag:2];
        Lbl_2.text = @"Category: ";
        UILabel *Lbl_3 = (UILabel *)[subvuew viewWithTag:3];
        Lbl_3.text = @" ";
        UILabel *Lbl_4 = (UILabel *)[subvuew viewWithTag:4];
        Lbl_4.text = @" ";
        UILabel *Lbl_5 = (UILabel *)[subvuew viewWithTag:5];
        Lbl_5.text = @" ";
        
        CurrentSelectedGridCell.lblArtistName.text=_objCurrentOuction.strtitle;
        // NSString *ht = [ClsSetting getAttributedStringFormHtmlString:_objCurrentOuction.strPrdescription];
        CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.strcategory;//ht;
        CurrentSelectedGridCell.lblYear.text = @" ";
        CurrentSelectedGridCell.lblSize.text = @" ";////[NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
        
        CurrentSelectedGridCell.lblEstimation.text = @" ";
    }
    else
    {
        CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
        
        CurrentSelectedGridCell.lblMedium.text=[NSString stringWithFormat:@"%@",_objCurrentOuction.strmedium];
        
        CurrentSelectedGridCell.lblSize.text=[NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
        
        CurrentSelectedGridCell.lblYear.text=[NSString stringWithFormat:@"%@",_objCurrentOuction.strproductdate];
    }
    CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
    CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting imageURL], _objCurrentOuction.strthumbnail]];
    [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strReference]] forState:UIControlStateNormal];
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvViewAdditionalCgharges)
    {
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
        {
            if (indexPath.section==0)
            {
                return   CGSizeMake(collectionView1.frame.size.width,270);
            }
            else
            {
                return   CGSizeMake(collectionView1.frame.size.width,410);
            }
        }
        else
        {
            return   CGSizeMake(collectionView1.frame.size.width,410);
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)updateBillingAddress:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        MyProfileViewController *objMyProfileViewController = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
        
        
        [self.navigationController pushViewController:objMyProfileViewController animated:YES];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [self.navigationController pushViewController:rootViewController animated:YES];
    }
}

-(void)checkBlackOrNot:(NSString*)str label:(UILabel*)lbl;
{
    if (str.length==0)
    {
        lbl.text=@"--";
    }
    else
    {
        lbl.text=str;
    }
}
@end
