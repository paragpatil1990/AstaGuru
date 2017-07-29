//
//  ClsSetting.m
//  My Ghar Seva
//
//  Created by sumit mashalkar on 30/01/16.
//  Copyright © 2016 winjit. All rights reserved.
//

#import "GlobalClass.h"
#import <QuartzCore/QuartzCore.h>
#import "IToast.h"

@implementation GlobalClass
{
}

+(void)isLive:(BOOL)live
{
    [[NSUserDefaults standardUserDefaults] setBool:live forKey:@"Live"];
}

+(NSString*)getDataBase
{
    BOOL live = [[NSUserDefaults standardUserDefaults] boolForKey:@"Live"];
    if (live)
    {
        return @"guru";
    }
    else
    {
        return @"asta";
    }
}

+(NSString*)mainURL
{
    return @"http://restapi.infomanav.com/api/v2";
}
+(NSString*)tableURL
{
//    return [NSString stringWithFormat:@"%@/guru/_table",[GlobalClass mainURL]];
    return [NSString stringWithFormat:@"%@/%@/_table",[GlobalClass mainURL], [GlobalClass getDataBase]];
}

+(NSString*)procedureURL
{
//    return [NSString stringWithFormat:@"%@/guru/_proc",[GlobalClass mainURL]];
    return [NSString stringWithFormat:@"%@/%@/_proc",[GlobalClass mainURL], [GlobalClass getDataBase]];
}

+(NSString*)apiKey
{
    BOOL live = [[NSUserDefaults standardUserDefaults] boolForKey:@"Live"];
    if (live)
    {
        return @"c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed";
    }
    else
    {
        return @"c255e4bd10c8468f9e7e393b748750ee108d6308e2ef3407ac5d2b163a01fa37";
    }
}

+(NSString*)emailURL
{
    return [NSString stringWithFormat:@"%@/awsses/?api_key=6dee0a21388b49db917cd64559c32bcbde93460f391a594ab7cc6666824d5c26",[GlobalClass mainURL]];
}

+(NSString*)smsURL
{
    return @"http://gateway.netspaceindia.com/api/sendhttp.php?authkey=131841Aotn6vhT583570b5";
}

+(NSString*)imageURL
{
    return @"http://arttrust.southeastasia.cloudapp.azure.com/";
}

+(NSString*)autionAnalysisURL
{
    BOOL live = [[NSUserDefaults standardUserDefaults] boolForKey:@"Live"];
    if (live)
    {
        return @"http://astaguru.com/auction-analysis-mobile.aspx?astaguruauction=";
    }
    else
    {
        return @"http://astaguru.com:81/auction-analysis-mobile.aspx?astaguruauction=";
    }
}

+(BOOL)isValidEmail:(NSString *)emailStr;
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

+(BOOL)isUserLogin
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] != nil)
    {
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_ID] intValue] > 0))
        {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isUserVerified
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USER] != nil)
    {
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_EMAILVERIFIED] intValue] == 1 && [[[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_EMAILVERIFIED] intValue] == 1)
        {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isUserBidAccess
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USER] != nil)
    {
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:USER_CONFIRMBID] intValue] == 1)
        {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isUserLeadingOnLot:(int)myUserID
{
    if ([GlobalClass isUserLogin])
    {
        if ([[GlobalClass getUserID] intValue] == myUserID)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return  NO;
}

//+(BOOL)isAuctionClosed:(CurrentAuction*)currentAuction
+(BOOL)isAuctionClosed:(NSString*)strtimeRemains
{
    if ([strtimeRemains intValue] <= 0)
    {
        return YES;
    }
    return  NO;
}

+(NextBidPrice)getIncrementBidPriceRS:(NSInteger)bidPriceRS BidPriceUS:(NSInteger)bidPriceUS
{
    CGFloat priceIncreaseRateRS = 0.0;
    CGFloat priceIncreaseRateUS = 0.0;

    if (bidPriceRS > 10000000)
    {
        priceIncreaseRateRS = (bidPriceRS * 5)/100;
        priceIncreaseRateUS = (bidPriceUS * 5)/100;
    }
    else
    {
        priceIncreaseRateRS = (bidPriceRS * 10)/100;
        priceIncreaseRateUS = (bidPriceUS * 10)/100;
        
    }
    NSInteger nextValidBidPriceRS = (NSInteger)(bidPriceRS + priceIncreaseRateRS);
    NSInteger nextValidBidPriceUS = (NSInteger)(bidPriceUS + priceIncreaseRateUS);
    
    CGFloat winPriceIncreaseRateRS = (bidPriceRS * 15)/100;
    CGFloat winPriceIncreaseRateUS = (bidPriceRS * 15)/100;
    NSInteger winPriceRS = (NSInteger)(bidPriceRS + winPriceIncreaseRateRS);
    NSInteger winPriceUS = (NSInteger)(bidPriceUS + winPriceIncreaseRateUS);
    
    NextBidPrice nextBidPrice;
    nextBidPrice.nextBidPriceRS = nextValidBidPriceRS;
    nextBidPrice.nextBidPriceUS = nextValidBidPriceUS;
    nextBidPrice.winPriceRS = winPriceRS;
    nextBidPrice.winPriceUS = winPriceUS;
    return nextBidPrice;
}


+(CGFloat)heightForNSString:(NSString *)text havingWidth:(CGFloat)width font:(UIFont*)font
{
    CGSize size = CGSizeZero;
    if (text)
    {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    return size.height;
}

+(CGFloat)heightForNSAttributedString:(NSAttributedString*)text havingWidth:(CGFloat)width
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}


+(NSDictionary*)removeNullOnly:(NSDictionary*)fromDic
{
    NSMutableDictionary *checkNullDic = [fromDic mutableCopy];
    NSArray *arrkeys = [checkNullDic allKeys];
    for (int i=0; i<arrkeys.count;i++ )
    {
        if (([checkNullDic valueForKey:[arrkeys objectAtIndex:i]] == nil) || ([checkNullDic valueForKey:[arrkeys objectAtIndex:i]] == [NSNull null]))
        {
            [checkNullDic setValue:@"" forKey:[arrkeys objectAtIndex:i]];
        }
    }
    return checkNullDic;
}

+(NSString*)getUserID
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] != nil)
    {
        if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_ID] integerValue] > 0))
        {
            return [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
        }
    }
    return @"";
}

+(NSString*)getName
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USER_NAME] != nil)
    {
        return [[NSUserDefaults standardUserDefaults] valueForKey:USER_NAME];
    }
    return @"";
}

+(NSString*)getUserFullName
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USER] != nil)
    {
        return [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:@"name"], [[[NSUserDefaults standardUserDefaults] valueForKey:USER] valueForKey:@"lastname"]];
        
    }
    return @"";
}

+(NSString*)trimWhiteSpaceAndNewLine:(NSString*)strString
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedString = [strString stringByTrimmingCharactersInSet:whitespace];
    return trimmedString;
}

+(NSMutableAttributedString*)getAttributedString:(NSString*)text havingFont:(UIFont*)font
{
    NSDictionary *dictAttribute = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentJustified;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithData:[text dataUsingEncoding:NSUTF8StringEncoding] options:dictAttribute documentAttributes:nil error:nil];
    [attributedStr beginEditing];
    [attributedStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedStr.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
     {
         if (value)
         {
             /*----- Remove old font attribute -----*/
             [attributedStr removeAttribute:NSFontAttributeName range:range];
             //replace your font with new.
             /*----- Add new font attribute -----*/
             [attributedStr addAttribute:NSFontAttributeName value:font range:range];
             [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1] range:range];
             
             [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
         }
     }];
    [attributedStr endEditing];
    return attributedStr;
}

+(NSAttributedString*)showHTMLText:(NSString *)HTMLString
{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[HTMLString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

+(NSString*)convertHTMLTextToPlainText:(NSString*)HTMLString;
{
    NSData *HTMLData = [HTMLString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSString *plainString = attrString.string;
    return plainString;
}

+(NSString*)timeCountFromCurrentDate:(NSString*)currentDateStr closingDate:(NSString*)closingDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    
    NSDate *closingDate = [dateFormatter dateFromString:closingDateStr];
    
    NSTimeInterval secondsBetween = [closingDate timeIntervalSinceDate:currentDate];
    
    int numberOfDays = secondsBetween / 86400;
    
    secondsBetween = (long)secondsBetween % 86400;
    
    int numberOfHours = secondsBetween / 3600;
    
    secondsBetween = (long)secondsBetween % 3600;
    
    int numberOfMinutes = secondsBetween / 60;
    
    secondsBetween = (long)secondsBetween % 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%dD %d:%d:%ld",numberOfDays,numberOfHours,numberOfMinutes,(long)secondsBetween];
    
    if (secondsBetween == 0)
        return @"";
    else if (secondsBetween < 0)
        return @"";
    else
        return timeStr;
}

+(void)underline:(UIView*)textField color:(UIColor*)color
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1.5;
    border.borderColor = color.CGColor;
//    [UIColor colorWithRed:196.0/255.0 green:196.0/255.0 blue:196.0/255.0 alpha:1.0].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
}

+(void)setBorder:(UIView *)view cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width color:(UIColor*)color
{
    view.layer.borderColor = color.CGColor;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth= width;
    view.layer.masksToBounds = YES;
}

+(void)showTost:(NSString*)text;
{
    [[[[IToast makeText:text] setGravity:iToastGravityCenter] setDuration:iToastDurationNormal]show];
}


+(AFHTTPRequestOperationManager*)getAFHTTPRequestOperationManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", nil];
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;

    return manager;
}

+(void)sendSMS:(NSDictionary*)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString  *strUrl = [GlobalClass smsURL];
    NSString *encoded = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *paraDic = @{
                              @"mobiles":parameters[@"mobiles"],
                              @"message":parameters[@"message"],
                              @"sender":@"AstGru",
                              @"route":@"4",
                              @"country":@"91"
                              };
    
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    [manager POST:encoded parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@", responseObject);
        success(responseObject);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         failure(error);
     }];
}

+(void)sendEmail:(NSDictionary*)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString  *strUrl = [GlobalClass emailURL];
    NSDictionary *paraDic = @{
                              @"template":@"newsletter",
                              @"to":parameters[@"to"],
                              @"subject":parameters[@"subject"],
                              @"body_text": parameters[@"body_text"],
                              @"from_name":@"AstaGuru",
                              @"from_email":@"info@infomanav.com",
                              @"reply_to_name":@"AstaGuru",
                              @"reply_to_email":@"info@infomanav.com",
                              };
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    [manager POST:strUrl parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         failure(error);
     }];
}

+(AFHTTPRequestOperation*)call_tableGETWebURL:(NSString*)strURL parameters:(NSDictionary*)parameters  view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure callingCount:(NSInteger)count
{
    if (view != nil)
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.labelText = @"loading";
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@", [GlobalClass tableURL], strURL];
    NSLog(@"%@",url);
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    AFHTTPRequestOperation *task = [manager GET:encodedUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"responseObject : %@", responseObject);
        success(responseObject);
        [MBProgressHUD hideHUDForView:view animated:YES];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error){
         NSLog(@"Error: %@", error);
         NSInteger statusCode = operation.response.statusCode;
         if (statusCode == 500)
         {
             if (count == 1)
             {
                 failure(error);
                 [MBProgressHUD hideHUDForView:view animated:YES];
             }
             else
             {
                 [self call_tableGETWebURL:strURL parameters:parameters view:view success:success failure:failure callingCount:1];
             }
         }
         else
         {
             failure(error);
             [MBProgressHUD hideHUDForView:view animated:YES];
         }
     }];
    return task;
}

+(void)call_tablePOSTWebURL:(NSString*)strURL parameters:(NSDictionary*)parameters  view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    if (view != nil)
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.labelText = @"loading";
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@", [GlobalClass tableURL], strURL];
    NSLog(@"%@",url);
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    [manager POST:encodedUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"responseObject : %@", responseObject);
        success(responseObject);
        [MBProgressHUD hideHUDForView:view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
        [MBProgressHUD hideHUDForView:view animated:YES];
    }];
}

+(void)call_tablePUTWeb:(NSString*)strURL parameters:(NSDictionary*)parameters view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    if (view != nil)
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.labelText = @"loading";
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@", [GlobalClass tableURL], strURL];
    NSLog(@"%@",url);
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    [manager PUT:encodedUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"responseObject : %@", responseObject);
        success(responseObject);
        [MBProgressHUD hideHUDForView:view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
        [MBProgressHUD hideHUDForView:view animated:YES];
    }];

}

+(void)call_tableDELETEWeb:(NSString*)strURL parameters:(NSDictionary*)parameters view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    if (view != nil)
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.labelText = @"loading";
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", [GlobalClass tableURL], strURL];
    NSLog(@"%@",url);
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    [manager DELETE:encodedUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"responseObject : %@", responseObject);
        success(responseObject);
        [MBProgressHUD hideHUDForView:view animated:YES];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
        [MBProgressHUD hideHUDForView:view animated:YES];
    }];
}

+(AFHTTPRequestOperation*)call_procGETWebURL:(NSString*)strURL parameters:(NSDictionary*)parameters  view:(UIView*)view success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure callingCount:(NSInteger)count;
{
    if (view != nil)
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.labelText = @"loading";
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@?api_key=%@", [GlobalClass procedureURL], strURL, [GlobalClass apiKey]];
    NSLog(@"%@",url);
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [GlobalClass getAFHTTPRequestOperationManager];
    AFHTTPRequestOperation *task = [manager GET:encodedUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"responseObject : %@", responseObject);
        success(responseObject);
        [MBProgressHUD hideHUDForView:view animated:YES];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:view animated:YES];
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 500)
        {
            if (count == 1)
            {
                failure(error);
            }
            else
            {
                [self call_procGETWebURL:strURL parameters:parameters view:view success:success failure:failure callingCount:1];
            }
        }
        else
        {
            failure(error);
        }
    }];
    return task;
}
@end
