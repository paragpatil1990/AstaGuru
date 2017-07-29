//
//  clsPastAuctionData.h
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PastAuction : NSObject
@property(nonatomic,retain)NSString *strAuctionId;
@property(nonatomic,retain)NSString *strAuctionname;
@property(nonatomic,retain)NSString *strAuctionBanner;
@property(nonatomic,retain)NSString *strDate;
@property(nonatomic,retain)NSString *strDollarRate;
@property(nonatomic,retain)NSString *strImage;
@property(nonatomic,retain)NSString *strAuctiondate;
@property(nonatomic,retain)NSString *strAuctiontitle;
@property(nonatomic,retain)NSString *strStatus;
@property(nonatomic,retain)NSString *strTotalSaleValueRs;
@property(nonatomic,retain)NSString *strTotalSaleValueUs;
@property(nonatomic,retain)NSString *formatedTotalSaleValueRS;
@property(nonatomic,retain)NSString *formatedTotalSaleValueUS;

@property(nonatomic,retain)NSString *strupcomingCountVal;


+(NSMutableArray*)parsePastAuction:(NSMutableArray*)json;

@end
