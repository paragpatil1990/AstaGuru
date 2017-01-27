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

static CGFloat const kBounceValue = 20.0f;

@implementation CurrentDefultGridCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_clvAction setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self setuparray];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipeRight.numberOfTouchesRequired = 1;
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    swipeLeft.numberOfTouchesRequired = 1;
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeft];
    
    
//    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
//    self.panRecognizer.delegate = self;
//    [_viwSwap addGestureRecognizer:self.panRecognizer];

}

-(void)setuparray
{
    if (_isCommingFromPast == 1)
    {
        arrActionTitle=[[NSArray alloc]initWithObjects:@"Lot\nDetail", nil];
        arrActionImages=[[NSArray alloc]initWithObjects:@"icon-detail.png", nil];
    }
    else if (_isCommingFromUpcoming == 1)
    {
        arrActionTitle=[[NSArray alloc]initWithObjects:@"Lot\nDetail",@"Proxy\nBid", nil];
        arrActionImages=[[NSArray alloc]initWithObjects:@"icon-detail.png",@"icon-proxy-bid.png", nil];
    }
    else
    {
        arrActionTitle=[[NSArray alloc]initWithObjects:@"Bid\nHistory",@"Lot\nDetail",@"Proxy\nBid",@"Bid\nNow", nil];
        
        arrActionImages=[[NSArray alloc]initWithObjects:@"icon-bid-history.png",@"icon-detail.png",@"icon-proxy-bid.png",@"icon-bid-now.png", nil];
    }
    [_clvAction reloadData];
}

- (CGFloat)buttonTotalWidth
{
    return (_viwSwap.frame.size.width/3)- _viwSwap.frame.size.width;
}

- (void)panThisCell:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
//            self.panStartPoint = [recognizer translationInView:self.viwSwap];
//            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
            
            napkinBottomFrame = _viwSwap.frame;
            napkinBottomFrame.origin.x = 0;

            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint = [recognizer translationInView:self.viwSwap];
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            BOOL panningLeft = NO;
            if (currentPoint.x < self.panStartPoint.x)
            {  //1
                panningLeft = YES;
            }
            
            if (self.startingRightLayoutConstraintConstant == 0)
            { //2
                //The cell was closed and is now opening
                if (!panningLeft)
                {
                    CGFloat constant = MAX(-deltaX, 0); //3
                    if (constant == 0)
                    { //4
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO]; //5
                    } else {
                        self.contentViewRightConstraint.constant = constant; //6
                    }
                } else {
                    CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]); //7
                    if (constant == [self buttonTotalWidth]) { //8
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO]; //9
                    } else {
                        self.contentViewRightConstraint.constant = constant; //10
                    }
                }
            }else {
                //The cell was at least partially open.
                CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX; //11
                if (!panningLeft) {
                    CGFloat constant = MAX(adjustment, 0); //12
                    if (constant == 0) { //13
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO]; //14
                    } else {
                        self.contentViewRightConstraint.constant = constant; //15
                    }
                } else {
                    CGFloat constant = MIN(adjustment, [self buttonTotalWidth]); //16
                    if (constant == [self buttonTotalWidth]) { //17
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO]; //18
                    } else {
                        self.contentViewRightConstraint.constant = constant;//19
                    }
                }
            }
            
            self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant; //20
        }
            break;
            
        case UIGestureRecognizerStateEnded:
            if (self.startingRightLayoutConstraintConstant == 0) { //1
                //We were opening
                CGFloat halfOfButtonOne =40 / 2; //2
                if (self.contentViewRightConstraint.constant >= halfOfButtonOne) { //3
                    //Open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Re-close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
                
            } else {
                //We were closing
                CGFloat buttonOnePlusHalfOfButton2 = 40 + 40 / 2; //4
                if (self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2) { //5
                    //Re-open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
            break;
            
        case UIGestureRecognizerStateCancelled:
            if (self.startingRightLayoutConstraintConstant == 0) {
                //We were closed - reset everything to 0
                [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
            } else {
                //We were open - reset to the open state
                [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
            }
            break;
            
        default:
            break;
    }
}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion;
{
    float duration = 0;
    if (animated) {
        NSLog(@"Animated!");
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:completion];
}


- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate
{
    if (notifyDelegate) {
//        [self.delegate cellDidClose:self];
    }
    
    if (self.startingRightLayoutConstraintConstant == 0 &&
        self.contentViewRightConstraint.constant == 0) {
        //Already all the way closed, no bounce necessary
        return;
    }
    
    self.contentViewRightConstraint.constant = -kBounceValue;
    self.contentViewLeftConstraint.constant = kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.contentViewRightConstraint.constant = 0;
        self.contentViewLeftConstraint.constant = 0;
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}


- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate
{
    if (notifyDelegate) {
//        [self.delegate cellDidOpen:self];
    }
    
    //1
    if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] &&
        self.contentViewRightConstraint.constant == [self buttonTotalWidth]) {
        return;
    }
    //2
    self.contentViewLeftConstraint.constant = -[self buttonTotalWidth] - kBounceValue;
    self.contentViewRightConstraint.constant = [self buttonTotalWidth] + kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        //3
        self.contentViewLeftConstraint.constant = -[self buttonTotalWidth];
        self.contentViewRightConstraint.constant = [self buttonTotalWidth];
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            //4
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
    NSLog(@"Right");
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)swipe
{
    if (_objCurrentOccution.IsSwapOn==0)
    {
        _objCurrentOccution.IsSwapOn=1;
        CGRect basketTopFrame = _viwSwap.frame;
        basketTopFrame.origin.x =(_viwSwap.frame.size.width/3)- _viwSwap.frame.size.width;
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ _viwSwap.frame = basketTopFrame; } completion:^(BOOL finished){ }];
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

#pragma mark- CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isCommingFromPast == 1)
    {
        return   CGSizeMake(((collectionView1.frame.size.width-(collectionView1.frame.size.width/2))/3),collectionView1.frame.size.height);
    }
    else if (_isCommingFromUpcoming == 1)
    {
        return   CGSizeMake(((collectionView1.frame.size.width-(collectionView1.frame.size.width/3))/4),collectionView1.frame.size.height);
    }
    else
    {
        return   CGSizeMake(((collectionView1.frame.size.width-(collectionView1.frame.size.width/4))/5),collectionView1.frame.size.height);
    }
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

- (IBAction)btnBidHistory:(id)sender {
}
@end
