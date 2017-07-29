//
//  clsCurrentOccution.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CurrentAuction.h"
#import "GlobalClass.h"

@implementation CurrentAuction

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


+(NSMutableArray*)parseAuction:(NSMutableArray*)json auctionType:(AuctionType)auctionType
{
    NSMutableArray *arrAuction = [[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        CurrentAuction *objAuction = [[CurrentAuction alloc] init];
        
        NSDictionary *dictAuction = [GlobalClass removeNullOnly:[json objectAtIndex:j]];
        
        objAuction.strUsername = [dictAuction valueForKey:@"Username"];
        objAuction.stranoname = [dictAuction valueForKey:@"anoname"];
        objAuction.strdaterec = [dictAuction valueForKey:@"daterec"];
        objAuction.strmyuserid = [dictAuction valueForKey:@"MyUserID"];
        objAuction.strproductid = [dictAuction valueForKey:@"productid"];
        objAuction.strtitle = [dictAuction valueForKey:@"title"];
        objAuction.strdescription = [dictAuction valueForKey:@"description"];
        objAuction.strartistid = [dictAuction valueForKey:@"artistid"];
        objAuction.strBidpricers = [dictAuction valueForKey:@"Bidpricers"];
        objAuction.strBidpriceus = [dictAuction valueForKey:@"Bidpriceus"];
        objAuction.strcategoryid = [dictAuction valueForKey:@"categoryid"];
        objAuction.strcategory = [dictAuction valueForKey:@"category"];
        objAuction.strstyleid = [dictAuction valueForKey:@"styleid"];
        objAuction.strmediumid = [dictAuction valueForKey:@"mediumid"];
        objAuction.strmedium = [dictAuction valueForKey:@"medium"];
        objAuction.strcollectors = [dictAuction valueForKey:@"collectors"];
        objAuction.strthumbnail = [dictAuction valueForKey:@"thumbnail"];
        objAuction.strimage = [dictAuction valueForKey:@"image"];
        objAuction.strproductsize = [dictAuction valueForKey:@"productsize"];
        objAuction.strproductdate = [dictAuction valueForKey:@"productdate"];
        objAuction.strestamiate = [dictAuction valueForKey:@"estamiate"];
        objAuction.strsmallimage = [dictAuction valueForKey:@"smallimage"];
        objAuction.strreference = [GlobalClass trimWhiteSpaceAndNewLine:[NSString stringWithFormat:@"%@",[dictAuction valueForKey:@"reference"]]];
        objAuction.strOnline = [GlobalClass trimWhiteSpaceAndNewLine:[dictAuction valueForKey:@"Online"]];
        objAuction.strFirstName = [dictAuction valueForKey:@"FirstName"];
        objAuction.strLastName = [dictAuction valueForKey:@"LastName"];
        objAuction.strPicture = [dictAuction valueForKey:@"Picture"];
        objAuction.strProfile = [dictAuction valueForKey:@"Profile"];
        objAuction.strDollarRate = [dictAuction valueForKey:@"DollarRate"];
        objAuction.strbidartistuserid = [dictAuction valueForKey:@"bidartistuserid"];
        objAuction.strcurrentDate = [dictAuction valueForKey:@"currentDate"];
        objAuction.strBidclosingtime = [dictAuction valueForKey:@"Bidclosingtime"];
        objAuction.strHumanFigure = [dictAuction valueForKey:@"HumanFigure"];
        objAuction.strstatus = [dictAuction valueForKey:@"status"];
        objAuction.strauctionBanner = [dictAuction valueForKey:@"auctionBanner"];
        objAuction.strpricelow = [dictAuction valueForKey:@"pricelow"];
        objAuction.strAuctionname = [dictAuction valueForKey:@"Auctionname"];
        objAuction.strPrdescription = [dictAuction valueForKey:@"Prdescription"];
        objAuction.strmyBidClosingTime = [dictAuction valueForKey:@"myBidClosingTime"];
        objAuction.strtimeRemains = [dictAuction valueForKey:@"timeRemains"];
        
        // set custom bid closing time
        //        NSString *closeingTime = [dictAuction valueForKey:@"myBidClosingTime"];
        NSArray *timeArray = [objAuction.strmyBidClosingTime componentsSeparatedByString:@" "];
        NSString *dateString = [timeArray lastObject];//@"13:17:34.674194";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss:SS";
        NSDate *yourDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"HH:mm:ss";
        objAuction.formatedBidClosingTime = [NSString stringWithFormat:@"%@ %@", [timeArray objectAtIndex:0],[dateFormatter stringFromDate:yourDate]];
        
        //set custom bid values
        NSInteger currentBidPriceRS = [objAuction.strBidpricers integerValue];
        NSInteger curentBidPriceUS = [objAuction.strBidpriceus integerValue];
        NextBidPrice nextBidPrice = [GlobalClass getIncrementBidPriceRS:currentBidPriceRS BidPriceUS:curentBidPriceUS];
        
        objAuction.strnextpricers = [NSString stringWithFormat:@"%ld", (long)nextBidPrice.nextBidPriceRS];
        objAuction.strnextpriceus = [NSString stringWithFormat:@"%ld", (long)nextBidPrice.nextBidPriceUS];
        objAuction.strWinPriceRS = [NSString stringWithFormat:@"%ld", (long)nextBidPrice.winPriceRS];
        objAuction.strWinPriceUS = [NSString stringWithFormat:@"%ld", (long)nextBidPrice.winPriceUS];
        
        NSNumberFormatter *numberFormatterRS = [[NSNumberFormatter alloc] init] ;
        [numberFormatterRS setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatterRS setMaximumFractionDigits:0];
        numberFormatterRS.currencyCode = @"INR";
        objAuction.formatedCurrentBidPriceRS = [numberFormatterRS stringFromNumber:[NSNumber numberWithInteger:currentBidPriceRS]];
        objAuction.formatedNextValidBidPriceRS = [numberFormatterRS stringFromNumber:[NSNumber numberWithInteger:nextBidPrice.nextBidPriceRS]];
        objAuction.formatedWinPriceRS = [numberFormatterRS stringFromNumber:[NSNumber numberWithInteger:nextBidPrice.winPriceRS]];
        
        NSNumberFormatter *numberFormatterUS = [[NSNumberFormatter alloc] init] ;
        [numberFormatterUS setNumberStyle: NSNumberFormatterCurrencyStyle];
        numberFormatterUS.currencyCode = @"USD";
        [numberFormatterUS setMaximumFractionDigits:0];
        objAuction.formatedCurrentBidPriceUS = [numberFormatterUS stringFromNumber:[NSNumber numberWithInteger:curentBidPriceUS]];
        objAuction.formatedNextValidBidPriceUS = [numberFormatterUS stringFromNumber:[NSNumber numberWithInteger:nextBidPrice.nextBidPriceUS]];
        objAuction.formatedWinPriceUS = [numberFormatterUS stringFromNumber:[NSNumber numberWithInteger:nextBidPrice.winPriceUS]];
        
        objAuction.cellType = 0;
        objAuction.isSwipOn = 0;
        objAuction.auctionType = (AuctionType)auctionType;
        
        [arrAuction addObject:objAuction];
    }
    return arrAuction;
}

@end
