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
#import "NotificationDetailViewController.h"
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
    
    notiList_Array = [[NSArray alloc] init];
    
    msg_Lbl.hidden = YES;
    notification_TableView.estimatedRowHeight = 100.0;
    notification_TableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if ([GlobalClass isUserLogin])
    {
        [self spGetNotification];
    }
    else
    {
        [self gotoLoginVC];
    }
}

-(void)setUpNavigationItem
{
    self.title=@"Notifications";
    [self setNavigationBarBackButton];
}

-(void)spGetNotification
{
    NSString  *strUrl=[NSString stringWithFormat:@"spGetNotification(%@)", [GlobalClass getUserID]];
    
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         notiList_Array = (NSArray*)responseObject;
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

     } failure:^(NSError *error)
     {[GlobalClass showTost:error.localizedDescription];} callingCount:0];
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
