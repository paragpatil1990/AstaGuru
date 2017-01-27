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
}
@end

@implementation AdditionalChargesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    /* self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];*/
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] > 0)
    {
        [self GetProfile];
    }
//    else
//    {
//        [self GetProfile];
//    }
    self.navigationController.navigationBar.backItem.title = @"Back";
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
-(void)GetProfile
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=userid=%@",[[NSUserDefaults standardUserDefaults] valueForKey:USER_id]] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}
-(void)passReseposeData:(id)arr
{
    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
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
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"name"] label:UserInfoCell.lblBillingName];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"address1"] label:UserInfoCell.lblBillingAddress];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"city"] label:UserInfoCell.lblBillingCity];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"zip"] label:UserInfoCell.lblBillingZip];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"state"] label:UserInfoCell.lblBillingState];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"country"] label:UserInfoCell.lblBillingCountry];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"Mobile"] label:UserInfoCell.lblBillingPhone];
                [self checkBlackOrNot:[dictUserProfile valueForKey:@"email"] label:UserInfoCell.lblBillingEmail];
                /* UILabel *lblUsername = (UILabel *)[cell1 viewWithTag:21];
                 lblUsername.text=[NSString stringWithFormat:@"No of Bids: %lu",(unsigned long)arrBidHistoryData.count];*/
                cell=UserInfoCell;
            }
            else if (indexPath.section==1)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected1234" forIndexPath:indexPath];
                
                /*[UIView transitionWithView:CurrentDefultGridCell.contentView
                 duration:5
                 options:UIViewAnimationOptionTransitionFlipFromLeft
                 animations:^{
                 
                 CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
                 
                 
                 } completion:nil];*/
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];

                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    
//                    int price = [_objCurrentOuction.strpriceus intValue];
//                    NSNumber *num = [NSNumber numberWithInt:price];
//                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    
                    int price =[_objCurrentOuction.strpriceus intValue];
                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    CurrentSelectedGridCell.lblHammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    int Primium=(price*15)/100;
                    int vat =(price*13.5)/100;
                    int taxOnPrimium=(Primium*15)/100;
                    int FinalPrice=price+Primium+vat+taxOnPrimium;
                    
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:Primium]];
                    NSString *strvat= [numberFormatter stringFromNumber:[NSNumber numberWithInt:vat]];
                    NSString *strtaxOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInt:taxOnPrimium]];
                    NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    
                    CurrentSelectedGridCell.lblByyerPremium.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    CurrentSelectedGridCell.lblVatOnHammerPrice.text=[NSString stringWithFormat:@"%@",strvat];
                    CurrentSelectedGridCell.lblServiceTaxOnPremium.text=[NSString stringWithFormat:@"%@",strtaxOnPrimium];
                    CurrentSelectedGridCell.lblGrandTotal.text=[NSString stringWithFormat:@"%@",strFinalPrice];
                    CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
                    
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    int price =[_objCurrentOuction.strpricers intValue];
                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    CurrentSelectedGridCell.lblHammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int Primium=(price*15)/100;
                    int vat =(price*13.5)/100;
                    int taxOnPrimium=(Primium*15)/100;
                    int FinalPrice=price+Primium+vat+taxOnPrimium;
                    
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:Primium]];
                    NSString *strvat= [numberFormatter stringFromNumber:[NSNumber numberWithInt:vat]];
                    NSString *strtaxOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInt:taxOnPrimium]];
                    NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    
                    CurrentSelectedGridCell.lblByyerPremium.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    CurrentSelectedGridCell.lblVatOnHammerPrice.text=[NSString stringWithFormat:@"%@",strvat];
                    CurrentSelectedGridCell.lblServiceTaxOnPremium.text=[NSString stringWithFormat:@"%@",strtaxOnPrimium];
                    CurrentSelectedGridCell.lblGrandTotal.text=[NSString stringWithFormat:@"%@",strFinalPrice];
                    
                    NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                    NSArray *subStrings = [_objCurrentOuction.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
                    if (subStrings.count>1)
                    {
                        // strFromRangeString = [subStrings objectAtIndex:0];
                        //  strToRangeString = [subStrings objectAtIndex:1];
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.numberStyle = NSNumberFormatterDecimalStyle;
                        NSString *strFromRangeString = [[subStrings objectAtIndex:0] stringByTrimmingCharactersInSet:nonNumbersSet];
                        NSString *strToRangeString = [[subStrings objectAtIndex:1] stringByTrimmingCharactersInSet:nonNumbersSet];
                        
                        float Fromnumber = [[formatter numberFromString:strFromRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                        
                        float Tonumber = [[formatter numberFromString:strToRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                        
                        NSString *strFromRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Fromnumber]];
                        NSString *strToRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Tonumber]];
                        
                        CurrentSelectedGridCell.lblEstimation.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                        
                        
                    }
                }
                if (_IsSort==1)
                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
                    CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.strmedium;
                    CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.strcategory;
                }
                else
                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.objArtistInfo.strFirstName,_objCurrentOuction.objArtistInfo.strLastName];
                    CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.objMediaInfo.strMediumName;
                    CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.objCategoryInfo.strCategoryName;
                }
                
                
                CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
                
                CurrentSelectedGridCell.lblYear.text= _objCurrentOuction.strproductdate;
                CurrentSelectedGridCell.lblSize.text= [NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
                CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOuction.strthumbnail]];
                
                
                
                [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strReference]] forState:UIControlStateNormal];
                cell = CurrentSelectedGridCell;
                
            }
        }
        else
        {
            if (indexPath.section==0)
            {
                CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentSelected1234" forIndexPath:indexPath];
                
                /*[UIView transitionWithView:CurrentDefultGridCell.contentView
                 duration:5
                 options:UIViewAnimationOptionTransitionFlipFromLeft
                 animations:^{
                 
                 CurrentDefultGridCollectionViewCell      *CurrentDefultGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentInfo" forIndexPath:indexPath];
                 
                 
                 } completion:nil];*/
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
                [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
                [numberFormatter setMaximumFractionDigits:0];

                
                if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
                {
                    numberFormatter.currencyCode = @"USD";
                    
                    int price =[_objCurrentOuction.strpriceus intValue];
                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    CurrentSelectedGridCell.lblHammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int Primium=(price*15)/100;
                    int vat =(price*13.5)/100;
                    int taxOnPrimium=(Primium*15)/100;
                    int FinalPrice=price+Primium+vat+taxOnPrimium;
                    
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:Primium]];
                    NSString *strvat= [numberFormatter stringFromNumber:[NSNumber numberWithInt:vat]];
                    NSString *strtaxOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInt:taxOnPrimium]];
                    NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    CurrentSelectedGridCell.lblByyerPremium.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    CurrentSelectedGridCell.lblVatOnHammerPrice.text=[NSString stringWithFormat:@"%@",strvat];
                    CurrentSelectedGridCell.lblServiceTaxOnPremium.text=[NSString stringWithFormat:@"%@",strtaxOnPrimium];
                    CurrentSelectedGridCell.lblGrandTotal.text=[NSString stringWithFormat:@"%@",strFinalPrice];
                    CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
                    
                }
                else
                {
                    numberFormatter.currencyCode = @"INR";
                    int price =[_objCurrentOuction.strpricers floatValue];
                    NSNumber *num = [NSNumber numberWithInt:price];
                    NSString *strCurrentBuild = [numberFormatter stringFromNumber:num];
                    CurrentSelectedGridCell.lblHammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                    
                    int Primium=(price*15)/100;
                    int vat =(price*13.5)/100;
                    int taxOnPrimium=(Primium*15)/100;
                    int FinalPrice=price+Primium+vat+taxOnPrimium;
                    
                    NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:Primium]];
                    NSString *strvat= [numberFormatter stringFromNumber:[NSNumber numberWithInt:vat]];
                    NSString *strtaxOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInt:taxOnPrimium]];
                    NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                    
                    
                    CurrentSelectedGridCell.lblByyerPremium.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                    CurrentSelectedGridCell.lblVatOnHammerPrice.text=[NSString stringWithFormat:@"%@",strvat];
                    CurrentSelectedGridCell.lblServiceTaxOnPremium.text=[NSString stringWithFormat:@"%@",strtaxOnPrimium];
                    CurrentSelectedGridCell.lblGrandTotal.text=[NSString stringWithFormat:@"%@",strFinalPrice];
                    
                    NSCharacterSet *nonNumbersSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
                    NSArray *subStrings = [_objCurrentOuction.strestamiate componentsSeparatedByString:@"–"]; //or rather @" - "
                    if (subStrings.count>1)
                    {
                        // strFromRangeString = [subStrings objectAtIndex:0];
                        //  strToRangeString = [subStrings objectAtIndex:1];
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.numberStyle = NSNumberFormatterDecimalStyle;
                        NSString *strFromRangeString = [[subStrings objectAtIndex:0] stringByTrimmingCharactersInSet:nonNumbersSet];
                        NSString *strToRangeString = [[subStrings objectAtIndex:1] stringByTrimmingCharactersInSet:nonNumbersSet];
                        
                        float Fromnumber = [[formatter numberFromString:strFromRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                        
                        float Tonumber = [[formatter numberFromString:strToRangeString] intValue]*[[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"] floatValue];
                        
                        NSString *strFromRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Fromnumber]];
                        NSString *strToRs = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Tonumber]];
                        
                        CurrentSelectedGridCell.lblEstimation.text=[NSString stringWithFormat:@"%@ - %@",strFromRs,strToRs];
                        
                        
                    }
                    
                    
                }
                if (_IsSort==1)
                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
                    CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.strmedium;
                    CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.strcategory;
                }
                else
                {
                    CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.objArtistInfo.strFirstName,_objCurrentOuction.objArtistInfo.strLastName];
                    CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.objMediaInfo.strMediumName;
                    CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.objCategoryInfo.strCategoryName;
                }
                
                
                CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
                
                CurrentSelectedGridCell.lblYear.text= _objCurrentOuction.strproductdate;
                CurrentSelectedGridCell.lblSize.text= [NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
                CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOuction.strthumbnail]];
                
                
                
                [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strReference]] forState:UIControlStateNormal];
                cell = CurrentSelectedGridCell;
                
            }
        }
    }
    else
    {
        static NSString *identifier = @"Cell11";
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        UILabel *lblTitle = (UILabel *)[cell1 viewWithTag:30];
        UILabel *lblSelectedline = (UILabel *)[cell1 viewWithTag:22];
        NSLog(@"%@",[arrBottomMenu objectAtIndex:indexPath.row]);
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        if (indexPath.row==1)
        {
            UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden=NO;
            
        }
        else
        {
//            UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
            lblSelectedline.hidden=YES;
        }
        cell=cell1;
    }
    return cell;
    
    
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
