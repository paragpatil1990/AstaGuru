//
//  ViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "HomeViewController.h"
#import "ItemOfUpcomingViewController.h"
#import "ItemOfPastAuctionViewController.h"
#import "RecordPriceArtworksViewController.h"
@interface HomeViewController ()<YTPlayerViewDelegate,KASlideShowDelegate, KASlideShowDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
{
    NSMutableArray *banner1_Array;
    NSMutableArray *banner2_Array;
    NSMutableArray *banner3_Array;
    NSMutableArray *video_Array;
}

@end

@implementation HomeViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"AstaGuru";
    
    [self setNavigationBarSlideButton];//Target:self.revealViewController selector:@selector(revealToggle:)];
    [self setNavigationRightBarButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpNavigationItem];
    
    banner1_Array = [[NSMutableArray alloc] init];
    banner2_Array = [[NSMutableArray alloc] init];
    banner3_Array = [[NSMutableArray alloc] init];
    video_Array = [[NSMutableArray alloc] init];
    
    _clvVideoPlayer.delegate = self;
    _clvVideoPlayer.dataSource = self;
    
    [self spGetHomeBanner];
    
    self.banner1PageControl.hidden = YES;
    self.banner2PageControl.hidden = YES;
    self.videoPageControl.hidden = YES;
    self.lblUpcomingText.hidden = YES;
    self.lblVideosText.hidden = YES;
    self.lblVideosDesc.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSString *isNoti = [[NSUserDefaults standardUserDefaults] valueForKey:@"isNoti"];
    NSLog(@"isNoti == %@",isNoti);
    
    if ([isNoti isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isNoti"];
    }
}

-(void)spGetHomeBanner
{
    NSString  *strUrl = @"spGetHomeBanner";
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id  responseObject)
     {
         self.banner1PageControl.hidden = NO;
         self.banner2PageControl.hidden = NO;
         self.videoPageControl.hidden = NO;
         self.lblUpcomingText.hidden = NO;
         self.lblVideosText.hidden = NO;
         self.lblVideosDesc.hidden = NO;

         NSArray *bannerArray = responseObject;
         [banner1_Array removeAllObjects];
         [banner2_Array removeAllObjects];
         [banner3_Array removeAllObjects];
         for (int i=0; i< bannerArray.count; i++)
         {
             NSDictionary *bannerDic = [bannerArray objectAtIndex:i];//[GlobalClass removeNullOnly:[bannerArray objectAtIndex:i]];
             if ([[bannerDic valueForKey:@"bannerType"] intValue] == 1)
             {
                 [banner1_Array addObject:bannerDic];
             }
             else if ([[bannerDic valueForKey:@"bannerType"] intValue] == 2)
             {
                 [banner2_Array addObject:bannerDic];
             }
             else if ([[bannerDic valueForKey:@"bannerType"] intValue] == 4)
             {
                 [banner3_Array addObject:bannerDic];
             }
             else if ([[bannerDic valueForKey:@"bannerType"] intValue] == 5)
             {
                 [video_Array addObject:bannerDic];
             }
         }
         
         if (banner1_Array.count != 0)
         {
             _banner1PageControl.numberOfPages = banner1_Array.count;
             
             _bannerView1.delegate = self;
             _bannerView1.dataSource = self;
             [_bannerView1 setDelay:3]; // Delay between transitions
             [_bannerView1 setTransitionDuration:2]; // Transition duration
             [_bannerView1 setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
             [_bannerView1 setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
             [_bannerView1 setImagesDataSource:banner1_Array];
             //        [_baner_View addImagesFromResources:_images_Array]; // Add images from resources
             [_bannerView1 addGesture:KASlideShowGestureAll]; // Gesture to go previous/next directly on the image
//             [_bannerView1 start];
         }
         else
         {
             _banner1PageControl.hidden = YES;
         }
        

         if (banner2_Array.count != 0)
         {
             _banner2PageControl.numberOfPages = banner2_Array.count;

             _bannerView2.delegate = self;
             _bannerView2.dataSource = self;
             [_bannerView2 setDelay:3]; // Delay between transitions
             [_bannerView2 setTransitionDuration:2]; // Transition duration
             [_bannerView2 setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
             [_bannerView2 setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
             [_bannerView2 setImagesDataSource:banner2_Array];
             //        [_baner_View addImagesFromResources:_images_Array]; // Add images from resources
             [_bannerView2 addGesture:KASlideShowGestureAll]; // Gesture to go previous/next directly on the image
             //             [_bannerView1 start];
         }
         else
         {
             _banner2PageControl.hidden = YES;
         }
         
         if (banner3_Array.count != 0)
         {
             NSDictionary *record = banner3_Array[0];
             [_recordPriceArtWorkImageView setImageWithURL:[NSURL URLWithString:record[@"homebannerImg"]] placeholderImage:[UIImage imageNamed:@"homebannerImg"]];
         }
         
         if (video_Array.count != 0)
         {
             _videoPageControl.numberOfPages = video_Array.count;
         }
         else
         {
             _videoPageControl.hidden = YES;
         }
         [self.clvVideoPlayer reloadData];

     }failure:^(NSError *error){
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
}

#pragma mark - KASlideShow delegate

-(void )slideShow:(KASlideShow *)slideShow imageForPosition:(KASlideShowPosition)position imageView:(UIImageView *)imageView index:(NSInteger)index
{
    if (slideShow == _bannerView1)
    {
        NSDictionary *record = banner1_Array[index];
        [imageView setImageWithURL:[NSURL URLWithString:record[@"homebannerImg"]] placeholderImage:[UIImage imageNamed:@"homebannerImg"]];
        self.banner1PageControl.currentPage = slideShow.currentIndex;
    }
    else if (slideShow == _bannerView2)
    {
        NSDictionary *record = banner2_Array[index];
        [imageView setImageWithURL:[NSURL URLWithString:record[@"homebannerImg"]] placeholderImage:[UIImage imageNamed:@"homebannerImg"]];
        self.banner2PageControl.currentPage = slideShow.currentIndex;
    }
    else
    {
        
    }
}

- (void)kaSlideShowWillShowNext:(KASlideShow *)slideShow
{
//    if (slideShow == _bannerView1)
//    {
//        self.banner1PageControl.currentPage = slideShow.currentIndex;
//    }
//    else if (slideShow == _bannerView2)
//    {
//        self.banner2PageControl.currentPage = slideShow.currentIndex;
//    }
}
- (void)kaSlideShowWillShowPrevious:(KASlideShow *)slideShow
{
//    if (slideShow == _bannerView1)
//    {
//        self.banner1PageControl.currentPage = slideShow.currentIndex;
//    }
//    else if (slideShow == _bannerView2)
//    {
//        self.banner2PageControl.currentPage = slideShow.currentIndex;
//    }
}
- (void) kaSlideShowDidShowNext:(KASlideShow *)slideShow
{
//    if (slideShow == _bannerView1)
//    {
//        self.banner1PageControl.currentPage = slideShow.currentIndex;
//    }
//    else if (slideShow == _bannerView2)
//    {
//        self.banner2PageControl.currentPage = slideShow.currentIndex;
//    }
}
-(void)kaSlideShowDidShowPrevious:(KASlideShow *)slideShow
{
//    if (slideShow == _bannerView1)
//    {
//        self.banner1PageControl.currentPage = slideShow.currentIndex;
//    }
//    else if (slideShow == _bannerView2)
//    {
//        self.banner2PageControl.currentPage = slideShow.currentIndex;
//    }
}

-(void) kaSlideShowDidSelect:(KASlideShow *)slideShow atIndex:(NSInteger)index
{
    if (slideShow == _bannerView1)
    {
        [self didSelectBanner:[GlobalClass removeNullOnly:banner1_Array[index]]];
    }
    else if (slideShow == _bannerView2)
    {
        [self didSelectBanner:[GlobalClass removeNullOnly:banner2_Array[index]]];
    }
    else
    {
    }
}

-(void)didSelectBanner:(NSDictionary*)banner
{
    if ([banner[@"auctionPageUrl"] isEqualToString:@"Current"])
    {
        [self didSelectBottomMenu:1];
    }
    else if ([banner[@"auctionPageUrl"] isEqualToString:@"Upcomming"])
    {
        UpcommingAuction *objUpcomingAuctionData = [[UpcommingAuction alloc]init];
        objUpcomingAuctionData.strAuctionname = banner[@"Auctionname"];
        objUpcomingAuctionData.strAuctionId = banner[@"urlID"];
        objUpcomingAuctionData.strAuctiontitle = banner[@"Auctionname"];
        ItemOfUpcomingViewController *objItemOfUpcomingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfUpcomingViewController"];
        objItemOfUpcomingViewController.upcomingAuction = objUpcomingAuctionData;
        [self.navigationController pushViewController:objItemOfUpcomingViewController animated:YES];
        
    }
    else
    {
        PastAuction *objPastAuctionData = [[PastAuction alloc]init];
        objPastAuctionData.strAuctionname = banner[@"Auctionname"];
        objPastAuctionData.strAuctionId = banner[@"urlID"];
        objPastAuctionData.strAuctiontitle = banner[@"Auctionname"];
        ItemOfPastAuctionViewController *objItemOfPastAuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemOfPastAuctionViewController"];
        objItemOfPastAuctionViewController.pastAuction = objPastAuctionData;
        [self.navigationController pushViewController:objItemOfPastAuctionViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.clvVideoPlayer)
    {
        return video_Array.count;
    }
    else
    {
        return [self arrBottomMenu].count;
    }
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    _videoPageControl.currentPage = indexPath.row;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (collectionView == self.clvVideoPlayer)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YTPlayerCell" forIndexPath:indexPath];
        
        NSDictionary *videoDic = [video_Array objectAtIndex:indexPath.row];
        YTPlayerView *YTPlayer = (YTPlayerView *)[cell viewWithTag:101];
        YTPlayer.delegate=self;
        NSString *strVideoId=[self extractYoutubeIdFromLink:[videoDic valueForKey:@"homebannerImg"]];
        NSDictionary *playerVars = @{
                                     @"controls" : @0,
                                     @"playsinline" : @0,
                                     @"autohide" : @1,
                                     @"showinfo" : @0,
                                     @"modestbranding" : @0,
                                     @"autoplay" : @0,
                                     @"loop" : @1,
                                     @"origin":@"http://www.youtube.com"
                                     };
        
        // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
        [YTPlayer loadWithVideoId:strVideoId playerVars:playerVars];
        //        [YTPlayer playVideo];
        
        _videoPageControl.currentPage = indexPath.row;
    }
    else if (collectionView == _clvBottomMenu)
    {
        cell = [self configureBottomMenuCell:_clvBottomMenu IndexPath:indexPath];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.clvVideoPlayer)
    {
        return CGSizeMake(self.clvVideoPlayer.frame.size.width, self.clvVideoPlayer.frame.size.height);
    }
    else
    {
        float width=(self.view.frame.size.width/4);
        return CGSizeMake(width, collectionView.frame.size.height);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //_videoPageControl.currentPage = indexPath.row;

//    YTPlayerView *YTPlayer = (YTPlayerView *)[cell viewWithTag:101];
//    [YTPlayer stopVideo];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.clvVideoPlayer)
    {
        if (video_Array.count > 0)
        {
        }
    }
    else if(collectionView==_clvBottomMenu)
    {
        [self didSelectBottomMenu:indexPath.row];
    }
}

- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    switch (state)
    {
        case kYTPlayerStatePlaying:
            NSLog(@"Paused playing");
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        case kYTPlayerStateQueued:
            [_clvVideoPlayer reloadData];
            NSLog(@"Queued state");
            break;
        case kYTPlayerStateEnded:
            NSLog(@"End state");
            [_clvVideoPlayer reloadData];
            break;
        default:
            break;
    }
}

- (IBAction)recordPriceArtWorkButtonPressed:(UIButton *)sender
{
    RecordPriceArtworksViewController *objRecordPriceArtworksViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RecordPriceArtworksViewController"];
    [self.navigationController pushViewController:objRecordPriceArtworksViewController animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.clvVideoPlayer reloadData];
}
@end
