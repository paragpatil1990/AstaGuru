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
@property (weak, nonatomic) IBOutlet UICollectionView *clvArtistInfo;

@property(nonatomic,retain)clsCurrentOccution *objCurrentOccution1;
//@property (nonatomic)int iscurrencyInDollar;

@end
