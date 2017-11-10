//
//  ClsSetting.h
//  My Ghar Seva
//
//  Created by sumit mashalkar on 30/01/16.
//  Copyright © 2016 winjit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "iToast.h"
#import "parese.h"
#import "CustomTextfied.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "CurrentDefultGridCollectionViewCell.h"
#define USER_id         @"userid"
#define USER_NAME      @"username"

//#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@protocol PassResepose
@optional
-(void)passReseposeData:(id)arr;
-(void)passReseposeData1:(id)str;
@end

@interface ClsSetting : NSObject

+(CGFloat)CalculateHeightOfTextview:(UITextView *)TxtVw;
+(void)underline:(UIView*)textField;
+(NSString*)TrimWhiteSpaceAndNewLine:(NSString*)strString;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(void)internetConnectionPromt;
+(void)ValidationPromt:(NSString*)strValidationText;
+(void)SetBorder:(UIView *)viw cornerRadius:(CGFloat)CornerRadius borderWidth:(CGFloat)borderWidth color:(UIColor*)color;
+(NSString*)getAddress:(CLLocation*)newLocation;
//+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize;

+(CGFloat)heightForNSString:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+(CGFloat)heightForNSAttributedString:(NSAttributedString*)astr havingWidth:(CGFloat)width;


//+(void)setComments:(NSMutableArray*)arrComments label:(UILabel*)Title;
-(void)CallWeb:(NSMutableDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview Post:(BOOL)isPost;
@property (readwrite) id<PassResepose> PassReseposeDatadelegate;
-(void)calllPostWeb:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
//-(void)calllPutWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
-(void)calllPutWeb:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
-(void)SendSMSOTP:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
+(NSMutableDictionary*)RemoveNull:(NSMutableDictionary*)dict;
+(NSMutableDictionary*)RemoveNullOnly:(NSMutableDictionary*)dict;
//-(void)calllPutWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
-(void)calllPostWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
+(void)myAstaGuru:(UINavigationController*)NavigationController;
+(NSString*)getAttributedStringFormHtmlString:(NSString*)htmlString;
+(void)Searchpage:(UINavigationController*)NavigationController;

+(NSString *)tableURL;
+(NSString *)imageURL;
+(NSString *)procedureURL;
+(NSString *)apiKey;
+(NSString *)autionAnalysisURL;
+(NSString *)emailURL;

-(void)CallWebDelete:(NSMutableDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview Post:(BOOL)isPost;

+(void)sendEmailWithInfo:(NSDictionary*)infoDic;
+(void)ISUSerLeading:(NSString*)strUserID Cell:(CurrentDefultGridCollectionViewCell*)cell;
@end
