//
//  parese.h
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "clsCurrentOccution.h"
#import "clsPastAuctionData.h"
#import "ClsSetting.h"
#import "clsMyAuctionGallery.h"
#import "clsSort.h"
#import "ClsHowToBuy.h"
#import "clsAboutUs.h"
@interface parese : NSObject
+(NSMutableArray*)parseCurrentOccution:(NSMutableArray*)json;
+(NSMutableArray*)parsePastOccution:(NSMutableArray*)json;
+(NSMutableArray*)parseMyAuctionGallery:(NSMutableArray*)json fromBid:(int)fromBid;
+(NSMutableArray*)parseCategory:(NSMutableArray*)json;
+(NSMutableArray*)parseArtistInfo:(NSMutableArray*)json;
+(NSMutableArray*)parseSortCurrentAuction:(NSMutableArray*)json;
+(NSMutableArray*)parsevacancy:(NSMutableArray*)json;
+(NSMutableArray*)parsevacancyTitle:(NSMutableArray*)json;
+(clsCurrentOccution*)parseCurrentAuctionObj:(NSMutableDictionary*)dictLib;
@end
