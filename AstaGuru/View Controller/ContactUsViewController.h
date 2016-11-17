//
//  ContactUsViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ContactUsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedMenu;
@property (weak, nonatomic) IBOutlet UISegmentedControl *valueChanged;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (weak, nonatomic) IBOutlet MKMapView *viwmap;
@property (weak, nonatomic) IBOutlet UIView *viwcontentview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
