//
//  CurrentAuctionCollectionViewCell.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/4/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "CurrentAuctionCollectionViewCell.h"
#import "CurrentAuctionViewController.h"
@implementation CurrentAuctionCollectionViewCell
{
    CGRect topFrame;
    CGRect changedTopFrame;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
//    [self.clvAction setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self addTapGestureOnArtistName];
    [self addTapGestureOnProductImage];
}

-(void)addTapGestureOnProductImage
{
    self.imgProduct.userInteractionEnabled = YES;
    self.productImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(imgProductPressed:)];
    self.productImgGesture.numberOfTapsRequired = 1;
    self.productImgGesture.delegate = self;
    self.imgProduct.tag = self.cellIndexPath.row;
    [self.imgProduct addGestureRecognizer:self.productImgGesture];
}

-(void)addTapGestureOnArtistName
{
    self.lblArtistName.userInteractionEnabled = YES;
    self.artistNameGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(lblArtistNamePressed:)];
    self.artistNameGesture.numberOfTapsRequired = 1;
    self.artistNameGesture.delegate = self;
    self.lblArtistName.tag = self.cellIndexPath.row;
    [self.lblArtistName addGestureRecognizer:self.artistNameGesture];
}

-(void)setupSwipGesture
{
    self.viewSwipPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.viewSwipPanGesture.delegate = self;
//    self.viewSwipPanGesture.numberOfTouchesRequired = 1;
//    [self.viewSwipPanGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.viewSwip addGestureRecognizer:self.viewSwipPanGesture];
    
//    self.viewSwipLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwipLeft:)];
//    self.viewSwipLeftGesture.numberOfTouchesRequired = 1;
//    [self.viewSwipLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self addGestureRecognizer:self.viewSwipLeftGesture];
//    
//    self.viewSwipRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwipRight:)];
//    self.viewSwipRightGesture.numberOfTouchesRequired = 1;
//    [self.viewSwipRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self addGestureRecognizer:self.viewSwipRightGesture];
}

//-(void)setupActionArray
//{
//    NSLog(@"auction type = %ld",(long)_currentAuction.auctionType);

//    if (self.currentAuction.auctionType == AuctionTypePast)
//    {
//        self.clvAction_Leading.constant = self.viewSwip.frame.size.width - self.viewSwip.frame.size.width/4;
//        
//        self.arrActionTitle = [[NSArray alloc]initWithObjects:@"Lot\nDetail", nil];
//        self.arrActionImages = [[NSArray alloc]initWithObjects:@"icon-detail.png", nil];
//    }
//    else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
//    {
//        self.clvAction_Leading.constant = self.viewSwip.frame.size.width/2;
//        self.arrActionTitle = [[NSArray alloc] initWithObjects:@"Lot\nDetail",@"Proxy\nBid", nil];
//        self.arrActionImages = [[NSArray alloc] initWithObjects:@"icon-detail.png",@"icon-proxy-bid.png", nil];
//    }
//    else
//    {
//        self.clvAction_Leading.constant =  self.viewSwip.frame.size.width/4;
//        self.arrActionTitle = [[NSArray alloc]initWithObjects:@"Bid\nHistory",@"Lot\nDetail",@"Proxy\nBid",@"Bid\nNow", nil];
//        
//        self.arrActionImages = [[NSArray alloc] initWithObjects:@"icon-bid-history.png",@"icon-detail.png",@"icon-proxy-bid.png",@"icon-bid-now.png", nil];
//    }
//    [self.clvAction registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellWithReuseIdentifier:@"ActionCell"];
//    self.clvAction.delegate = self;
//    self.clvAction.dataSource = self;
//    [self.clvAction reloadData];
//}

#pragma mark- CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrAction.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentAuction.auctionType == AuctionTypePast)
    {
        return   CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    }
    else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
    {
        return   CGSizeMake((collectionView.frame.size.width/2)-8, collectionView.frame.size.height);
    }
    else
    {
        return   CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.clvAction dequeueReusableCellWithReuseIdentifier:@"ActionCell" forIndexPath:indexPath];
//    [cell.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    UILabel *lblActionTitle = (UILabel *)[cell viewWithTag:11];
    UIImageView *imgAction = (UIImageView *)[cell viewWithTag:102];
    
    NSDictionary *actionDic = [self.arrAction objectAtIndex:indexPath.row];
    lblActionTitle.text = actionDic[@"title"];
    imgAction.image = [UIImage imageNamed:actionDic[@"image"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (self.currentAuction.auctionType == AuctionTypePast)
    {
        if (indexPath.row==0)
        {
            [self showProductDetail];
        }
    }
    else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
    {
        if (indexPath.row==0)
        {
            [self proxyBid];
        }
        else if (indexPath.row==1)
        {
            [self showProductDetail];
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            [self bidNow];
        }
        else if (indexPath.row==1)
        {
            [self proxyBid];
        }
        else if (indexPath.row==2)
        {
            [self showProductDetail];
        }
        else if (indexPath.row==3)
        {
            [self.delegate showBidHistory:self.currentAuction];
        }
    }
}

-(void)cancelTask
{
    if ([self.delegate isKindOfClass:[CurrentAuctionViewController class]])
    {
        CurrentAuctionViewController *objCurrentAuctionViewController = (CurrentAuctionViewController*)self.delegate;
        [objCurrentAuctionViewController.task cancel];
        objCurrentAuctionViewController.task = nil;
    }
}

-(void)showProductDetail
{
    [self cancelTask];
    [self.delegate showProductDetail:self.currentAuction];
}

-(void)bidNow
{
   // [self cancelTask];
    [self.delegate bidNow:self.currentAuction bidDelegate:self.delegate];
}

-(void)proxyBid
{
    //[self cancelTask];
    if (self.currentAuction.auctionType == AuctionTypeCurrent)
    {
        [self.delegate currentProxyBid:self.currentAuction bidDelegate:self.delegate];
    }
    else
    {
        [self.delegate upcomingProxyBid:self.currentAuction bidDelegate:self.delegate];
    }
}

- (IBAction)imgProductPressed:(UITapGestureRecognizer *)sender
{
    [self showProductDetail];
}

- (IBAction)lblArtistNamePressed:(UITapGestureRecognizer *)sender
{
    [self cancelTask];
    [self.delegate showArtistInfo:self.currentAuction];
}

- (void)pan:(UIPanGestureRecognizer *)sender
{
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown,
        UIPanGestureRecognizerDirectionLeft,
        UIPanGestureRecognizerDirectionRight
    };
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            topFrame = self.viewSwip.frame;
            changedTopFrame = self.viewSwip.frame;
            
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint velocity = [sender velocityInView:sender.view];
            
            BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
            
            if (isVerticalGesture)
            {
                return;
            }
            
            else
            {
                if (velocity.x > 0)
                {
                    direction = UIPanGestureRecognizerDirectionRight;
                }
                else
                {
                    direction = UIPanGestureRecognizerDirectionLeft;
                }
            }

            switch (direction)
            {
                case UIPanGestureRecognizerDirectionLeft: {
                    [self handleLeftGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    [self handleRightGesture:sender];
                    break;
                }
                default: {
                    break;
                }
            }
            break;

        }
        case UIGestureRecognizerStateRecognized:
        {
            if (direction == UIPanGestureRecognizerDirectionLeft)
            {
                [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.viewSwip.frame = topFrame;
                    } completion:^(BOOL finished){
                    topFrame.origin.x = topFrame.origin.x + 40;
                    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        self.viewSwip.frame = topFrame; } completion:^(BOOL finished){                     self.currentAuction.isSwipOn = 1;}];}];
            }
            else
            {
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.viewSwip.frame = topFrame;
                    } completion:^(BOOL finished){self.currentAuction.isSwipOn = 0;}];
            }
            direction = UIPanGestureRecognizerDirectionUndefined;

            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"C");
            break;
        }

//        case UIGestureRecognizerStateEnded:
//        {
//            direction = UIPanGestureRecognizerDirectionUndefined;
//            break;
//        }
            
        default:
            break;
    }
    
}

- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"Left");
    
    if (self.currentAuction.auctionType == AuctionTypePast)
    {
        
        topFrame.origin.x = -(self.viewSwip.frame.size.width/4);
    }
    else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
    {
        
        topFrame.origin.x = -(self.viewSwip.frame.size.width/2);
    }
    else
    {

        topFrame.origin.x = (self.viewSwip.frame.size.width/4) - self.viewSwip.frame.size.width;
    }
    topFrame.origin.x = topFrame.origin.x - 40;
    
    if (changedTopFrame.origin.x <= topFrame.origin.x)
    {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.viewSwip.frame = topFrame; } completion:^(BOOL finished){ }];

    }
    else
    {
        changedTopFrame.origin.x = changedTopFrame.origin.x - 5;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.viewSwip.frame = changedTopFrame; } completion:^(BOOL finished){ }];
    }

}

- (void)handleRightGesture:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"Right");
    topFrame.origin.x = 5;
    
//    self.clvAction_Leading.constant = self.viewSwip.frame.size.width - self.viewSwip.frame.size.width/4;

//    self.clvAction_Leading.constant =  self.viewSwip.frame.size.width/4;
//    self.clvAction_Leading.constant = self.viewSwip.frame.size.width/2;
    
    if (changedTopFrame.origin.x >= 0)
    {
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.viewSwip.frame = topFrame; } completion:^(BOOL finished){ }];
    }
    else
    {
        changedTopFrame.origin.x = changedTopFrame.origin.x + 5;
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.viewSwip.frame = changedTopFrame; } completion:^(BOOL finished){ }];
    }
    
}

- (IBAction)viewSwipLeft:(UISwipeGestureRecognizer *)sender
{
    if (self.currentAuction.isSwipOn == 0)
    {
        self.currentAuction.isSwipOn = 1;
//        CGRect basketTopFrame = self.viewSwip.frame;
        if (self.currentAuction.auctionType == AuctionTypePast)
        {
            topFrame.origin.x = -(self.viewSwip.frame.size.width/4);
        }
        else if (self.currentAuction.auctionType == AuctionTypeUpcoming)
        {
            topFrame.origin.x = -(self.viewSwip.frame.size.width/2);
        }
        else
        {
            topFrame.origin.x = (self.viewSwip.frame.size.width/4) - self.viewSwip.frame.size.width;
        }
        
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.viewSwip.frame = topFrame; } completion:^(BOOL finished){ }];
        
    }

}

- (IBAction)viewSwipRight:(UISwipeGestureRecognizer *)sender
{
    if (self.currentAuction.isSwipOn == 1)
    {
        self.currentAuction.isSwipOn = 0;
        CGRect swipViewFrame = self.viewSwip.frame;
        swipViewFrame.origin.x = 5;
        [UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{ self.viewSwip.frame = swipViewFrame; } completion:^(BOOL finished){/*done*/}];
    }
}

- (IBAction)btnLotPressed:(UIButton *)sender
{
    [self showProductDetail];
}

- (IBAction)btnMaximizeImagePressed:(UIButton *)sender
{
    [self cancelTask];
    [self.delegate zoomImage:self.currentAuction fromImageView:self.imgProduct];
}

- (IBAction)btnAdd_DeleteGalleryPressed:(UIButton *)sender
{
    [self cancelTask];
    
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"icon-add-to-gallery.png"]])
    {
        [self.delegate insertItemToMyAuctionGallery:self.currentAuction];
    }
    else if ([sender.currentImage isEqual:[UIImage imageNamed:@"icon-remove.png"]])
    {
        [self.delegate insertItemToMyAuctionGallery:self.currentAuction];
    }
    else
    {}
}

- (IBAction)btnShortInfoPressed:(UIButton *)sender
{
    self.currentAuction.cellType = 1;
    [self.cellClv reloadItemsAtIndexPaths:@[self.cellIndexPath]];
}

- (IBAction)btnClosePressed:(id)sender
{
    self.currentAuction.cellType = 0;
    [self.cellClv reloadItemsAtIndexPaths:@[self.cellIndexPath]];
}

- (IBAction)btnBidNowPressed:(UIButton *)sender
{
    [self bidNow];
}

- (IBAction)btnProxyBidPressed:(UIButton *)sender
{
    [self proxyBid];
}

- (IBAction)btnDetailPressed:(UIButton *)sender
{
    [self showProductDetail];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocity = [panGesture velocityInView:panGesture.view];
        
        BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
        
        if (isVerticalGesture)
        {
            if (velocity.y > 0)
            {
                return NO;
            } else {
                return NO;
            }
        }
    }
    return YES;
}

@end
