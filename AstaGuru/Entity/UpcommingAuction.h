//
//  UpcommingAuction.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/3/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpcommingAuction : NSObject

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
@property(nonatomic,retain)NSString *strupcomingCountVal;

+(NSMutableArray*)parseUpcommingAuction:(NSMutableArray*)json;


@end
