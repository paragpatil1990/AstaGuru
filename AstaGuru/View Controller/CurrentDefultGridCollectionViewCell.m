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
@interface CurrentDefultGridCollectionViewCell()<UIGestureRecognizerDelegate>
{
    NSArray *arrActionTitle;
    NSArray *arrActionImages;
    CGRect napkinBottomFrame;
}
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@end

@implementation CurrentDefultGridCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_clvAction setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self setuparray];
}

-(void)setupGesture
{
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipeRight.numberOfTouchesRequired = 1;
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    swipeLeft.numberOfTouchesRequired = 1;
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeft];

}
-(void)setuparray
{
    if (_isCommingFromPast == 1)
    {
        _clvAction_Leading.constant =  _viwSwap.frame.size.width - _viwSwap.frame.size.width/4;

        arrActionTitle=[[NSArray alloc]initWithObjects:@"Lot\nDetail", nil];
        arrActionImages=[[NSArray alloc]initWithObjects:@"icon-detail.png", nil];
    }
    else if (_isCommingFromUpcoming == 1)
    {
        _clvAction_Leading.constant = _viwSwap.frame.size.width/2;
        arrActionTitle=[[NSArray alloc]initWithObjects:@"Lot\nDetail",@"Proxy\nBid", nil];
        arrActionImages=[[NSArray alloc]initWithObjects:@"icon-detail.png",@"icon-proxy-bid.png", nil];
    }
    else
    {
        _clvAction_Leading.constant =  _viwSwap.frame.size.width/4;
        arrActionTitle=[[NSArray alloc]initWithObjects:@"Bid\nHistory",@"Lot\nDetail",@"Proxy\nBid",@"Bid\nNow", nil];
        
        arrActionImages=[[NSArray alloc]initWithObjects:@"icon-bid-history.png",@"icon-detail.png",@"icon-proxy-bid.png",@"icon-bid-now.png", nil];
    }
    [_clvAction reloadData];
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
        _objCurrentOccution.isAnimate = @"1";
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
        _objCurrentOccution.isAnimate = @"1";
        _objCurrentOccution.strTypeOfCell=@"0";
        [_CurrentOccutiondelegate btnShotinfoPressed:_iSelectedIndex];
    }
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)swipe
{
    if (_objCurrentOccution.IsSwapOn==1)
    {
        _objCurrentOccution.IsSwapOn=0;
        napkinBottomFrame = _viwSwap.frame;
        napkinBottomFrame.origin.x = 0;
        [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{ _viwSwap.frame = napkinBottomFrame; } completion:^(BOOL finished){/*done*/}];
    }
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)swipe
{
    if (_objCurrentOccution.IsSwapOn == 0)
    {
        _objCurrentOccution.IsSwapOn = 1;
        CGRect basketTopFrame = _viwSwap.frame;
        if (_isCommingFromPast == 1)
        {
            basketTopFrame.origin.x = -(_viwSwap.frame.size.width/4);
        }
        else if (_isCommingFromUpcoming == 1)
        {
            basketTopFrame.origin.x = -(_viwSwap.frame.size.width/2);
        }
        else
        {
            basketTopFrame.origin.x = (_viwSwap.frame.size.width/4) - _viwSwap.frame.size.width;
        }

        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ _viwSwap.frame = basketTopFrame; } completion:^(BOOL finished){ }];
    }
}

#pragma mark- CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrActionTitle.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isCommingFromPast == 1)
    {
        return   CGSizeMake(collectionView1.frame.size.width, collectionView1.frame.size.height);
    }
    else if (_isCommingFromUpcoming == 1)
    {
        return   CGSizeMake((collectionView1.frame.size.width/2)-8, collectionView1.frame.size.height);
    }
    else
    {
        return   CGSizeMake(collectionView1.frame.size.width/4, collectionView1.frame.size.height);
    }
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
    if (_isCommingFromPast == 1)
    {
        if (indexPath.row==0)
        {
            [_CurrentOccutiondelegate ListSwipeOptionpressed:2 currentCellIndex:_iSelectedIndex];
        }
    }
    else if (_isCommingFromUpcoming == 1)
    {
        if (indexPath.row==0)
        {
            [_CurrentOccutiondelegate ListSwipeOptionpressed:2 currentCellIndex:_iSelectedIndex];
        }
        else if (indexPath.row==1)
        {
            [_CurrentOccutiondelegate ListSwipeOptionpressed:3 currentCellIndex:_iSelectedIndex];
        }
    }
    else
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
    
}

- (IBAction)btnBidHistory:(id)sender
{
}

@end
