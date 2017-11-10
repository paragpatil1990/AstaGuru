//
//  NotificationDetailViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 4/17/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "NotificationDetailViewController.h"
#import "SWRevealViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ClsSetting.h"
#import "BforeLoginViewController.h"
#import "AppDelegate.h"

@interface NotificationDetailViewController ()

@end

@implementation NotificationDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.message_Lbl.text = self.record[@"NotificationBody"];
    [self setUpNavigationItem];
    [self getNotificationDetail];
    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge-1];
    
}

-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    self.navigationItem.title=@"Notification";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}

-(void)closePressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate *objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;

    /*UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     ViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
     [navcontroll pushViewController:objProductViewController animated:YES];*/
//    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)getNotificationDetail
{
    @try {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
        {
            NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetNotificationDetail(%@)?api_key=%@",[ClsSetting procedureURL],self.record[@"NotificationID"],[ClsSetting apiKey]];
            
            NSString *url = strQuery;
            NSLog(@"%@",url);
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
            
                 NSError *error;
                 NSArray *notiArray = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 _record = notiArray[0];
                 self.message_Lbl.text = self.record[@"NotificationBody"];
                 NSLog(@"%@",notiArray);
                 
                 [HUD hide:YES];
                 
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                     [ClsSetting ValidationPromt:error.localizedDescription];
                     [HUD hide:YES];
                     
                 }];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
            BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
            [self.navigationController pushViewController:rootViewController animated:YES];
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}

- (void)didReceiveMemoryWarning
{
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

@end
