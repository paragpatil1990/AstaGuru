//
//  MyAuctionGalleryViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 27/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAuctionGalleryViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideleftbarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *clvMyAuctionGallery;

@end
