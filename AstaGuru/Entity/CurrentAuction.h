//
//  clsCurrentOccution.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AuctionType)
{
    AuctionTypeCurrent,
    AuctionTypeUpcoming,
    AuctionTypePast
};

@interface CurrentAuction : NSObject

@property(nonatomic,retain)NSString *strUsername;
@property(nonatomic,retain)NSString *strdaterec;
@property(nonatomic,retain)NSString *stranoname;

@property(nonatomic,retain)NSString *strmyuserid;
@property(nonatomic,retain)NSString *strproductid;
@property(nonatomic,retain)NSString *strtitle;
@property(nonatomic,retain)NSString *strdescription;
@property(nonatomic,retain)NSString *strartistid;
@property(nonatomic,retain)NSString *strartist_name;
@property(nonatomic,retain)NSString *strBidpricers;
@property(nonatomic,retain)NSString *strBidpriceus;
@property(nonatomic,retain)NSString *strstyleid;
@property(nonatomic,retain)NSString *strcategoryid;
@property(nonatomic,retain)NSString *strmediumid;
@property(nonatomic,retain)NSString *strcollectors;
@property(nonatomic,retain)NSString *strsmallimage;
@property(nonatomic,retain)NSString *strthumbnail;
@property(nonatomic,retain)NSString *strHumanFigure;
@property(nonatomic,retain)NSString *strstatus;
@property(nonatomic,retain)NSString *strimage;
@property(nonatomic,retain)NSString *strproductsize;
@property(nonatomic,retain)NSString *strproductdate;
@property(nonatomic,retain)NSString *strestamiate;
@property(nonatomic,retain)NSString *stractive;
@property(nonatomic,retain)NSString *strBidclosingtime;
@property(nonatomic,retain)NSString *strOnline;
@property(nonatomic,retain)NSString *strreference;
@property(nonatomic,retain)NSString *strcurrentDate;
@property(nonatomic,retain)NSString *strProfile;
@property(nonatomic,retain)NSString *strPicture;
@property(nonatomic,retain)NSString *strDollarRate;
@property(nonatomic,retain)NSString *strAuctionname;
@property(nonatomic,retain)NSString *strPrdescription;
@property(nonatomic,retain)NSString *strcategory;
@property(nonatomic,retain)NSString *strmedium;
@property(nonatomic,retain)NSString *strFirstName;
@property(nonatomic,retain)NSString *strLastName;
@property(nonatomic,retain)NSString *strbidartistuserid;
@property(nonatomic,retain)NSString *strauctionBanner;
@property(nonatomic,retain)NSString *strpricelow;
@property(nonatomic,retain)NSString *strmyBidClosingTime;
@property(nonatomic,retain)NSString *strtimeRemains;

@property(nonatomic,retain)NSString *formatedBidClosingTime;

@property(nonatomic,retain)NSString *strnextpricers;
@property(nonatomic,retain)NSString *strnextpriceus;

@property(nonatomic,retain)NSString *strWinPriceRS;
@property(nonatomic,retain)NSString *strWinPriceUS;

@property(nonatomic,retain)NSString *formatedCurrentBidPriceRS;
@property(nonatomic,retain)NSString *formatedCurrentBidPriceUS;

@property(nonatomic,retain)NSString *formatedNextValidBidPriceRS;
@property(nonatomic,retain)NSString *formatedNextValidBidPriceUS;

@property(nonatomic,retain)NSString *formatedWinPriceRS;
@property(nonatomic,retain)NSString *formatedWinPriceUS;

@property(nonatomic)NSInteger cellType;
@property(nonatomic)NSInteger isSwipOn;

@property (nonatomic, assign) AuctionType auctionType;


+(NSMutableArray*)parseAuction:(NSMutableArray*)json auctionType:(AuctionType)auctionType;

@end
