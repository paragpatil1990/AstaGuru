//
//  clsMyAuctionGallery.h
//  AstaGuru
//
//  Created by Aarya Tech on 27/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "clsCurrentOccution.h"
@interface clsMyAuctionGallery : NSObject
@property(nonatomic,retain)NSString *strAuctionId;
@property(nonatomic,retain)NSString *strBidpricers;
@property(nonatomic,retain)NSString *strBidpriceus;
@property(nonatomic,retain)NSString *strBidrecordid;
@property(nonatomic,retain)NSString *strFirstname;
@property(nonatomic,retain)NSString *strLastname;
@property(nonatomic,retain)NSString *strReference;

@property(nonatomic,retain)NSString *strThumbnail;
@property(nonatomic,retain)NSString *strUserId;
@property(nonatomic,retain)NSString *strUsername;
@property(nonatomic,retain)NSString *stranoname;
@property(nonatomic,retain)NSString *strcurrentbid;
@property(nonatomic,retain)NSString *strdaterec;
@property(nonatomic,retain)NSString *strearlyproxy;

@property(nonatomic,retain)NSString *strproductid;
@property(nonatomic,retain)NSString *strproxy;
@property(nonatomic,retain)NSString *strrecentbid;
@property(nonatomic,retain)NSString *strvalidbidpricers;
@property(nonatomic,retain)NSString *strvalidbidpriceus;
@property(nonatomic,retain)NSString *strTypeOfCell;
@property(nonatomic,retain)NSString *strFromBid;
@property(nonatomic,retain)clsCurrentOccution *objCurrentAuction;
@end
