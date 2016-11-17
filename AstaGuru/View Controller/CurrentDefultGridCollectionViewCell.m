//
//  CurrentDefultGridCollectionViewCell.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CurrentDefultGridCollectionViewCell.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "ClsSetting.h"
#define TRY_AN_ANIMATED_GIF 0
@interface CurrentDefultGridCollectionViewCell()
{
    NSArray *arrActionTitle;
    NSArray *arrActionImages;
    
}
@end
@implementation CurrentDefultGridCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"_htlblArtistName:%f",_htlblArtistName.constant);
    arrActionTitle=[[NSArray alloc]initWithObjects:@"Bid\nHistory",@"Lot\nDetail",@"Proxy\nBid",@"Bid\nNow", nil];
     arrActionImages=[[NSArray alloc]initWithObjects:@"icon-bid-history.png",@"icon-detail.png",@"icon-proxy-bid.png",@"icon-bid-now.png", nil];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
  [_clvAction setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    swipeRight.numberOfTouchesRequired = 1;
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
   
    swipeLeft.numberOfTouchesRequired = 1;
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeft];
}
- (void)didSwipeRight:(UISwipeGestureRecognizer *)swipe
{
    if (_objCurrentOccution.IsSwapOn==1)
    {
        _objCurrentOccution.IsSwapOn=0;
        
        //self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGRect napkinBottomFrame = _viwSwap.frame;
        napkinBottomFrame.origin.x = 0;
        [UIView animateWithDuration:0.5 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{ _viwSwap.frame = napkinBottomFrame; } completion:^(BOOL finished){/*done*/}];
        

    }
   
    NSLog(@"Right");
}
- (void)didSwipeLeft:(UISwipeGestureRecognizer *)swipe
{
    if (_objCurrentOccution.IsSwapOn==0)
    {
        
       
        
        
       /* [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _viwSwap.frame = CGRectMake(_viwSwap.frame.origin.x, _viwSwap.frame.origin.y, _viwSwap.frame.size.width, _viwSwap.frame.size.height);
        }
                         completion:^(BOOL finished) {
                             //position screen left after animation
                             _viwSwap.frame = CGRectMake(-_viwSwap.frame.size.width+120, _viwSwap.frame.origin.y, _viwSwap.frame.size.width, _viwSwap.frame.size.height);
                         }];*/
       // self.frame=CGRectMake(5, 0, self.frame.size.width, self.frame.size.height);
        _objCurrentOccution.IsSwapOn=1;
        CGRect basketTopFrame = _viwSwap.frame;
        basketTopFrame.origin.x =(_viwSwap.frame.size.width/4)- _viwSwap.frame.size.width;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ _viwSwap.frame = basketTopFrame; } completion:^(BOOL finished){ }];
        
        
    }
   
 
}

- (IBAction)btnShortInfoPressed:(id)sender
{
    if (_isMyAuctionGallery==1)
    {
        _objMyAuctionGallery.strTypeOfCell=@"1";
        [_CurrentOccutiondelegate btnShotinfoPressed:_iSelectedIndex];
    }
    else
    {
        _objCurrentOccution.strTypeOfCell=@"1";
        [_CurrentOccutiondelegate btnShotinfoPressed:_iSelectedIndex];
    }
    
}
- (IBAction)btnClosePressed:(id)sender
{
    if (_isMyAuctionGallery==1)
    {
        _objMyAuctionGallery.strTypeOfCell=@"0";
        [_CurrentOccutiondelegate btnShotinfoPressed:_iSelectedIndex];
    }
    else
    {
    _objCurrentOccution.strTypeOfCell=@"0";
    [_CurrentOccutiondelegate btnShotinfoPressed:_iSelectedIndex];
    }
}



#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return   CGSizeMake(((collectionView1.frame.size.width-(collectionView1.frame.size.width/4))/5),collectionView1.frame.size.height);
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
            return arrActionTitle.count;
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
   
   cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActionCell" forIndexPath:indexPath];
    [cell.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:11];
    lblTitle.text=[arrActionTitle objectAtIndex:indexPath.row];
    UIImageView *img = (UIImageView *)[cell viewWithTag:102];
    img.image=[UIImage imageNamed:[arrActionImages objectAtIndex:indexPath.row]];
    [img setImage:[UIImage imageNamed:[arrActionImages objectAtIndex:indexPath.row]]];
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    if (indexPath.row==0)
    {
         [_CurrentOccutiondelegate ListSwipeOptionpressed:1 currentCellIndex:_iSelectedIndex];
    }
    else if (indexPath.row==1)
    {
    [_CurrentOccutiondelegate ListSwipeOptionpressed:2 currentCellIndex:_iSelectedIndex];
    }
    else if (indexPath.row==2)
    {
    [_CurrentOccutiondelegate ListSwipeOptionpressed:3 currentCellIndex:_iSelectedIndex];
    }
      else if (indexPath.row==3)
    {
        [_CurrentOccutiondelegate ListSwipeOptionpressed:4 currentCellIndex:_iSelectedIndex];
    }
}

- (IBAction)btnBidHistory:(id)sender {
}
@end
