//
//  ContactUsViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "GetInTouchViewController.h"
#import "WebViewViewController.h"
#define METERS_PER_MILE 230000.0

@interface ContactUsViewController ()<TTTAttributedLabelDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrContact;


@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect frame= _segmentedMenu.frame;
        [_segmentedMenu setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 50)];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,nil];
        
        
        [_segmentedMenu setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        
        
    }
    else
    {
        
        
        CGRect frame= _segmentedMenu.frame;
        [_segmentedMenu setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30)];
    }
    
    _segmentedMenu.layer.borderWidth = 1.0;
    _segmentedMenu.layer.cornerRadius=3.0;
    _segmentedMenu.layer.borderColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0].CGColor;
    
    
    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=18.927601;
    myCoordinate.longitude=72.832765;
    annotation.coordinate = myCoordinate;
    [self.viwmap addAnnotation:annotation];
    
    double miles = 0.5;
    double scalingFactor = ABS( (cos(2 * M_PI * annotation.coordinate.latitude / 360.0) ));
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    MKCoordinateRegion region;
    region.span = span;
    region.center = annotation.coordinate;
    [self.viwmap setRegion:region animated:YES];

    
    // Do any additional setup after loading the view.
    
    
    self.contact_Lbl.extendsLinkTouchArea = YES;
    self.contact_Lbl.userInteractionEnabled = YES;
    self.contact_Lbl.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
    self.contact_Lbl.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    self.contact_Lbl.numberOfLines = 0;
    self.contact_Lbl.text = @"+912222048138 / 39, +912222048140";
    self.contactEmail_Lbl.extendsLinkTouchArea = YES;
    self.contactEmail_Lbl.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes; // Automatically detect links when the label text is subsequently changed
    self.contactEmail_Lbl.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    self.contactEmail_Lbl.numberOfLines = 0;
    self.contactEmail_Lbl.text = @"contact@astaguru.com";
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    //        // Whilst this version will return you to your app once the phone call is over.
    NSURL *phoneNumber_Url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    
    // Now that we have our `phoneNumber` as a URL. We need to check that the device we are using can open the URL.
    // Whilst iPads, iPhone, iPod touchs can all open URLs in safari mobile they can't all
    // open URLs that are numbers this is why we have `tel://` or `telprompt://`
    if([[UIApplication sharedApplication] canOpenURL:phoneNumber_Url]) {
        // So if we can open it we can now actually open it with
        [[UIApplication sharedApplication] openURL:phoneNumber_Url];
    }
    
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];

//    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
}

-(void)closePressed
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    _segmentedMenu.selectedSegmentIndex=0;
    for (int i=0; i<[_segmentedMenu.subviews count]; i++)
    {
        UIColor *tintcolor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0];
        if ([[_segmentedMenu.subviews objectAtIndex:i]isSelected])
        {
            
            [[_segmentedMenu.subviews objectAtIndex:i] setTintColor:tintcolor];
            
        }
        else
        {
            [[_segmentedMenu.subviews objectAtIndex:i] setTintColor:[UIColor whiteColor]];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        tintcolor,NSForegroundColorAttributeName,nil];
            [_segmentedMenu setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
    }
    
    self.navigationItem.title=@"Contact Us";
     //_scrContact.contentSize=CGSizeMake(self.view.frame.size.width, _viwmap.frame.size.height+ _viwmap.frame.origin.y+30);
    //_viwcontentview.frame=CGRectMake(_viwcontentview.frame.origin.x, _viwcontentview.frame.origin.y, self.view.frame.size.width, _scrContact.contentSize.height);
}
- (IBAction)segmentClicked:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        
    }
    else if (sender.selectedSegmentIndex==1)
    {
        GetInTouchViewController *objGetInTouchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GetInTouchViewController"];
        [self.navigationController pushViewController:objGetInTouchViewController animated:YES];
    }

}

- (IBAction)segmentedclicked:(id)sender
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnFBPressed:(id)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:@"https://www.facebook.com/Astaguru-Auction-House-375561749218131/"];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btnTwitter:(id)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:@"https://twitter.com/astagurutweets"];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btninsta:(id)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:@"https://www.instagram.com/astaguru/"];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btnPitrest:(id)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:@"https://in.pinterest.com/astaguru/"];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btnVideo:(id)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:@"https://www.youtube.com/channel/UCmTqSUMAHV5l0mACoK72t7g"];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btngoogleplus:(id)sender
{
    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
    
    objWebViewViewController.url=[NSURL URLWithString:@"https://www.facebook.com/Astaguru-Auction-House-375561749218131/"];
    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}

@end
