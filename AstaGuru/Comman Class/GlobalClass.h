//
//  ClsSetting.h
//  My Ghar Seva
//
//  Created by sumit mashalkar on 30/01/16.
//  Copyright © 2016 winjit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

#define USER @"user"
#define USER_ID @"userid"
#define RUSER_ID @"ruserid"
#define USER_NAME @"username"
#define USER_EMAIL @"email"
#define USER_MOBILE @"Mobile"
#define USER_CONFIRMBID @"confirmbid"
#define USER_EMAILVERIFIED @"EmailVerified"
#define USER_MOBILEVERIFIED @"MobileVerified"
#define DEVICETOKEN @"deviceToken"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

typedef struct {
    NSInteger nextBidPriceRS;
    NSInteger nextBidPriceUS;
    NSInteger winPriceRS;
    NSInteger winPriceUS;
} NextBidPrice;


@interface GlobalClass : NSObject

+(void)isLive:(BOOL)live;
+(NSString*)mainURL;
+(NSString*)tableURL;
+(NSString*)imageURL;
+(NSString*)procedureURL;
+(NSString*)apiKey;
+(NSString*)autionAnalysisURL;
+(NSString*)emailURL;
+(NSString*)smsURL;

+(BOOL)isValidEmail:(NSString *)emailStr;
+(BOOL)isUserLogin;
+(BOOL)isUserVerified;
+(BOOL)isUserBidAccess;
+(BOOL)isUserLeadingOnLot:(int)myUserID;
+(BOOL)isAuctionClosed:(NSString*)strtimeRemains;

//+(BOOL)isAuctionClosed:(CurrentAuction*)currentAuction;

+(CGFloat)heightForNSString:(NSString *)text havingWidth:(CGFloat)width font:(UIFont*)font;
+(CGFloat)heightForNSAttributedString:(NSAttributedString*)text havingWidth:(CGFloat)width;

+(NextBidPrice)getIncrementBidPriceRS:(NSInteger)bidPriceRS BidPriceUS:(NSInteger)bidPriceUS;

+(NSDictionary*)removeNullOnly:(NSDictionary*)fromDic;

+(NSString*)getUserID;

+(NSString*)getName;

+(NSString*)getUserFullName;

+(NSString*)trimWhiteSpaceAndNewLine:(NSString*)strString;

+(NSAttributedString*)showHTMLText:(NSString*)HTMLString;

+(NSMutableAttributedString*)getAttributedString:(NSString*)text havingFont:(UIFont*)font;

+(NSString*)convertHTMLTextToPlainText:(NSString*)HTMLString;

+(NSString*)timeCountFromCurrentDate:(NSString*)currentDateStr closingDate:(NSString*)closingDateStr;

+(void)underline:(UIView*)textField color:(UIColor*)color;

+(void)setBorder:(UIView *)view cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width color:(UIColor*)color;

+(void)showTost:(NSString*)text;

+(void)sendSMS:(NSDictionary*)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)sendEmail:(NSDictionary*)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(AFHTTPRequestOperation*)call_tableGETWebURL:(NSString*)strURL parameters:(NSDictionary*)parameters  view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure callingCount:(NSInteger)count;

+(void)call_tablePOSTWebURL:(NSString*)strURL parameters:(NSDictionary*)parameters  view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)call_tablePUTWeb:(NSString*)strURL parameters:(NSDictionary*)parameters view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)call_tableDELETEWeb:(NSString*)strURL parameters:(NSDictionary*)parameters view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(AFHTTPRequestOperation*)call_procGETWebURL:(NSString*)strURL parameters:(NSDictionary*)parameters  view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure callingCount:(NSInteger)count;
@end
