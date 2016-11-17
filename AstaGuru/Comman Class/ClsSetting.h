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
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define USER_id         @"userid"
#define USER_NAME      @"username"
#define CUST_MOBILENO   @"cust_number"
#define CUST_NAME       @"cust_name"
#define CUST_IMAGE       @"cust_image"
#define CUST_ZIP       @"cust_zip"
#define CUST_CITY       @"cust_city"
#define CUST_STATE       @"cust_state"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@protocol PassResepose
-(void)passReseposeData:(id)arr;
-(void)passReseposeData1:(id)str;
@end

@interface ClsSetting : NSObject

+(CGFloat)CalculateHeightOfTextview:(UITextView *)TxtVw;
+(void)Downloadimage;
+(void)underline:(UIView*)textField;
+(NSString*)TrimWhiteSpaceAndNewLine:(NSString*)strString;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(void)internetConnectionPromt;
+(void)ValidationPromt:(NSString*)strValidationText;
-(NSString *)Url;
+(NSString *)ImageURL;
+(NSMutableArray *)getMenu;
+(NSMutableArray *)getMenuHome;
+(NSMutableArray *)getMenuMyList;
+(NSMutableArray *)getMenuSaved;
+(void)SetBorder:(UIView *)viw cornerRadius:(CGFloat)CornerRadius borderWidth:(CGFloat)borderWidth;
+(NSString*)getAddress:(CLLocation*)newLocation;

//+(void)setComments:(NSMutableArray*)arrComments label:(UILabel*)Title;
-(void)CallWeb:(NSMutableDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview Post:(BOOL)isPost;
@property (readwrite) id<PassResepose> PassReseposeDatadelegate;
-(void)calllPostWeb:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
//-(void)calllPutWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
-(void)calllPutWeb:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
-(void)SendSMSOTP:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
+(NSMutableDictionary*)RemoveNull:(NSMutableDictionary*)dict;
+(NSMutableDictionary*)RemoveNullOnly:(NSMutableDictionary*)dict;
-(void)calllPutWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
-(void)calllPostWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview;
+(void)myAstaGuru:(UINavigationController*)NavigationController;
+(NSString*)getAttributedStringFormHtmlString:(NSString*)htmlString;
+(void)Searchpage:(UINavigationController*)NavigationController;
@end
