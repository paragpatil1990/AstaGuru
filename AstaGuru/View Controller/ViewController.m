//
//  ViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "ClsSetting.h"
#import "EGOImageView.h"
#import "CurrentOccutionViewController.h"
#import "AppDelegate.h"
#import "BforeLoginViewController.h"
#import "AfterLoginViewController.h"
#import "PastOccuctionViewController.h"
#import "SearchViewController.h"
@interface ViewController ()<YTPlayerViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *arrmBanner;
    NSMutableArray *arrmBanner2;
    NSMutableArray *arrmBanner3;
    NSMutableArray *arrmBanner4;
    NSMutableArray *arrmBanner5;
    NSMutableArray *arrBottomMenu;
    UIButton *btnBack;
    
}
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrmBanner=[[NSMutableArray alloc]init];
    arrmBanner2=[[NSMutableArray alloc]init];
    arrmBanner3=[[NSMutableArray alloc]init];
    arrmBanner4=[[NSMutableArray alloc]init];
    arrmBanner5=[[NSMutableArray alloc]init];
    arrBottomMenu=[[NSMutableArray alloc]initWithObjects:@"HOME",@"CURRENT",@"UPCOMING",@"PAST", nil];
   
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    self.title=@"AstaGuru";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    
    
   // self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchPressed)];
    
    
    
    
    
    
    
    
    
   
    
    btnBack = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, -20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    
    UIButton *btnBack1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, -20)];
    [btnBack1 setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [btnBack1 addTarget:self action:@selector(myastaguru) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnBack1];
    UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -12;
    UIBarButtonItem *spaceFix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -8;
    [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem,spaceFix1, barButtonItem1]];
    
    
    
    //self.sideleftbarButton.tintColor=[UIColor whiteColor];
   // [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController tapGestureRecognizer];
    [self Getanner];
    _vwCarousel.pagingEnabled=YES;
    
    
    
    _imgVideo.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    
    
    [_imgVideo addGestureRecognizer:tapGesture1];
    
    
    self.searchBar = [[UISearchBar alloc] init];
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
 _htVideoViews.constant=(self.view.frame.size.width/2.15);
    
}
-(void)searchPressed
{
    /*[UIView animateWithDuration:0.5 animations:^{
        btnBack.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        // remove the search button
        self.navigationItem.rightBarButtonItem = nil;
        // add the search bar (which will start out hidden).
        self.navigationItem.titleView = _searchBar;
        _searchBar.alpha = 0.0;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _searchBar.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             [_searchBar becomeFirstResponder];
                         }];
        
    }];*/
    
   
    [ClsSetting Searchpage:self.navigationController];
}
-(void)myastaguru
{
    
    [ClsSetting myAstaGuru:self.navigationController];
    
}

-(void)Getanner
    {
        //-------
        
        
        // 41.945572&Lng=-87.658838
        
        
        @try {
            
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"loading";
            NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
           // [Discparam setValue:@"cr2016" forKey:@"validate"];
            //[Discparam setValue:@"banner" forKey:@"action"];
            
            
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            NSString  *strQuery=[NSString stringWithFormat:@"http://54.169.222.181/api/v2/guru/_table/home_banner?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"];
            NSString *url = strQuery;
            NSLog(@"%@",url);
            
            
            
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 //  NSError *error=nil;
                 NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 
                 NSError *error;
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 NSLog(@"%@",responseStr);
                 NSLog(@"%@",dict);
                 
                 
               NSMutableArray*arrElement=[dict valueForKey:@"resource"];
                 for (int i=0; i< arrElement.count; i++)
                 {
                     NSDictionary *dictElement=[arrElement objectAtIndex:i];
                     if ([[dictElement valueForKey:@"bannerType"] intValue]==1)
                     {
                         [arrmBanner addObject:dictElement];
                     }
                     else if ([[dictElement valueForKey:@"bannerType"] intValue]==2)
                     {
                         [arrmBanner2 addObject:dictElement];
                     }
                     else if ([[dictElement valueForKey:@"bannerType"] intValue]==3)
                     {
                         [arrmBanner3 addObject:dictElement];
                     }
                     else if ([[dictElement valueForKey:@"bannerType"] intValue]==4)
                     {
                         [arrmBanner4 addObject:dictElement];
                     }
                     else if ([[dictElement valueForKey:@"bannerType"] intValue]==5)
                     {
                         [arrmBanner5 addObject:dictElement];
                     }
                 }
                 [_vwCarousel reloadData];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [self.pgControl setNumberOfPages:[arrmBanner count]];
                 [self.pgVideo setNumberOfPages:[arrmBanner5 count]];
                 
                 NSMutableDictionary *dictVideo=[arrmBanner5 objectAtIndex:0];
                 NSString *url = [dictVideo valueForKey:@"homebannerImg"];
                // NSURL *nsUrl = [NSURL URLWithString:url];
                 
                 [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
                 _webview.scrollView.bounces = NO;
                 [_webview setMediaPlaybackRequiresUserAction:NO];
                 
                 
                 
                 [_vwCarousel reloadData];
                 [_clvUpcommingAuction reloadData];
                 [_clvFeaturedAuction reloadData];
                 [_clsFullImage reloadData];
                 [_clvVideo reloadData];
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([operation.response statusCode]==404)
                     {
                         [ClsSetting ValidationPromt:@"No Record Found"];
                         
                     }
                     else
                     {
                         [ClsSetting internetConnectionPromt];
                         
                     }
                 }];
            
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [arrmBanner count];
}

// this delegate method returns banner views.
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIView *bannerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.vwCarousel.frame.size.width,self.vwCarousel.frame.size.height)];
    
    EGOImageView *imgvw=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"banner"]];
    
    [imgvw setFrame:bannerview.frame];
    
    //[imgvw setContentMode:UIViewContentModeScaleAspectFit];
    UIButton *btn=[[UIButton alloc]initWithFrame:bannerview.frame];
    
    //[btn addTarget:self action:@selector(OpenBannerdUrl:) forControlEvents:UIControlEventTouchUpInside];
    
    //[btn setTag:index];
    
    //imgvw.contentMode=UIViewContentModeScaleToFill;
    
    NSDictionary *dict=[arrmBanner objectAtIndex:index];
    
    imgvw.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];
    
    //imgvw.delegate=self;
    
    [bannerview setBackgroundColor:[UIColor clearColor]];
    
    [bannerview addSubview:imgvw];
    
    [bannerview addSubview:btn];
    
    return  bannerview;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self.pgControl setCurrentPage:[carousel currentItemIndex]];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_clvUpcommingAuction)
    {
     return arrmBanner2.count;
    }
    else if(collectionView==_clvFeaturedAuction)
    {
     return arrmBanner3.count;
    }
    else if (collectionView==_clsFullImage)
    {
    return arrmBanner4.count;
    }
    else if (collectionView==_clvVideo)
    {
        return arrmBanner5.count;
    }
    else
    {
    return arrBottomMenu.count;
    }
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *identifier = @"Cell";
    NSDictionary *dict;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (collectionView==_clvUpcommingAuction)
    {
        
    dict=[arrmBanner2 objectAtIndex:indexPath.row];
         [self.pgControlUpcommingAuction setCurrentPage:indexPath.row];
    }
    else if(collectionView==_clvFeaturedAuction)
    {
    dict=[arrmBanner3 objectAtIndex:indexPath.row];
    }
    else if (collectionView==_clsFullImage)
    {
    dict=[arrmBanner4 objectAtIndex:indexPath.row];
    }
    else if (collectionView==_clvVideo)
    {
    dict=[arrmBanner5 objectAtIndex:indexPath.row];
    // [self.pgVideo setCurrentPage:indexPath.row];
    }
    
    if (collectionView== _clvBottomMenu)
    {
        UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
        UILabel *lblSelectedline = (UILabel *)[cell viewWithTag:22];
        NSLog(@"%@",[arrBottomMenu objectAtIndex:indexPath.row]);
        lblTitle.text=[arrBottomMenu objectAtIndex:indexPath.row];
        if (indexPath.row==0)
        {
          UILabel *lblline = (UILabel *)[cell viewWithTag:21];
            lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
           
            lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
            lblSelectedline.hidden=NO;
            
        }
        else
        {
        //UILabel *lblline = (UILabel *)[cell viewWithTag:21];
            lblSelectedline.hidden=YES;
        }
        //[NSString stringWithFormat:@"%@",[arrBottomMenu objectAtIndex:indexPath.row]];
    }
    else
    {
    EGOImageView *imgServices = (EGOImageView *)[cell viewWithTag:11];
   imgServices.imageURL=[NSURL URLWithString:[dict valueForKey:@"homebannerImg"]];
        _imgVideo.hidden=YES;
        
        YTPlayerView *YTPlayer = (YTPlayerView *)[cell viewWithTag:101];
        YTPlayer.delegate=self;
        NSString *strVideoId=[self extractYoutubeIdFromLink:[dict valueForKey:@"homebannerImg"]];
        NSDictionary *playerVars = @{
                                     @"controls" : @0,
                                     @"playsinline" : @0,
                                     @"autohide" : @1,
                                     @"showinfo" : @0,
                                     @"modestbranding" : @0,
                                     @"autoplay" : @0,
                                     @"origin":@"http://www.youtube.com"
                                     };
        
        // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
        [YTPlayer loadWithVideoId:strVideoId playerVars:playerVars];
        [YTPlayer playVideo];
        
       

        
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:12];
    lblTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"homebannerTitle"]];
    //lblPrice.text=[]
    UIWebView *Web = (UIWebView *)[cell viewWithTag:13];
    NSString *url = [dict valueForKey:@"homebannerImg"];
    //NSURL *nsUrl = [NSURL URLWithString:url];
    Web.scalesPageToFit=true;
    [Web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    Web.scrollView.bounces = NO;
    [Web setMediaPlaybackRequiresUserAction:NO];
       
    }
    
    
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 2
    if (collectionView1==_clvUpcommingAuction)
    {
    float width=(self.view.frame.size.width);
    NSLog(@"%f",width);
    
    return CGSizeMake(width, collectionView1.frame.size.height);
    
    }
    else if(collectionView1==_clvFeaturedAuction)
    {
        float width=(self.view.frame.size.width/2)-7;
        NSLog(@"%f",width);
        
        return CGSizeMake(width, width);
    }
    else if(collectionView1==_clsFullImage)
    {
        float width=(self.view.frame.size.width);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, collectionView1.frame.size.height);
        
    }
    else if(collectionView1==_clvBottomMenu)
    {
        float width=(self.view.frame.size.width/4);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, collectionView1.frame.size.height);
        
    }
    else
    {
        float width=(self.view.frame.size.width);
        NSLog(@"%f",width);
        
        return CGSizeMake(width, width/2.15);
        
    }
    
    
    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(collectionView==_clvBottomMenu)
    {
    if (indexPath.row==1)
    {
       /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CurrentOccutionViewController *objDetailVideoViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
        [self.navigationController pushViewController:objDetailVideoViewController animated:YES];*/
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
        {
        
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        CurrentOccutionViewController *VCLikesControll = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
        [navcontroll pushViewController:VCLikesControll animated:YES];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
            BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
            [self.navigationController pushViewController:rootViewController animated:YES];
        }
            
        
    }
   else if (indexPath.row==2)
    {
        /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         CurrentOccutionViewController *objDetailVideoViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
         [self.navigationController pushViewController:objDetailVideoViewController animated:YES];*/
        
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
        objPastOccuctionViewController.iIsUpcomming=1;
        [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
        
    }
   else if (indexPath.row==3)
    {
        /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         CurrentOccutionViewController *objDetailVideoViewController = [storyboard instantiateViewControllerWithIdentifier:@"CurrentOccutionViewController"];
         [self.navigationController pushViewController:objDetailVideoViewController animated:YES];*/
        
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
        objPastOccuctionViewController.iIsUpcomming=2;
        [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
        
    }
    }
    else if(collectionView==_clvUpcommingAuction)
    {
        UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
        PastOccuctionViewController *objPastOccuctionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PastOccuctionViewController"];
        objPastOccuctionViewController.iIsUpcomming=1;
        [navcontroll pushViewController:objPastOccuctionViewController animated:YES];
    }
    else if (collectionView==_clvVideo)
    {
        _imgVideo.hidden=YES;
        NSMutableDictionary  * dict=[arrmBanner5 objectAtIndex:indexPath.row];
        NSString *strVideoId=[self extractYoutubeIdFromLink:[dict valueForKey:@"homebannerImg"]];
        NSDictionary *playerVars = @{
                                     @"controls" : @0,
                                     @"playsinline" : @1,
                                     @"autohide" : @1,
                                     @"showinfo" : @0,
                                     @"modestbranding" : @1,
                                     @"autoplay" : @1,
                                     @"origin":@"http://www.youtube.com"
                                     };
        
       // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
        [_viwplayer loadWithVideoId:strVideoId playerVars:playerVars];
        [_viwplayer playVideo];

        _viwplayer.delegate=self;
        // _Toutubevuew.autoplay = YES;
        //[_Toutubevuew loadVideoByURL:_objLib.strlib_video_thumb startSeconds:0.0 suggestedQuality:2];
        
        /* LBYouTubePlayerViewController* controller = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:@"https://www.youtube.com/watch?v=9oPoXE5IASA"] quality:LBYouTubeVideoQualityLarge];
         controller.delegate = self;
         controller.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
         controller.view.center = self.view.center;
         [self.view addSubview:controller.view];
         */
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
- (void)tapGesture: (UITapGestureRecognizer*)tapGesture
{
    
    _imgVideo.hidden=YES;
    NSMutableDictionary  * dict;
    if (arrmBanner5.count>0)
    {
     dict=[arrmBanner5 objectAtIndex:0];
    }
  
    NSString *strVideoId=[self extractYoutubeIdFromLink:[dict valueForKey:@"homebannerImg"]];
    NSDictionary *playerVars = @{
                                 @"controls" : @0,
                                 @"playsinline" : @0,
                                 @"autohide" : @1,
                                 @"showinfo" : @0,
                                 @"modestbranding" : @0,
                                 @"autoplay" : @0,
                                 @"origin":@"http://www.youtube.com"
                                 };
    
    // NSLog(@"strlib_video_thumb %@",_objLib.strlib_video_thumb);
    [_viwplayer loadWithVideoId:strVideoId playerVars:playerVars];
    [_viwplayer playVideo];
    
    _viwplayer.delegate=self;
    
}
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
        {
           _imgVideo.hidden=YES;
        }
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        default:
            break;
    }
}

#pragma mark UISearchBarDelegate methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.5f animations:^{
        _searchBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = nil;
        //self.navigationItem.rightBarButtonItem = _searchBar;
        btnBack.alpha = 0.0;  // set this *after* adding it back
        [UIView animateWithDuration:0.5f animations:^ {
            btnBack.alpha = 1.0;
        }];
    }];
    
}// ca
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_clvVideo)
    {
     float currentPage = _clvVideo.contentOffset.x / _clvVideo.frame.size.width;
            _pgVideo.currentPage = currentPage;
        NSLog(@"Page Number : %ld", (long)_pgVideo.currentPage);
    }
}
@end
