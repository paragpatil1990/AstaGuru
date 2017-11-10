//
//  NotificationViewController.m
//  Tokative
//
//  Created by Amrit Singh on 12/13/16.
//  Copyright © 2016 FoxSolution. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationTableViewCell.h"
#import "NSString+TimeCalculation.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ClsSetting.h"
#import "BforeLoginViewController.h"
#import "SWRevealViewController.h"
#import "NotificationDetailViewController.h"
#import "AppDelegate.h"
@interface NotificationViewController ()

@property(nonatomic, retain) NSArray *notiList_Array;

@end

@implementation NotificationViewController
@synthesize notification_TableView, notiList_Array, noti_Dic, msg_Lbl;
- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:-1];

    
    //left button
    [self setUpNavigationItem];
    notiList_Array = [[NSArray alloc]init];
    
    msg_Lbl.hidden = YES;
    notification_TableView.estimatedRowHeight = 100.0;
    notification_TableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getNotification];
}

-(void)setUpNavigationItem
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // [btnBack addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    self.navigationItem.title=@"Notifications";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
}

-(void)closePressed
{
//    AppDelegate *objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    objApp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];

    /*UINavigationController *navcontroll = (UINavigationController *)[self.revealViewController frontViewController];
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     ViewController *objProductViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
     [navcontroll pushViewController:objProductViewController animated:YES];*/
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getNotification
{
    
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
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0)
        {
            NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetNotification(%@)?api_key=%@",[ClsSetting procedureURL],[[NSUserDefaults standardUserDefaults] valueForKey:USER_id],[ClsSetting apiKey]];
            
            NSString *url = strQuery;
            NSLog(@"%@",url);
            NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 //  NSError *error=nil;
                 //             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 
                 NSError *error;
                 NSArray *notiArray = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 NSLog(@"%@",notiArray);
                 
                 notiList_Array = notiArray;
                 
                 if (notiList_Array.count == 0)
                 {
                     msg_Lbl.hidden = NO;
                     notification_TableView.hidden = YES;
                 }
                 else
                 {
                     msg_Lbl.hidden = YES;
                     notification_TableView.hidden = NO;
                 }
                 [notification_TableView reloadData];
                 [HUD hide:YES];
                 
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                     [ClsSetting ValidationPromt:error.localizedDescription];
                     //                 if ([operation.response statusCode]==404)
                     //                 {
                     //                     [ClsSetting ValidationPromt:@"No Record Found"];
                     //
                     //                 }
                     //                 else
                     //                 {
                     //                     [ClsSetting internetConnectionPromt];
                     //
                     //                 }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete implementation, return the number of rows
    return notiList_Array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mCell"forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[NotificationTableViewCell class]])
    {
        NotificationTableViewCell *mCell = (NotificationTableViewCell *)cell;
        NSDictionary *record = notiList_Array[indexPath.row];
        mCell.notiMsg_Lbl.text = record[@"NotificationBody"];
        mCell.notiMsg_Lbl.numberOfLines = 0;
        NSString *pDate = [NSString stringWithFormat:@"%@",record[@"CreatedDate"]];
        mCell.mTime_Lbl.text = [NSString stringWithFormat:@"%@, %@",[NSString StringFromDate:pDate],[NSString calculatePostTimeForIndexPath:pDate]];
        UIView *dotView = [cell viewWithTag:11];
        dotView.layer.cornerRadius = 8.0;
//        if ([record[@"IsRead"] intValue] == 0)
//        {
            dotView.backgroundColor = [UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
//        }
//        else{
//            dotView.backgroundColor = [UIColor grayColor];
//        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    noti_Dic = notiList_Array[indexPath.row];
//    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    NotificationDetailViewController *rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"NotificationDetailViewController"];
//    rootViewController.record = noti_Dic;
//    [self.navigationController pushViewController:rootViewController animated:YES];
}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    v.backgroundColor=[UIColor clearColor];
    return v;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"retok"])
//    {
//        RetokCommentViewController *rVC = [segue destinationViewController];
//        rVC.feed_Dic = feed_Dic;
//    }
//    else if ([segue.identifier isEqualToString:@"profile"])
//    {
//        ProfileViewController *pVC = [segue destinationViewController];
//        pVC.siteUserID = sendSiteUserId;
//    }
}


@end
