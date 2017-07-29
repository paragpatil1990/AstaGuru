//
//  NavigationViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/23/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController

//-(void)setNavigationBarTitleTextAttribut:(UINavigationController*)navigationViewController;

-(void)setNavigationBarCloseButton:(UINavigationController*)navigationViewController target:(id)target selector:(SEL)selector;

-(void)setNavigationBarSlideButton:(UINavigationController*)navigationViewController target:(id)target selector:(SEL)selector;

-(void)setNavigationRightBarButtons:(UINavigationController*)navigationViewController;

@end
