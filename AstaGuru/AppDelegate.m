//
//  AppDelegate.m
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AppDelegate.h"
#import "CWStatusBarNotification.h"
#import "ATAppUpdater.h"
#import "GlobalClass.h"
@interface AppDelegate ()

//@property (strong, nonatomic) CWStatusBarNotification *notification;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [GlobalClass isLive:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSDictionary *userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];

    if(apsInfo)
    {
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isNoti"];

        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
        {
            NSString *countrySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
            if ([countrySymbol isEqualToString:@"IN"])
            {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
            }
        }
        else
        {
            NSString *countrySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
            if ([countrySymbol isEqualToString:@"IN"])
            {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUSD"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUSD"];
            }
        }
        [self registerForRemoteNotification];
    }
    
    ATAppUpdater *updater = [ATAppUpdater sharedUpdater];
    [updater setAlertTitle:@"AstaGuru"];
    [updater setAlertMessage:@"Please update the latest version of the application for smooth functioning."];
    [updater setAlertUpdateButtonTitle:@"Update"];
    [updater setAlertCancelButtonTitle:@"Not Now"];
//    [updater setDelegate:self]; // Optional
    [updater showUpdateWithConfirmation];
//    [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];

    return YES;
}

- (void)registerForRemoteNotification
{
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0"))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else {
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    // Prepare the Device Token for Registration (remove spaces and < >)
    NSString *deviceToken_Str = [[[[deviceToken description]
                                   stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString: @" " withString: @""];
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken_Str forKey:DEVICETOKEN];
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    if (error.code == 3010) {
    } else {}
}

#ifdef IS_OS_8_OR_LATER
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /**
     * Dump your code here according to your requirement after receiving push
     */
    
    NSLog(@"User Info : %@",userInfo);

    NSLog(@"applicationState = %ld",(long)application.applicationState);
    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge+[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] integerValue]];
    
    if (application.applicationState == UIApplicationStateActive )
    {
//        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
//        self.notification = [CWStatusBarNotification new];
//        self.notification.notificationAnimationInStyle = 0;
//        self.notification.notificationAnimationOutStyle = 0;
//        self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        // set default blue color (since iOS 7.1, default window tintColor is black)
//        self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//        [self.notification displayNotificationWithMessage:message forDuration:3.5];
//        
//        __weak typeof(self) weakSelf = self;
//        self.notification.notificationTappedBlock = ^(void)
//        {
//            NSLog(@"notification tapped");
//            
//            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
//            [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
//            [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
//            weakSelf.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//        };
    }
    else //if (application.applicationState == UIApplicationStateInactive)
    {
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        
        // initialize CWNotification
//        self.notification = [CWStatusBarNotification new];
//        self.notification.notificationAnimationInStyle = 0;
//        self.notification.notificationAnimationOutStyle = 0;
//        self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        // set default blue color (since iOS 7.1, default window tintColor is black)
//        self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//        [self.notification displayNotificationWithMessage:message forDuration:3.0];
//        __weak typeof(self) weakSelf = self;
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        
    }

}


//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog(@"applicationState = %ld",(long)[UIApplication sharedApplication].applicationState);

    NSLog(@"User Info : %@",notification.request.content.userInfo);
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge+[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] integerValue]];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive )
    {
//        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
//        self.notification = [CWStatusBarNotification new];
//        self.notification.notificationAnimationInStyle = 0;
//        self.notification.notificationAnimationOutStyle = 0;
//        self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        // set default blue color (since iOS 7.1, default window tintColor is black)
//        self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//        [self.notification displayNotificationWithMessage:message forDuration:3.5];
//        
//        __weak typeof(self) weakSelf = self;
//        self.notification.notificationTappedBlock = ^(void)
//        {
//            NSLog(@"notification tapped");
//            
//            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
//            [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
//            [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
//
//            weakSelf.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//        };
    }
    else //if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        // initialize CWNotification
//        self.notification = [CWStatusBarNotification new];
//        self.notification.notificationAnimationInStyle = 0;
//        self.notification.notificationAnimationOutStyle = 0;
//        self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        // set default blue color (since iOS 7.1, default window tintColor is black)
//        self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//        [self.notification displayNotificationWithMessage:message forDuration:3.0];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
    }

    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    NSLog(@"applicationState = %ld",(long)[UIApplication sharedApplication].applicationState);

    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);

    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge+[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] integerValue]];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive )
    {
//        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
//        self.notification = [CWStatusBarNotification new];
//        self.notification.notificationAnimationInStyle = 0;
//        self.notification.notificationAnimationOutStyle = 0;
//        self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        // set default blue color (since iOS 7.1, default window tintColor is black)
//        self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//        [self.notification displayNotificationWithMessage:message forDuration:3.5];
//        
//        __weak typeof(self) weakSelf = self;
//        self.notification.notificationTappedBlock = ^(void)
//        {
//            NSLog(@"notification tapped");
//            
//            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
//            [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
//            [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
//
//            weakSelf.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//        };
    }
    else //if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
//        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
//        // initialize CWNotification
//        self.notification = [CWStatusBarNotification new];
//        self.notification.notificationAnimationInStyle = 0;
//        self.notification.notificationAnimationOutStyle = 0;
//        self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        // set default blue color (since iOS 7.1, default window tintColor is black)
//        self.notification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//        [self.notification displayNotificationWithMessage:message forDuration:3.0];
//        
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
//        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
//        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
    }
    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
