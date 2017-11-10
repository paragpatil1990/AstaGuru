//
//  AppDelegate.h
//  AstaGuru
//
//  Created by Aarya Tech on 29/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;


// This property is defiend to refreash data for selected sort index in current auction.
@property (nonatomic)int iSelectedSortInCurrentAuction;

- (void)registerForRemoteNotification;


@end

