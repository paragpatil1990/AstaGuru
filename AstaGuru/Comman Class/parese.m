//
//  parese.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "parese.h"

@implementation parese
+(NSMutableArray*)parseCurrentOccution:(NSMutableArray*)json
{
    NSMutableArray *arrLib=[[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        
        clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
        NSMutableDictionary *dictLib=[json objectAtIndex:j];
        dictLib=[ClsSetting RemoveNullOnly:dictLib];
        objCurrentOccution.strproductid=[dictLib valueForKey:@"productid"];
        objCurrentOccution.strtitle=[dictLib valueForKey:@"title"];
        objCurrentOccution.strdescription=[dictLib valueForKey:@"description"];
        objCurrentOccution.strartist_id=[dictLib valueForKey:@"artistid"];
        objCurrentOccution.strpricers=[dictLib valueForKey:@"pricers"];
          objCurrentOccution.strpriceus=[dictLib valueForKey:@"priceus"];
        objCurrentOccution.strcategory_id=[dictLib valueForKey:@"categoryid"];
        objCurrentOccution.strstyle_id=[dictLib valueForKey:@"styleid"];
        objCurrentOccution.strmedium_id=[dictLib valueForKey:@"mediumid"];
       // objCurrentOccution.str=[dictLib valueForKey:@"featured"];
        objCurrentOccution.strcollectors=[dictLib valueForKey:@"collectors"];
        objCurrentOccution.strthumbnail=[dictLib valueForKey:@"thumbnail"];
        objCurrentOccution.strimage=[dictLib valueForKey:@"image"];
        objCurrentOccution.strproductsize=[dictLib valueForKey:@"productsize"];
        objCurrentOccution.strproductdate=[dictLib valueForKey:@"productdate"];
        objCurrentOccution.strestamiate=[dictLib valueForKey:@"estamiate"];
        objCurrentOccution.strsmallimage=[dictLib valueForKey:@"smallimage"];
        objCurrentOccution.strReference=[dictLib valueForKey:@"reference"];
        objCurrentOccution.strBidclosingtime=[dictLib valueForKey:@"Bidclosingtime"];
         objCurrentOccution.strOnline=[dictLib valueForKey:@"Online"];
        objCurrentOccution.strTypeOfCell=@"0";
        NSMutableDictionary *dictArtistInfo=[dictLib valueForKey:@"artist_by_artistid"];
         NSMutableDictionary *dictCategoryInfo=[dictLib valueForKey:@"category_by_categoryid"];
         NSMutableDictionary *dictMediumInfo=[dictLib valueForKey:@"medium_by_mediumid"];
        
        clsArtistInfo *objArtistInfo=[[clsArtistInfo alloc]init];
        objArtistInfo.strArtistid=[dictArtistInfo valueForKey:@"artistid"];
        objArtistInfo.strFirstName=[dictArtistInfo valueForKey:@"FirstName"];
        objArtistInfo.strLastName=[dictArtistInfo valueForKey:@"LastName"];
        objArtistInfo.strProfile=[dictArtistInfo valueForKey:@"Profile"];
        objArtistInfo.strPicture=[dictArtistInfo valueForKey:@"Picture"];
        
        clsMedia *objMediaInfo=[[clsMedia alloc]init];
        objMediaInfo.strMediumidid=[dictMediumInfo valueForKey:@"mediumid"];
        objMediaInfo.strMediumName=[dictMediumInfo valueForKey:@"medium"];
        
        
        clsCategory *objCategoryInfo=[[clsCategory alloc]init];
        objCategoryInfo.strCategoryid=[dictCategoryInfo valueForKey:@"categoryid"];
        objCategoryInfo.strCategoryName=[dictCategoryInfo valueForKey:@"category"];
        objCategoryInfo.strPrVat=[dictCategoryInfo valueForKey:@"PrVat"];
        
        objCurrentOccution.objArtistInfo=objArtistInfo;
        objCurrentOccution.objCategoryInfo=objCategoryInfo;
        objCurrentOccution.objMediaInfo=objMediaInfo;
        
        [arrLib addObject:objCurrentOccution];
        
    }
    
    
    return arrLib;
}
+(NSMutableArray*)parsePastOccution:(NSMutableArray*)json
{
    NSMutableArray *arrLib=[[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        clsPastAuctionData *objPastAuctionData=[[clsPastAuctionData alloc]init];
        NSMutableDictionary *dictLib=[json objectAtIndex:j];
        dictLib=[ClsSetting RemoveNull:dictLib];
        objPastAuctionData.strAuctionId=[dictLib valueForKey:@"AuctionId"];
        objPastAuctionData.strAuctionname=[dictLib valueForKey:@"Auctionname"];
        objPastAuctionData.strDate=[dictLib valueForKey:@"Date"];
        objPastAuctionData.strDollarRate=[dictLib valueForKey:@"DollarRate"];
        objPastAuctionData.strImage=[dictLib valueForKey:@"image"];
        objPastAuctionData.strAuctiondate=[dictLib valueForKey:@"auctiondate"];
        objPastAuctionData.strAuctiontitle=[dictLib valueForKey:@"auctiontitle"];
        objPastAuctionData.strStatus=[dictLib valueForKey:@"status"];
        [arrLib addObject:objPastAuctionData];
        
    }
    
    
    return arrLib;
}

+(NSMutableArray*)parseMyAuctionGallery:(NSMutableArray*)json fromBid:(int)fromBid
{
    NSMutableArray *arrLib=[[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        clsMyAuctionGallery *objMyAuctionGallery=[[clsMyAuctionGallery alloc]init];
        NSMutableDictionary *dictLib=[json objectAtIndex:j];
        
        dictLib=[ClsSetting RemoveNullOnly:dictLib];
        objMyAuctionGallery.strAuctionId=[dictLib valueForKey:@"AuctionId"];
        objMyAuctionGallery.strBidpricers=[dictLib valueForKey:@"Bidpricers"];
        objMyAuctionGallery.strBidpriceus=[dictLib valueForKey:@"Bidpriceus"];
        objMyAuctionGallery.strBidrecordid=[dictLib valueForKey:@"Bidrecordid"];
        objMyAuctionGallery.strFirstname=[dictLib valueForKey:@"Firstname"];
        objMyAuctionGallery.strLastname=[dictLib valueForKey:@"Lastname"];
        objMyAuctionGallery.strReference=[dictLib valueForKey:@"Reference"];
        
        
        objMyAuctionGallery.strThumbnail=[dictLib valueForKey:@"Thumbnail"];
        objMyAuctionGallery.strUserId=[dictLib valueForKey:@"UserId"];
        objMyAuctionGallery.strUsername=[dictLib valueForKey:@"Username"];
        objMyAuctionGallery.stranoname=[dictLib valueForKey:@"anoname"];
        objMyAuctionGallery.strcurrentbid=[dictLib valueForKey:@"currentbid"];
        objMyAuctionGallery.strdaterec=[dictLib valueForKey:@"daterec"];
        objMyAuctionGallery.strearlyproxy=[dictLib valueForKey:@"earlyproxy"];
        
        
        objMyAuctionGallery.strproductid=[dictLib valueForKey:@"productid"];
        objMyAuctionGallery.strproxy=[dictLib valueForKey:@"proxy"];
        objMyAuctionGallery.strrecentbid=[dictLib valueForKey:@"recentbid"];
        objMyAuctionGallery.strvalidbidpricers=[dictLib valueForKey:@"validbidpricers"];
        objMyAuctionGallery.strvalidbidpriceus=[dictLib valueForKey:@"validbidpriceus"];
        objMyAuctionGallery.strFromBid=[NSString stringWithFormat:@"%d",fromBid];
        if (fromBid!=1)
        {
            
        
        NSMutableArray *arrProduct=[[NSMutableArray alloc]init];
        [arrProduct addObject:[dictLib valueForKey:@"acution_by_productid"]];
        NSMutableArray *arrEntity=[self parseCurrentOccution:arrProduct];
        if (arrEntity>0)
        {
            objMyAuctionGallery.objCurrentAuction=[arrEntity objectAtIndex:0];
            
        }
        }
        [arrLib addObject:objMyAuctionGallery];
        
    }
    
    
    return arrLib;
}
+(NSMutableArray*)parseCategory:(NSMutableArray*)json
{
    NSMutableArray *arrLib=[[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        clsCategory *objCategory=[[clsCategory alloc]init];
        NSMutableDictionary *dictLib=[json objectAtIndex:j];
        
        dictLib=[ClsSetting RemoveNullOnly:dictLib];
        objCategory.strCategoryid=[dictLib valueForKey:@"categoryid"];
        objCategory.strCategoryName=[dictLib valueForKey:@"category"];
        objCategory.strPrVat=[dictLib valueForKey:@"PrVat"];
       [arrLib addObject:objCategory];
        
    }
    
    
    return arrLib;
}
+(NSMutableArray*)parseArtistInfo:(NSMutableArray*)json
{
    NSMutableArray *arrLib=[[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        clsArtistInfo *objArtistInfo=[[clsArtistInfo alloc]init];
        NSMutableDictionary *dictLib=[json objectAtIndex:j];
        
        dictLib=[ClsSetting RemoveNullOnly:dictLib];
        objArtistInfo.strFirstName=[dictLib valueForKey:@"FirstName"];
        objArtistInfo.strLastName=[dictLib valueForKey:@"LastName"];
        objArtistInfo.strPicture=[dictLib valueForKey:@"Picture"];
        objArtistInfo.strArtistid=[dictLib valueForKey:@"artistid"];
        objArtistInfo.strProfile=[dictLib valueForKey:@"Profile"];
        [arrLib addObject:objArtistInfo];
        
    }
    
    
    return arrLib;
}


+(NSMutableArray*)parseSortCurrentAuction:(NSMutableArray*)json
{
    NSMutableArray *arrLib=[[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        
        clsCurrentOccution *objCurrentOccution=[[clsCurrentOccution alloc]init];
        NSMutableDictionary *dictLib=[json objectAtIndex:j];
        dictLib=[ClsSetting RemoveNullOnly:dictLib];
        objCurrentOccution.strproductid=[dictLib valueForKey:@"productid"];
       
        objCurrentOccution.strtitle=[dictLib valueForKey:@"title"];
        objCurrentOccution.strdescription=[dictLib valueForKey:@"description"];
        objCurrentOccution.strartist_id=[dictLib valueForKey:@"artistid"];
        objCurrentOccution.strpricers=[dictLib valueForKey:@"pricers"];
        objCurrentOccution.strpriceus=[dictLib valueForKey:@"priceus"];
        objCurrentOccution.strcategory_id=[dictLib valueForKey:@"categoryid"];
        objCurrentOccution.strcategory=[dictLib valueForKey:@"category"];
        objCurrentOccution.strstyle_id=[dictLib valueForKey:@"styleid"];
        objCurrentOccution.strmedium_id=[dictLib valueForKey:@"mediumid"];
        objCurrentOccution.strmedium=[dictLib valueForKey:@"medium"];
        // objCurrentOccution.str=[dictLib valueForKey:@"featured"];
        objCurrentOccution.strcollectors=[dictLib valueForKey:@"collectors"];
        objCurrentOccution.strthumbnail=[dictLib valueForKey:@"thumbnail"];
        objCurrentOccution.strimage=[dictLib valueForKey:@"image"];
        objCurrentOccution.strproductsize=[dictLib valueForKey:@"productsize"];
        objCurrentOccution.strproductdate=[dictLib valueForKey:@"productdate"];
        objCurrentOccution.strestamiate=[dictLib valueForKey:@"estamiate"];
        objCurrentOccution.strsmallimage=[dictLib valueForKey:@"smallimage"];
        objCurrentOccution.strReference=[dictLib valueForKey:@"reference"];
        objCurrentOccution.strBidclosingtime=[dictLib valueForKey:@"Bidclosingtime"];
        objCurrentOccution.strOnline=[dictLib valueForKey:@"Online"];
        objCurrentOccution.strFirstName=[dictLib valueForKey:@"FirstName"];
        objCurrentOccution.strLastName=[dictLib valueForKey:@"LastName"];
        
        objCurrentOccution.strTypeOfCell=@"0";
        
        NSMutableDictionary *dictArtistInfo=[dictLib valueForKey:@"artist_by_artistid"];
      
        
        clsArtistInfo *objArtistInfo=[[clsArtistInfo alloc]init];
        objArtistInfo.strArtistid=[dictArtistInfo valueForKey:@"artistid"];
        objArtistInfo.strFirstName=[dictArtistInfo valueForKey:@"FirstName"];
        objArtistInfo.strLastName=[dictArtistInfo valueForKey:@"LastName"];
        objArtistInfo.strProfile=[dictArtistInfo valueForKey:@"Profile"];
        objArtistInfo.strPicture=[dictArtistInfo valueForKey:@"Picture"];
       
       
        
        
       
        
       
        
        [arrLib addObject:objCurrentOccution];
        
    }
    
    
    return arrLib;
}

@end
