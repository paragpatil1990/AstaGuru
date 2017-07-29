//
//  UpcommingAuctionViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 6/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "UpcommingAuctionViewController.h"
#import "PastTopCollectionViewCell.h"
#import "UpcommingAuction.h"
#import "ItemOfUpcomingViewController.h"

@interface UpcommingAuctionViewController ()

@end

@implementation UpcommingAuctionViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"Upcomming Auctions";
    
    [self setNavigationBarSlideButton];//Target:self.revealViewController selector:@selector(revealToggle:)];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    [self registerNibUpcomingAuctionCollectionView:self.clvUpcommingAuction];
    [self getUpcommingAuction];
}

-(void)getUpcommingAuction
{
    NSString *strUrl = [NSString stringWithFormat:@"getAuctionList?api_key=%@&filter=status=Upcomming", [GlobalClass apiKey]];
    [GlobalClass call_tableGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject){
        
        NSMutableArray *arrParese = [UpcommingAuction parseUpcommingAuction:[responseObject[@"resource"] mutableCopy]];
        if ([self checkArrayCount:arrParese])
        {
            self.upcommingAuctionArray = arrParese;
            [self.clvUpcommingAuction reloadData];
        }
    } failure:^(NSError *error){
        [GlobalClass showTost:error.localizedDescription];
    } callingCount:0];
}

-(BOOL)checkArrayCount:(NSArray*)arrayAuctionData
{
    if (arrayAuctionData.count == 0)
    {
        _noRecords_Lbl.text = @"There is no Upcoming Auction. We will notify you whenever any Upcoming Auction is live.";
        _noRecords_Lbl.hidden = NO;
        self.clvUpcommingAuction.hidden = YES;
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == self.clvUpcommingAuction)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 2)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.clvUpcommingAuction)
    {
        if (indexPath.section == 0 || indexPath.section == 2)
        {
            return CGSizeMake(collectionView.frame.size.width, 10);
        }
        else
        {
            return   CGSizeMake((collectionView.frame.size.width/2) - 12, 250);
        }
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        return CGSizeMake(width, collectionView.frame.size.height);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.clvUpcommingAuction)
    {
        if (section==0 || section == 2)
        {
            return 1;
        }
        return  self.upcommingAuctionArray.count;
    }
    else
    {
        return [self arrBottomMenu].count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (collectionView == self.clvUpcommingAuction)
    {
//        if (indexPath.section==0)
//        {
//            PastTopCollectionViewCell *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
//            
//            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isUSD"])
//            {
//                topCell.lblCurrency.text=@"USD";
//            }
//            else
//            {
//                topCell.lblCurrency.text=@"INR";
//            }
//            cell = topCell;
//        }
        if (indexPath.section==0 || indexPath.section==2)
        {
            cell = [self configureBlankCell:collectionView indexPath:indexPath];
        }
        else
        {
            UpcommingAuction *upcommingAuction = [self.upcommingAuctionArray objectAtIndex:indexPath.row];
            cell = [self configureUpcomingAuctionCell:collectionView indexPath:indexPath upcomingAuction:upcommingAuction];
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
        ItemOfUpcomingViewController *objItemOfUpcomingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfUpcomingViewController"];
        objItemOfUpcomingViewController.selectedBMenu = self.selectedBMenu;
        objItemOfUpcomingViewController.upcomingAuction = [self.upcommingAuctionArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:objItemOfUpcomingViewController animated:YES];
    }
}

- (IBAction)btnCurrencyChanged:(id)sender
{
    [self didCurrencyChanged:self.clvUpcommingAuction];
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
