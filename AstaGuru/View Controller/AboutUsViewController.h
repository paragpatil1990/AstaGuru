//
//  AboutUsViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *txtAboutUs;
@property (weak, nonatomic) IBOutlet UIView *viwinner;
@property (weak, nonatomic) IBOutlet UIScrollView *scrContent;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
