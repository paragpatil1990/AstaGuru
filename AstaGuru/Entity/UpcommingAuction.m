//
//  UpcommingAuction.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/3/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "UpcommingAuction.h"
#import "GlobalClass.h"

@implementation UpcommingAuction

+(NSMutableArray*)parseUpcommingAuction:(NSMutableArray*)json
{
    NSMutableArray *arrAuction = [[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        UpcommingAuction *objUpcommingAuction = [[UpcommingAuction alloc] init];
        
        NSDictionary *dictAuction = [GlobalClass removeNullOnly:[json objectAtIndex:j]];
        
        objUpcommingAuction.strAuctionId = dictAuction[@"AuctionId"];
        objUpcommingAuction.strAuctionname = dictAuction[@"Auctionname"];
        objUpcommingAuction.strAuctionBanner = dictAuction[@"auctionBanner"];
        objUpcommingAuction.strDate = dictAuction[@"Date"];
        objUpcommingAuction.strDollarRate = dictAuction[@"DollarRate"];
        objUpcommingAuction.strImage = dictAuction[@"image"];
        objUpcommingAuction.strAuctiondate = dictAuction[@"auctiondate"];
        objUpcommingAuction.strAuctiontitle = dictAuction[@"auctiontitle"];
        objUpcommingAuction.strStatus =  dictAuction[@"status"];
        objUpcommingAuction.strTotalSaleValueRs = dictAuction[@"totalSaleValueRs"];
        objUpcommingAuction.strTotalSaleValueUs = dictAuction[@"totalSaleValueUs"];
        objUpcommingAuction.strupcomingCountVal = dictAuction[@"upcomingCountVal"];
        [arrAuction addObject:objUpcommingAuction];
    }
    return arrAuction;
}

@end
