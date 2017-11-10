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
#import "Harpy.h"
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()<HarpyDelegate>

//@property (strong, nonatomic) CWStatusBarNotification *notification;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
 
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

        NSString *countrySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];

        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
        {
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
    [[Harpy sharedInstance] setPresentingViewController:_window.rootViewController];
//    [[Harpy sharedInstance] setDelegate:self];
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
    [[Harpy sharedInstance] setDebugEnabled:true];
    [[Harpy sharedInstance] checkVersion];
    
//    [self needsUpdate];
    
//    ATAppUpdater *updater = [ATAppUpdater sharedUpdater];
//    [updater setAlertTitle:@"AstaGuru"];
//    [updater setAlertMessage:@"Please update the latest version of the application for smooth functioning."];
//    [updater setAlertUpdateButtonTitle:@"Update"];
//    [updater setAlertCancelButtonTitle:@"Not Now"];
////    [updater setDelegate:self]; // Optional
//    [updater showUpdateWithConfirmation];
//    [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];

    return YES;
}


-(BOOL) needsUpdate
{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if ([lookup[@"resultCount"] integerValue] == 1){
        NSString* appStoreVersion = lookup[@"results"][0][@"version"];
        NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
        if (![appStoreVersion isEqualToString:currentVersion])
        {
            NSLog(@"Need to update [%@ != %@]", appStoreVersion, currentVersion);
            NSString *msgstr = [NSString stringWithFormat:@"Please update the latest version of application for smooth functioning"];
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"AstaGuru"  message:msgstr  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            NSString *appName = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
                                            NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.com/app/%@",[appName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
                                            [[UIApplication sharedApplication] openURL:appStoreURL];
//                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        }]];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Not Now" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:cancelAction];
            
            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
            return YES;
        }
    }
    return NO;
}


- (void)registerForRemoteNotification
{
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0"))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
        {
            if(!error)
            {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else
    {
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceToken_Str forKey:@"deviceToken"];
    [defaults synchronize];
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    if (error.code == 3010)
    {
    }
    else
    {
    }
}

#ifdef IS_OS_8_OR_LATER
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    NSLog(@"applicationState = %ld",(long)[UIApplication sharedApplication].applicationState);

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
    
//    NSLog(@"User Info : %@",userInfo);
    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge+[[[userInfo valueForKey:@"aps"] valueForKey:@"badge"] integerValue]];
    
    if (application.applicationState == UIApplicationStateActive )
    {
        NSLog(@"didReceiveRemoteNotification applicationState = Active");
    }
    else if (application.applicationState == UIApplicationStateBackground)
    {
        NSLog(@"didReceiveRemoteNotification applicationState = Background");

        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        
    }
    else
    {
        NSLog(@"didReceiveRemoteNotification applicationState = Inactive");
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];

        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }

}


//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
//    NSLog(@"User Info : %@",notification.request.content.userInfo);
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge+[[[userInfo valueForKey:@"aps"] valueForKey:@"badge"] integerValue]];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive )
    {
        NSLog(@"willPresentNotification applicationState = Active");
    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        NSLog(@"willPresentNotification applicationState = Background");
    }
    else
    {
        NSLog(@"willPresentNotification applicationState = Inactive");
    }

    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
//    NSLog(@"User Info : %@",response.notification.request.content.userInfo);

    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge+[[[userInfo valueForKey:@"aps"] valueForKey:@"badge"] integerValue]];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive )
    {
        NSLog(@"didReceiveNotificationResponse applicationState = Active");
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];

    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        NSLog(@"didReceiveNotificationResponse applicationState = Background");
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];

        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    else
    {
        NSLog(@"didReceiveNotificationResponse applicationState = Inactive");
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];

        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isNoti"];
        [[NSUserDefaults standardUserDefaults] setValue:message forKey:@"NotificationBody"];
        [[NSUserDefaults standardUserDefaults] setValue:[userInfo valueForKey:@"NotificationID"] forKey:@"NotificationID"];
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
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
