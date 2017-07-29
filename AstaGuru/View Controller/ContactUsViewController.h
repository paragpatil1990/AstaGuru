//
//  ContactUsViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TTTAttributedLabel.h"
#import "BaseViewController.h"

@interface ContactUsViewController : BaseViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *contact_Lbl;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *contactEmail_Lbl;

@end
