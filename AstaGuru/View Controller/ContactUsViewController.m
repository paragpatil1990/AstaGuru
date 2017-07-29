//
//  ContactUsViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ContactUsViewController.h"
//#import "SWRevealViewController.h"
//#import "AppDelegate.h"
//#import "GetInTouchViewController.h"
#import "WebViewViewController.h"
#define METERS_PER_MILE 230000.0

@interface ContactUsViewController ()<TTTAttributedLabelDelegate, UIActionSheetDelegate>



@end

@implementation ContactUsViewController

-(void)setUpNavigationItem
{
    self.title=@"Contact Us";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //[self setUpNavigationItem];

//    _segmentedMenu.layer.borderColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0].CGColor;
    
    
    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude = 18.927601;
    myCoordinate.longitude = 72.832765;
    annotation.coordinate = myCoordinate;
    [self.mapView addAnnotation:annotation];
    
    double miles = 0.5;
    double scalingFactor = ABS( (cos(2 * M_PI * annotation.coordinate.latitude / 360.0) ));
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    MKCoordinateRegion region;
    region.span = span;
    region.center = annotation.coordinate;
    [self.mapView setRegion:region animated:YES];

    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/Astaguru-Auction-House-375561749218131/"]];
//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    
//    objWebViewViewController.url=[NSURL URLWithString:@"https://www.facebook.com/Astaguru-Auction-House-375561749218131/"];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btnTwitter:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/astagurutweets"]];

//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    
//    objWebViewViewController.url=[NSURL URLWithString:@"https://twitter.com/astagurutweets"];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btninsta:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/astaguru/"]];

//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    
//    objWebViewViewController.url=[NSURL URLWithString:@"https://www.instagram.com/astaguru/"];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btnPitrest:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://in.pinterest.com/astaguru/"]];

//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    
//    objWebViewViewController.url=[NSURL URLWithString:@"https://in.pinterest.com/astaguru/"];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btnVideo:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UCmTqSUMAHV5l0mACoK72t7g"]];
    
//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    
//    objWebViewViewController.url=[NSURL URLWithString:@"https://www.youtube.com/channel/UCmTqSUMAHV5l0mACoK72t7g"];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}
- (IBAction)btngoogleplus:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/Astaguru-Auction-House-375561749218131/"]];

//    WebViewViewController *objWebViewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewViewController"];
//    
//    objWebViewViewController.url=[NSURL URLWithString:@"https://www.facebook.com/Astaguru-Auction-House-375561749218131/"];
//    [self.navigationController pushViewController:objWebViewViewController animated:YES];
}

@end
