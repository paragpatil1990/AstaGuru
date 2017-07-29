//
//  ArtistViewController.h
//  AstaGuru
//
//  Created by sumit mashalkar on 18/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ArtistViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UICollectionView *clvArtistInfo;

@property(nonatomic,retain) CurrentAuction *currentAuction;
@property AFHTTPRequestOperation *task;

-(void)didChangedAuctionType;
-(void)didReadMoreChanged;
@end
