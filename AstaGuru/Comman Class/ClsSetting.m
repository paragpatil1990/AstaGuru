//
//  ClsSetting.m
//  My Ghar Seva
//
//  Created by sumit mashalkar on 30/01/16.
//  Copyright © 2016 winjit. All rights reserved.
//

#import "ClsSetting.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "BforeLoginViewController.h"
#import "AfterLoginViewController.h"
#import "SearchViewController.h"

@implementation ClsSetting
{
}

+(CGFloat)CalculateHeightOfTextview:(UITextView *)TxtVw
{
    NSString *strDescrption=TxtVw.text;
    
    if ([strDescrption isEqualToString:@""] || [strDescrption isEqualToString:@"null"]|| [strDescrption isEqualToString:@"<null>"])
    {
        return 20.0;
    }
    else
    {
        
        CGFloat fixedWidth = TxtVw.frame.size.width;
        CGSize newSize = [TxtVw sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = TxtVw.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        TxtVw.frame = newFrame;
        if (TxtVw.frame.size.height<30.0)
        {
            return 50.0;
        }
        //return expectedLabelSize.height+40;
        return TxtVw.frame.size.height;
    }
    
}

+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(NSString*)TrimWhiteSpaceAndNewLine:(NSString*)strString
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedString = [strString stringByTrimmingCharactersInSet:whitespace];
    return trimmedString;
}


+(void)underline:(UIView*)textField
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1.6;
    border.borderColor = [UIColor colorWithRed:196.0/255.0 green:196.0/255.0 blue:196.0/255.0 alpha:1.0].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
}


+(NSString *)tableURL
{
    //Live
    //return @"http://restapi.infomanav.com/api/v2/guru/_table/";
    
    //Demo
    return @"http://restapi.infomanav.com/api/v2/asta/_table/";
}

+(NSString *)procedureURL
{
    //Live
//    return @"http://restapi.infomanav.com/api/v2/guru/_proc";
    
    //Demo
    return @"http://restapi.infomanav.com/api/v2/asta/_proc";
}

+(NSString *)apiKey
{
    //Live
//    return @"c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed";
    
    //Demo
    return @"c255e4bd10c8468f9e7e393b748750ee108d6308e2ef3407ac5d2b163a01fa37";
}

+(NSString *)emailURL
{
    return @"http://restapi.infomanav.com/api/v2/awsses/?api_key=6dee0a21388b49db917cd64559c32bcbde93460f391a594ab7cc6666824d5c26";
}

+(NSString *)imageURL
{
    return @"http://arttrust.southeastasia.cloudapp.azure.com/";
}

+(NSString *)autionAnalysisURL
{
    //live
//    return @"http://astaguru.com/auction-analysis-mobile.aspx?astaguruauction=";
    
    //Demo
    return @"http://astaguru.com:81/auction-analysis-mobile.aspx?astaguruauction=";
}

+(void)SetBorder:(UIView *)viw cornerRadius:(CGFloat)CornerRadius borderWidth:(CGFloat)borderWidth color:(UIColor*)color
{
    
//    UIColor *lightgray= [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    //[[viw layer] setBorderWidth:1.0f];
    [[viw layer] setBorderColor:color.CGColor];
    viw.layer.cornerRadius=CornerRadius;
    viw.layer.masksToBounds=YES;
    //viw.layer.borderColor=(__bridge CGColorRef _Nullable)(BorderColor);
    viw.layer.borderWidth= borderWidth;
    if ([viw isKindOfClass:[UITextField class]])
    {
        viw.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    }
}


+(NSString*)getAddress:(CLLocation*)newLocation
{
    CLLocation *currentLocation = newLocation;
    CLGeocoder* geocoder = [CLGeocoder new];
    __block CLPlacemark* placemark;
    
   __block NSString *strAddress=@"";
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             
             // strAdd -> take bydefault value nil
             NSString *strAdd = @"";
             
             if ([placemark.subThoroughfare length] != 0)
                 strAdd = placemark.subThoroughfare;
             
             if ([placemark.thoroughfare length] != 0)
             {
                 // strAdd -> store value of current location
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                 else
                 {
                     // strAdd -> store only this value,which is not null
                     strAdd = placemark.thoroughfare;
                 }
             }
             
             if ([placemark.postalCode length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                 else
                     strAdd = placemark.postalCode;
             }
             
             if ([placemark.locality length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                 else
                     strAdd = placemark.locality;
             }
             
             if ([placemark.administrativeArea length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                 else
                     strAdd = placemark.administrativeArea;
             }
             
             if ([placemark.country length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                 else
                     strAdd = placemark.country;
             }
            
                    strAddress=strAdd;
             
             
         }
         
     }];
    NSLog(@"%@",strAddress);
   return strAddress;
}
+(void)internetConnectionPromt
{
    [[[[iToast makeText:@"Please check internet connection"] setGravity:iToastGravityCenter] setDuration:iToastDurationNormal]show];
}
+(void)ValidationPromt:(NSString*)strValidationText
{
    [[[[iToast makeText:strValidationText] setGravity:iToastGravityCenter] setDuration:iToastDurationNormal]show];
}
-(void)CallWeb:(NSMutableDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview Post:(BOOL)isPost
{
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:Callingview animated:YES];
        HUD.labelText = @"loading";

        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        Discparam=dict;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
       
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@",[ClsSetting tableURL],strURL];
        NSString *url = strQuery;
        NSLog(@"%@",url);
    
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict1);
             [MBProgressHUD hideHUDForView:Callingview animated:YES];
             [_PassReseposeDatadelegate passReseposeData:responseObject];
             
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
                  
                  [MBProgressHUD hideHUDForView:Callingview animated:YES];
              }];
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}
-(void)CallWebDelete:(NSMutableDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview Post:(BOOL)isPost
{
    @try {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:Callingview animated:YES];
        HUD.labelText = @"loading";
        
        
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        Discparam=dict;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@",[ClsSetting tableURL],strURL];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager DELETE:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict1);
             [MBProgressHUD hideHUDForView:Callingview animated:YES];
             [_PassReseposeDatadelegate passReseposeData:responseObject];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:Callingview animated:YES];
             }];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}


-(void)calllPostWeb:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:Callingview animated:YES];
    HUD.labelText = @"loading";

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Dict %@",dict);
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    [manager POST:strURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//          NSError *error=nil;
        //NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
       // NSError *error;
      //  NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
       // NSLog(@"%@",responseStr);
        
        [_PassReseposeDatadelegate passReseposeData1:responseObject];
        [MBProgressHUD hideHUDForView:Callingview animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:Callingview animated:YES];
    }];
}
-(void)calllPostWeb2:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:Callingview animated:YES];
    HUD.labelText = @"loading";

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Dict %@",dict);
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]];
    NSLog(@"url = %@",urlStr);
    
    [manager POST:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [_PassReseposeDatadelegate passReseposeData1:responseObject];
        [MBProgressHUD hideHUDForView:Callingview animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:Callingview animated:YES];
        
    }];
    
    
}

-(void)calllPutWeb:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:Callingview animated:YES];
    HUD.labelText = @"loading";
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Dict %@",dict);
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    [manager PUT:[NSString stringWithFormat:@"%@users?api_key=%@",[ClsSetting tableURL],[ClsSetting apiKey]] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        NSError *error=nil;
        //NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        // NSError *error;
        //  NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        // NSLog(@"%@",responseStr);
        
        [_PassReseposeDatadelegate passReseposeData1:responseObject];
        [MBProgressHUD hideHUDForView:Callingview animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:Callingview animated:YES];
        
    }];
    
    
}




-(void)SendSMSOTP:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview
{
    @try {
        
        
       // MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:Callingview animated:YES];
        //HUD.labelText = @"loading";
        
        
        NSDictionary *Discparam=[[NSDictionary alloc]init];
        Discparam=dict;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@",strURL];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict1);
             
             [_PassReseposeDatadelegate passReseposeData1:responseObject];
             
            // [MBProgressHUD hideHUDForView:Callingview animated:YES];
             
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 
                // [MBProgressHUD hideHUDForView:Callingview animated:YES];
             }];
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
    }
}

+(NSMutableDictionary*)RemoveNull:(NSMutableDictionary*)dict
{
    NSArray*arrkeys=[dict allKeys];
    dict=[dict mutableCopy];
    for (int i=0; i<arrkeys.count;i++ )
    {
        if (([dict valueForKey:[arrkeys objectAtIndex:i]]== nil)||([dict valueForKey:[arrkeys objectAtIndex:i]]== [NSNull null]))
        {
           [dict setValue:@" " forKey:[arrkeys objectAtIndex:i]];
        }
        
        NSString *str=[NSString stringWithFormat:@"%@",[dict valueForKey:[arrkeys objectAtIndex:i]]];
        
        NSLog(@"%@",[dict valueForKey:[arrkeys objectAtIndex:i]]);
        if ([str intValue] == 0)
        {
           str = [str stringByReplacingOccurrencesOfString: @"<br>" withString: @"\n"];
             [dict setValue:str forKey:[arrkeys objectAtIndex:i]];
        }
    }
    return dict;
}

+(NSMutableDictionary*)RemoveNullOnly:(NSMutableDictionary*)dict
{
    NSArray*arrkeys=[dict allKeys];
    dict=[dict mutableCopy];
    for (int i=0; i<arrkeys.count;i++ )
    {
        if (([dict valueForKey:[arrkeys objectAtIndex:i]]== nil)||([dict valueForKey:[arrkeys objectAtIndex:i]]== [NSNull null]))
        {
            [dict setValue:@" " forKey:[arrkeys objectAtIndex:i]];
        }
    }
    return dict;
}

+(void)myAstaGuru:(UINavigationController*)NavigationController
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:USER_id] intValue]>0)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        AfterLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AfterLoginViewController"];
        [NavigationController pushViewController:rootViewController animated:YES];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        BforeLoginViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"BforeLoginViewController"];
        [NavigationController pushViewController:rootViewController animated:YES];
    }
}

+(void)Searchpage:(UINavigationController*)NavigationController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *VCLikesControll = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [NavigationController pushViewController:VCLikesControll animated:YES];
}

+(NSString*)getAttributedStringFormHtmlString:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location     != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}

-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location     != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}

//+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
//{
//    // iOS7
//    
//    CGSize sizeOfText = [aString boundingRectWithSize: aSize
//                                              options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                           attributes: [NSDictionary dictionaryWithObject:aFont
//                                                                                   forKey:NSFontAttributeName]
//                                              context: nil].size;
//    
//    return ceilf(sizeOfText.height);
//    
//    
//}
//

+(CGFloat)heightForNSString:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (text)
    {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    return size.height;
}

+(CGFloat)heightForNSAttributedString:(NSAttributedString*)astr havingWidth:(CGFloat)width
{
    CGRect rect = [astr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}


+(void)sendEmailWithInfo:(NSDictionary*)infoDic
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    NSLog(@"Dict %@",infoDic);
    [manager POST:[ClsSetting emailURL] parameters:infoDic success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+(void)ISUSerLeading:(NSString*)strUserID Cell:(CurrentDefultGridCollectionViewCell*)cell
{
    if (([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue]>0))
    {
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:USER_id] intValue] == [strUserID intValue])
        {
            [cell.btnLot setBackgroundImage:[UIImage imageNamed:@"img-lotno-bg2"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnLot setBackgroundImage:[UIImage imageNamed:@"img-lotno-bg1.png"] forState:UIControlStateNormal];
        }
    }
    
}

@end
