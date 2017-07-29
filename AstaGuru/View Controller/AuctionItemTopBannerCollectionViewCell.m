//
//  TOPCollectionViewCell.m
//  AstaGuru
//
//  Created by Aarya Tech on 01/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AuctionItemTopBannerCollectionViewCell.h"
#import "ArtistViewController.h"
#import "ItemOfPastAuctionViewController.h"
@implementation AuctionItemTopBannerCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

/*- (IBAction)btnFilterPressed:(UIButton *)sender
{
    [self.delegate showFilter:self.currentAuction delegate:self array:self.
    [self.delegate showFilter:self.currentAuction delegate:self array:self.selele :self.delegate];
}*/

- (IBAction)btnAuctionAnalysisPressed:(UIButton *)sender
{
    [self.delegate showAuctionAnalisys];
}

- (IBAction)btnCurrencyPressed:(UIButton *)sender
{
    [self.delegate didCurrencyChanged:self.cellClv];
}

- (IBAction)btnGridPressed:(UIButton *)sender
{
    [self.delegate setIsList:0];
    [self.cellClv reloadData];
}

- (IBAction)btnListPressed:(UIButton *)sender
{
    [self.delegate setIsList:1];
    [self.cellClv reloadData];
}

- (IBAction)btnCurrentAuctionPressed:(UIButton *)sender
{
    if (!sender.selected)
    {
        [self.delegate didChangedAuctionType];
    }
}

- (IBAction)btnUpcomingAuctionPressed:(UIButton *)sender
{
    if (!sender.selected)
    {
        [self.delegate didChangedAuctionType];
    }
}

- (IBAction)btnPastAuctionPressed:(UIButton *)sender
{
    if (!sender.selected)
    {
        [self.delegate didChangedAuctionType];
    }
}

- (IBAction)btnReadMorePressed:(UIButton*)sender
{
    [self.delegate didReadMoreChanged];
}

@end
