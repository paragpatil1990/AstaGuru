//
//  TableViewHelper.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/26/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "TableViewHelper.h"
#import "BaseViewController.h"
#import "ItemOfUpcomingViewController.h"
#import "ItemOfPastAuctionViewController.h"
#import "CurrentAuctionViewController.h"
@implementation TableViewHelper

- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect style:UITableViewStylePlain];
    if (self) {
        self.arrOption = [[NSArray alloc] initWithObjects:@"Browse Current Auctions",@"Browse Upcoming Auctions",@"View past Auction Results", nil];
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}

-(void)addSearchTableView
{
    UIViewController *parent = (UIViewController*)self.base;
    [parent.view addSubview:self];
    [parent.view bringSubviewToFront:self];
    
//    UIView *subView = self.searchTableView;
//    UIView *parent = self.view;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent.view
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent.view
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Top
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parent.topLayoutGuide
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0.0];
    
    //Bottom
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                              toItem:parent.bottomLayoutGuide
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:20.0];
    
    
    //Add constraints to the Parent
    [parent.view addConstraint:top];
    [parent.view addConstraint:trailing];
    [parent.view addConstraint:bottom];
    [parent.view addConstraint:leading];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrOption.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.arrOption objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"WorkSans-Regular" size:16];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.base searchBar].text isEqualToString:@""])
    {
        [GlobalClass showTost:@"Please enter search text"];
    }
    else
    {
        if (indexPath.row==0)
        {
            [self spSearch:@"Current"];
        }
        else if (indexPath.row==1)
        {
            [self spSearch:@"Upcomming"];
        }
        else if (indexPath.row==2)
        {
            [self spSearch:@"Past"];
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    UIView *sv = [[UIView alloc] initWithFrame:CGRectMake(15, 0, v.frame.size.width-15, 1)];
    sv.backgroundColor=[UIColor lightGrayColor];
    sv.alpha = 0.4;
    [v addSubview:sv];
    return v;
}

-(void)spSearch:(NSString *)strSearchType
{
    NSArray *words = [[self.base searchBar].text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger wordCount = [words count];
    NSString  *strUrl=[NSString stringWithFormat:@"spSearch(%@,%@,%ld)", [GlobalClass trimWhiteSpaceAndNewLine:[self.base searchBar].text], strSearchType, (long)wordCount];
    
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:[self.base view] success:^(id responseObject)
     {
         NSMutableArray *resourceArray = (NSMutableArray*)responseObject;
         UIViewController *vc = (UIViewController*)self.base;
         if ([strSearchType isEqualToString:@"Current"])
         {
             if (resourceArray.count==0)
             {
                 [GlobalClass showTost:@"No Lots found for this artist search result in Current Auction"];
             }
             else
             {
                 NSMutableArray *arrSearchResult = [CurrentAuction parseAuction:resourceArray auctionType:AuctionTypeCurrent];
                 [self.base removeSearchBar];
                 if ([self.base isKindOfClass:[CurrentAuctionViewController class]])
                 {
                     [self.base setIsSearch:YES];
                     [self.base setSearchUrl:strUrl];
                     [self.base setArrSearch:arrSearchResult];
                     [self.base getSetAuctionData];
                 }
                 else
                 {
                     CurrentAuctionViewController *objCurrentAuctionViewController = [vc.storyboard instantiateViewControllerWithIdentifier:@"CurrentAuctionViewController"];
                     objCurrentAuctionViewController.arrSearch = [arrSearchResult mutableCopy];
                     objCurrentAuctionViewController.searchUrl = strUrl;
                     objCurrentAuctionViewController.isSearch = YES;
                     [vc.navigationController pushViewController:objCurrentAuctionViewController animated:YES];
                 }
                 
             }
         }
         else if ([strSearchType isEqualToString:@"Upcomming"])
         {
             if (resourceArray.count == 0)
             {
                 [GlobalClass showTost:@"No Lots found for this artist search result in Upcomming Auction"];
             }
             else
             {
                 NSArray *arrSearchResult = [CurrentAuction parseAuction:resourceArray auctionType:AuctionTypeUpcoming];
                 [self.base removeSearchBar];
                 if ([self.base isKindOfClass:[ItemOfUpcomingViewController class]])
                 {
                     [self.base setIsSearch:YES];
                     [self.base setTitle:@"Upcoming Auctions"];
                     [self.base setUpcomingAuctionItemArray:arrSearchResult];
                     [[self.base clvUpcomingAuctionItem] reloadData];
                 }
                 else
                 {
                     ItemOfUpcomingViewController *objItemOfUpcomingViewController = [vc.storyboard instantiateViewControllerWithIdentifier:@"ItemOfUpcomingViewController"];
                     objItemOfUpcomingViewController.isSearch = YES;
                     objItemOfUpcomingViewController.upcomingAuctionItemArray = arrSearchResult;
                     [vc.navigationController pushViewController:objItemOfUpcomingViewController animated:YES];
                 }
             }
         }
         else if ([strSearchType isEqualToString:@"Past"])
         {
             if (resourceArray.count == 0)
             {
                 [GlobalClass showTost:@"No Lots found for this artist search result in Past Auction"];
             }
             else
             {
                 NSArray *arrSearchResult = [CurrentAuction parseAuction:resourceArray auctionType:AuctionTypePast];
                 [self.base removeSearchBar];
                 if ([self.base isKindOfClass:[ItemOfPastAuctionViewController class]])
                 {
                     [self.base setIsSearch:YES];
                     [self.base setTitle:@"Past Auctions"];
                     [self.base setPastAuctionItemArray:arrSearchResult];
                     [[self.base clvPastAuctionItem] reloadData];
                 }
                 else
                 {
                     ItemOfPastAuctionViewController *objItemOfPastAuctionViewController = [vc.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
                     objItemOfPastAuctionViewController.isSearch = YES;
                     objItemOfPastAuctionViewController.pastAuctionItemArray = arrSearchResult;
                     [vc.navigationController pushViewController:objItemOfPastAuctionViewController animated:YES];
                     
                 }
             }
         }
     } failure:^(NSError *error)
    {[GlobalClass showTost:error.localizedDescription];} callingCount:0];
}

@end
