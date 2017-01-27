//
//  ArtistViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 18/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clsCurrentOccution.h"
@interface ArtistViewController : UIViewController
@property(nonatomic,retain)clsCurrentOccution *objCurrentOccution;
@property (weak, nonatomic) IBOutlet UICollectionView *clvArtistInfo;
@property (nonatomic)int iscurrencyInDollar;
- (IBAction)btnPastPressed:(id)sender;
@property(nonatomic)int issort;
@property(nonatomic)int IsUpcomming;
@property(nonatomic)int IsPast;

@end
