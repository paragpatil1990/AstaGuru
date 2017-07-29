//
//  PastOccuctionViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "PastAuctionViewController.h"
#import "PastTopCollectionViewCell.h"
#import "PastAuction.h"
#import "ItemOfPastAuctionViewController.h"
@interface PastAuctionViewController ()
{
    
}
@end

@implementation PastAuctionViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"Past Auctions";
    
    [self setNavigationBarSlideButton];//Target:self.revealViewController selector:@selector(revealToggle:)];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];
    self.noRecords_Lbl.hidden = YES;
    [self getPastAuction];
    
    [self registerNibPastAuctionCollectionView:_clvPastAuction];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)getPastAuction
{
    NSString *strUrl = [NSString stringWithFormat:@"getAuctionList?api_key=%@&filter=status=Past", [GlobalClass apiKey]];
    [GlobalClass call_tableGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject){
        NSMutableArray *arrParese = [PastAuction parsePastAuction:[responseObject[@"resource"] mutableCopy]];
        if ([self checkArrayCount:arrParese])
        {
            self.pastAuctionArray = arrParese;
            [self.clvPastAuction reloadData];
        }
    } failure:^(NSError *error){
        [GlobalClass showTost:error.localizedDescription];
    } callingCount:0];
}

-(BOOL)checkArrayCount:(NSArray*)arrayAuctionData
{
    if (arrayAuctionData.count == 0)
    {
        _noRecords_Lbl.text = @"There is no any past auction still yet.";
        _noRecords_Lbl.hidden = NO;
        _clvPastAuction.hidden = YES;
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _clvPastAuction)
    {
        return 4;
        
    }
    else
    {
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_clvPastAuction)
    {
        if (section==0 || section == 1 || section == 3)
        {
            return 1;
        }
        return  self.pastAuctionArray.count;
    }
    else
    {
        return [self arrBottomMenu].count;
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 3)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==_clvPastAuction)
    {
        if (indexPath.section==0)
        {
            return CGSizeMake(collectionView1.frame.size.width, 40);
        }
        else if (indexPath.section == 1 || indexPath.section == 3)
        {
            return CGSizeMake(collectionView1.frame.size.width, 10);
        }
        else
        {
            return   CGSizeMake((collectionView1.frame.size.width/2) - 12, 280);
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);        
        return CGSizeMake(width, collectionView1.frame.size.height);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (collectionView==_clvPastAuction)
    {
        if (indexPath.section==0)
        {
            PastTopCollectionViewCell *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
            {
                topCell.lblCurrency.text=@"USD";
            }
            else
            {
                topCell.lblCurrency.text=@"INR";
            }
            cell = topCell;
        }
        else if (indexPath.section == 1 || indexPath.section == 3)
        {
            cell = [self configureBlankCell:collectionView indexPath:indexPath];
        }
        else
        {
            PastAuction *pastAuction = [self.pastAuctionArray objectAtIndex:indexPath.row];
            cell= [self configurePastAuctionCell:collectionView indexPath:indexPath pastAuction:pastAuction];
        }
    }
    else
    {
        cell = [self configureBottomMenuCell:_clvBottomMenu IndexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView == self.clvBottomMenu)
    {
        [self didSelectBottomMenu:indexPath.row];
    }
    else
    {
        ItemOfPastAuctionViewController *objItemOfPastAuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
        objItemOfPastAuctionViewController.pastAuction = [self.pastAuctionArray objectAtIndex:indexPath.row];
        objItemOfPastAuctionViewController.selectedBMenu = self.selectedBMenu;
        [self.navigationController pushViewController:objItemOfPastAuctionViewController animated:YES];
    }
}

- (IBAction)btnCurrencyChanged:(id)sender
{
    [self didCurrencyChanged:self.clvPastAuction];
}

@end
