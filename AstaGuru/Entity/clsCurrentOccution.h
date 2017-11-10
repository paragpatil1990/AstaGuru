//
//  clsCurrentOccution.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "clsArtistInfo.h"
#import "clsMedia.h"
#import "clsCategory.h"
@interface clsCurrentOccution : NSObject
@property(nonatomic,retain)NSString *strmyuserid;
@property(nonatomic,retain)NSString *strproductid;
@property(nonatomic,retain)NSString *strtitle;
@property(nonatomic,retain)NSString *strdescription;
@property(nonatomic,retain)NSString *strartist_id;
@property(nonatomic,retain)NSString *strartist_name;
@property(nonatomic,retain)NSString *strpricers;
@property(nonatomic,retain)NSString *strpriceus;
@property(nonatomic,retain)NSString *strstyle_id;
@property(nonatomic,retain)NSString *strcategory_id;
@property(nonatomic,retain)NSString *strmedium_id;
@property(nonatomic,retain)NSString *strcollectors;
@property(nonatomic,retain)NSString *strsmallimage;
@property(nonatomic,retain)NSString *strthumbnail;
@property(nonatomic,retain)NSString *strhumanFigure;
@property(nonatomic,retain)NSString *strStatus;
@property(nonatomic,retain)NSString *strimage;
@property(nonatomic,retain)NSString *strproductsize;
@property(nonatomic,retain)NSString *strproductdate;
@property(nonatomic,retain)NSString *strestamiate;
@property(nonatomic,retain)NSString *stractive;
@property(nonatomic,retain)NSString *strBidclosingtime;
@property(nonatomic,retain)NSString *strTypeOfCell;
@property(nonatomic,retain)NSString *strOnline;
@property(nonatomic,retain)NSString *strReference;
@property(nonatomic,retain)NSString *strCurrentDate;
@property(nonatomic,retain)NSString *strArtistProfile;
@property(nonatomic,retain)NSString *strArtistPicture;
@property(nonatomic,retain)NSString *strDollarRate;
@property(nonatomic,retain)NSString *strAuctionname;
@property(nonatomic,retain)NSString *strPrdescription;
@property(nonatomic,retain)NSString *strmyBidClosingTime;
@property(nonatomic,retain)NSString *strtimeRemains;

@property(nonatomic,retain)clsArtistInfo *objArtistInfo;
@property(nonatomic,retain)clsMedia *objMediaInfo;
@property(nonatomic,retain)clsCategory *objCategoryInfo;
@property(nonatomic) int IsSwapOn;

@property(nonatomic,retain)NSString *strcategory;
@property(nonatomic,retain)NSString *strmedium;
@property(nonatomic,retain)NSString *strFirstName;
@property(nonatomic,retain)NSString *strLastName;
@property(nonatomic,retain)NSString *strbidartistuserid;
@property(nonatomic,retain)NSString *strauctionBanner;

@property(nonatomic,retain)NSString *isAnimate;
@property(nonatomic,retain)NSString *strpricelow;
@end
