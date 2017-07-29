//
//  clsPastAuctionData.m
//  AstaGuru
//
//  Created by Aarya Tech on 19/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "PastAuction.h"
#import "GlobalClass.h"

@implementation PastAuction

+(NSMutableArray*)parsePastAuction:(NSMutableArray*)json
{
    NSMutableArray *arrAuction = [[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        PastAuction *objPastAuction = [[PastAuction alloc] init];
        
        NSDictionary *dictAuction = [GlobalClass removeNullOnly:[json objectAtIndex:j]];
        
        objPastAuction.strAuctionId = dictAuction[@"AuctionId"];
        objPastAuction.strAuctionname = dictAuction[@"Auctionname"];
        objPastAuction.strAuctionBanner = dictAuction[@"auctionBanner"];
        objPastAuction.strDate = dictAuction[@"Date"];
        objPastAuction.strDollarRate = dictAuction[@"DollarRate"];
        objPastAuction.strImage = dictAuction[@"image"];
        objPastAuction.strAuctiondate = dictAuction[@"auctiondate"];
        objPastAuction.strAuctiontitle = dictAuction[@"auctiontitle"];
        objPastAuction.strStatus =  dictAuction[@"status"];
        objPastAuction.strTotalSaleValueRs = [GlobalClass trimWhiteSpaceAndNewLine:dictAuction[@"totalSaleValueRs"]];
        objPastAuction.strTotalSaleValueUs = [GlobalClass trimWhiteSpaceAndNewLine:dictAuction[@"totalSaleValueUs"]];
        objPastAuction.strupcomingCountVal = dictAuction[@"upcomingCountVal"];
        
        [arrAuction addObject:objPastAuction];
    }
    return arrAuction;
}


@end
