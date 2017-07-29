//
//  FilterViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 15/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()
{
}
@end

@implementation FilterViewController

-(void)setUpNavigationItem
{
    if ([self.strAuctionName isEqualToString:@"Collectibles Auction"])
    {
        self.navigationItem.title = @"Filter Category";
    }
    else
    {
        self.navigationItem.title = @"Filter Artist";
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(btnCancelPressed)];
    btnCancel.tintColor = [UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    [[self navigationItem] setLeftBarButtonItem:btnCancel];
    
    UIBarButtonItem *btnClear = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(btnClearPressed)];
    btnClear.tintColor = [UIColor colorWithRed:167/255.0 green:142/255.0 blue:105/255.0 alpha:1.0];
    [[self navigationItem] setRightBarButtonItem:btnClear];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];

    if ([self.strAuctionName isEqualToString:@"Collectibles Auction"])
    {
        [self spGetAuctionCategory];
    }
    else
    {
        [self getArtistInfo];
    }
   
    self.filterTableView.estimatedRowHeight = 100.0;
    self.filterTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)btnCancelPressed
{
    [self.selecteArtistArray removeAllObjects];
    [self.delegate didCancelClearFilter];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnClearPressed
{
    [self.selecteArtistArray removeAllObjects];
    for (int i=0; i<self.artistArray.count; i++)
    {
        ArtistInfo *objArtist = [self.artistArray objectAtIndex:i];
        objArtist.isSelected = 0;
    }
    [self.filterTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artistArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
    
    UIImageView *imgSelected = (UIImageView *)[cell viewWithTag:11];
    UILabel *lblName = (UILabel *)[cell viewWithTag:12];
    
    ArtistInfo *objclsArtistInfo = [self.artistArray objectAtIndex:indexPath.row];
    
    lblName.text=[NSString stringWithFormat:@"%@ %@",objclsArtistInfo.strFirstName,objclsArtistInfo.strLastName];
    
    if (objclsArtistInfo.isSelected == 1)
    {
        imgSelected.image=[UIImage imageNamed:@"img-radio-selected"];
    }
    else
    {
        imgSelected.image=[UIImage imageNamed:@"img-radio-default"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArtistInfo *objArtistInfo = [self.artistArray objectAtIndex:indexPath.row];
    if (objArtistInfo.isSelected == 0)
    {
        objArtistInfo.isSelected = 1;
        [self.selecteArtistArray addObject:objArtistInfo];
    }
    else
    {
        objArtistInfo.isSelected = 0;
        for (int i=0; i<self.selecteArtistArray.count; i++)
        {
            ArtistInfo *objSelArtistInfo = [self.selecteArtistArray objectAtIndex:i];
            if ([objSelArtistInfo.strArtistid integerValue] == [objArtistInfo.strArtistid integerValue])
            {
                [self.selecteArtistArray removeObject:objSelArtistInfo];
            }
        }
    }
    [self.filterTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    v.backgroundColor=[UIColor clearColor];
    return v;
}

#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.view.frame.size.width/4;
    return CGSizeMake(width, collectionView1.frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self arrBottomMenu].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self configureBottomMenuCell:collectionView IndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [self didSelectBottomMenu:indexPath.row];
}

-(NSString*)getAuctionTypeName:(AuctionType)auctionType
{
    switch (auctionType)
    {
        case AuctionTypeCurrent:
            return @"Current";
        case AuctionTypeUpcoming:
            return @"Upcomming";
        case AuctionTypePast:
            return @"Past";
        default:
            return @"";
    }
}

-(void)spGetAuctionCategory
{
    NSString *auctionTypeName = [self getAuctionTypeName:self.auctionType];
    NSString  *strUrl = [NSString stringWithFormat:@"spGetAuctionCategory(%@,%@)", auctionTypeName, self.strAuctionId];
    
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         NSMutableArray *artist_Array = (NSMutableArray*)responseObject;
         if (artist_Array.count > 0)
         {
             self.artistArray = [ArtistInfo parseArtistInfo:artist_Array];
             
             for (int i=0; i<self.selecteArtistArray.count; i++)
             {
                 ArtistInfo *objSelectedArtistInfo = [self.selecteArtistArray objectAtIndex:i];
                 for (int j=0; j<self.artistArray.count; j++)
                 {
                     ArtistInfo *objArtistInfo = [self.artistArray objectAtIndex:j];
                     if ([objSelectedArtistInfo.strArtistid integerValue] == [objArtistInfo.strArtistid integerValue])
                     {
                         objArtistInfo.isSelected = 1;
                         break;
                     }
                 }
             }
             [self.filterTableView reloadData];
         }
         else
         {
             [GlobalClass showTost:@"Information not available"];
         }
     } failure:^(NSError *error){[GlobalClass showTost:error.localizedDescription];} callingCount:0];
}


-(void)getArtistInfo
{
    if (self.auctionType == AuctionTypeCurrent)
    {
        NSString  *strUrl=[NSString stringWithFormat:@"artistincurrentauction?api_key=%@",[GlobalClass apiKey]];
        [GlobalClass call_tableGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
         {
             NSMutableArray *artist_Array = responseObject[@"resource"];
             if (artist_Array.count > 0)
             {
                 self.artistArray = [ArtistInfo parseArtistInfo:artist_Array];
                 
                 for (int i=0; i<self.selecteArtistArray.count; i++)
                 {
                     ArtistInfo *objSelectedArtistInfo = [self.selecteArtistArray objectAtIndex:i];
                     for (int j=0; j<self.artistArray.count; j++)
                     {
                         ArtistInfo *objArtistInfo = [self.artistArray objectAtIndex:j];
                         if ([objSelectedArtistInfo.strArtistid integerValue] == [objArtistInfo.strArtistid integerValue])
                         {
                             objArtistInfo.isSelected = 1;
                             break;
                         }
                     }
                 }
                 [self.filterTableView reloadData];
             }
             else
             {
                 [GlobalClass showTost:@"Information not available"];
             }
         } failure:^(NSError *error){
             [GlobalClass showTost:error.localizedDescription];
         } callingCount:0];
    }
    else
    {
        NSString *auctionTypeName = [self getAuctionTypeName:self.auctionType];
        NSString  *strUrl = [NSString stringWithFormat:@"spGetArtistincurrentauction(%@,%@)", auctionTypeName, self.strAuctionId];
        
        [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
         {
             NSMutableArray *artist_Array = (NSMutableArray*)responseObject;
             if (artist_Array.count > 0)
             {
                 self.artistArray = [ArtistInfo parseArtistInfo:artist_Array];
                 
                 for (int i=0; i<self.selecteArtistArray.count; i++)
                 {
                     ArtistInfo *objSelectedArtistInfo = [self.selecteArtistArray objectAtIndex:i];
                     for (int j=0; j<self.artistArray.count; j++)
                     {
                         ArtistInfo *objArtistInfo = [self.artistArray objectAtIndex:j];
                         if ([objSelectedArtistInfo.strArtistid integerValue] == [objArtistInfo.strArtistid integerValue])
                         {
                             objArtistInfo.isSelected = 1;
                             break;
                         }
                     }
                 }
                 [self.filterTableView reloadData];
             }
             else
             {
                 [GlobalClass showTost:@"Information not available"];
             }
         } failure:^(NSError *error){
             [GlobalClass showTost:error.localizedDescription];
         } callingCount:0];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (IBAction)btnRefinepressed:(id)sender
{
    if (self.selecteArtistArray.count > 0)
    {
        [self.delegate didFilterWithSelectedArray:self.selecteArtistArray];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [GlobalClass showTost:@"Please select refine result"];
    }
}

@end
