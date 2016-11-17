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
//#import "SWRevealViewController.h"
@interface AdditionalChargesViewController ()
{
   
    NSMutableArray *arrBottomMenu;
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
    if (collectionView==_clvViewAdditionalCgharges)
    {
        return 2;
        
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
        if (indexPath.section==0)
        {
            return   CGSizeMake(collectionView1.frame.size.width,320);
        }
        else
        {
            return   CGSizeMake(collectionView1.frame.size.width,370);
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
    UICollectionViewCell *cell1;
    
    if (collectionView==_clvViewAdditionalCgharges)
    {
        
        if (indexPath.section==0)
        {
            cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"BillingInfo" forIndexPath:indexPath];
            
           /* UILabel *lblUsername = (UILabel *)[cell1 viewWithTag:21];
            lblUsername.text=[NSString stringWithFormat:@"No of Bids: %lu",(unsigned long)arrBidHistoryData.count];*/
            cell=cell1;
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
            
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                numberFormatter.currencyCode = @"USD";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
                
                
                CurrentSelectedGridCell.lblHammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                float price =[_objCurrentOuction.strpriceus floatValue];
                float Primium=(price*15)/100;
                float vat =(price*13.5)/100;
                float taxOnPrimium=(Primium*15)/100;
                float FinalPrice=price+Primium+vat+taxOnPrimium;
                
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:Primium]];
                 NSString *strvat= [numberFormatter stringFromNumber:[NSNumber numberWithInt:vat]];
                 NSString *strtaxOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInt:taxOnPrimium]];
                NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                
                CurrentSelectedGridCell.lblByyerPremium.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                 CurrentSelectedGridCell.lblVatOnHammerPrice.text=[NSString stringWithFormat:@"%@",strvat];
                 CurrentSelectedGridCell.lblServiceTaxOnPremium.text=[NSString stringWithFormat:@"%@",strtaxOnPrimium];
                 CurrentSelectedGridCell.lblGrandTotal.text=[NSString stringWithFormat:@"%@",strFinalPrice];
                
            }
            else
            {
                numberFormatter.currencyCode = @"INR";
                NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
                
                
                
                CurrentSelectedGridCell.lblHammerPrice.text=[NSString stringWithFormat:@"%@",strCurrentBuild];
                
                float price =[_objCurrentOuction.strpricers floatValue];
                float Primium=(price*15)/100;
                float vat =(price*13.5)/100;
                float taxOnPrimium=(Primium*15)/100;
                float FinalPrice=price+Primium+vat+taxOnPrimium;
                
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:Primium]];
                NSString *strvat= [numberFormatter stringFromNumber:[NSNumber numberWithInt:vat]];
                NSString *strtaxOnPrimium= [numberFormatter stringFromNumber:[NSNumber numberWithInt:taxOnPrimium]];
                NSString *strFinalPrice= [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
                
                
                CurrentSelectedGridCell.lblByyerPremium.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
                CurrentSelectedGridCell.lblVatOnHammerPrice.text=[NSString stringWithFormat:@"%@",strvat];
                CurrentSelectedGridCell.lblServiceTaxOnPremium.text=[NSString stringWithFormat:@"%@",strtaxOnPrimium];
                CurrentSelectedGridCell.lblGrandTotal.text=[NSString stringWithFormat:@"%@",strFinalPrice];
                
            }
            
            CurrentSelectedGridCell.lblArtistName.text=[NSString stringWithFormat:@"%@ %@",_objCurrentOuction.objArtistInfo.strFirstName,_objCurrentOuction.objArtistInfo.strLastName];
           
            CurrentSelectedGridCell.lblProductName.text= _objCurrentOuction.strtitle;
            CurrentSelectedGridCell.lblMedium.text= _objCurrentOuction.objMediaInfo.strMediumName;
            CurrentSelectedGridCell.lblCategoryName.text=_objCurrentOuction.objCategoryInfo.strCategoryName;
            CurrentSelectedGridCell.lblYear.text= _objCurrentOuction.strproductdate;
            CurrentSelectedGridCell.lblSize.text= [NSString stringWithFormat:@"%@ in",_objCurrentOuction.strproductsize];
            CurrentSelectedGridCell.imgProduct.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ClsSetting ImageURL], _objCurrentOuction.strthumbnail]];
            
            
            
            
            CurrentSelectedGridCell.lblEstimation.text=_objCurrentOuction.strestamiate;
            
            
            
            
            [CurrentSelectedGridCell.btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strproductid] forState:UIControlStateNormal];
            cell = CurrentSelectedGridCell;
            
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
            UILabel *lblline = (UILabel *)[cell1 viewWithTag:21];
            lblSelectedline.hidden=YES;
        }
        cell=cell1;
    }
    return cell;
    
    
}



/*
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
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    MyProfileViewController *objMyProfileViewController = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
    
    
    [self.navigationController pushViewController:objMyProfileViewController animated:YES];
}

@end
