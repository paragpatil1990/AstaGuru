//
//  AuctionItemBidViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 28/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AuctionItemBidViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ClsSetting.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import <sys/utsname.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CoreLocation/CoreLocation.h>
#import "ALNetwork.h"
#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface AuctionItemBidViewController ()<PassResepose, CLLocationManagerDelegate>
{
    NSString *strProxyPriceus;
    NSString *strProxyPricers;
//    NSString *strNextVAlidPriceus;
//    NSString *strNextVAlidPricers;
    NSString *strNextVAlidPriceus_send;
    NSString *strNextVAlidPricers_send;
    
    NSString *strNextIncrmentRS;
    NSString *strNextIncrmentUS;

    
//    int webservicecount;
    int proxyvalidation;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;

    NSString *cityName;
    NSString *thoroughfare;
    NSString *address;
    NSString *lat;
    NSString *lang;
    
    MBProgressHUD *HUDL;
}
@end

@implementation AuctionItemBidViewController

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    _viwContentview.layer.cornerRadius = 5;
    _viwContentview.layer.masksToBounds = YES;
    self.scrKeytboard.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [_btnLodId setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
    [_btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
    
    if (_isBidNow == YES)
    {
        _viwProxyBid.hidden=YES;
        _viwBidNow.hidden=NO;
    }
    else
    {
        _viwBidNow.hidden=YES;
        _viwProxyBid.hidden=NO;
    }
    
    if (_IsUpcoming == 1)
    {
        _lblbidtitle.text = @"Opening Bid"; //@"Start Price";
    }
    
    [self setPrice];//:_objCurrentOuction];
    
    cityName = @"";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self CurrentLocationIdentifier];
}

//------------ Current Location Address-----
-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    //------
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            [locationManager requestAlwaysAuthorization];
            [locationManager startUpdatingLocation];
        } break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Services Disabled" message:@"Please enable location services in settings" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            if (status == kCLAuthorizationStatusDenied)
            {
                UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                                 {
                                                     
//                                                     if ([CLLocationManager locationServicesEnabled])
//                                                     {
                                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                         
//                                                     }
//                                                     else
//                                                     {
//                                                         NSString* url = SYSTEM_VERSION_LESS_THAN(@"10.0") ? @"prefs:root=LOCATION_SERVICES" : @"App-Prefs:root=Privacy&path=LOCATION";
//                                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
//                                                     }
                                                 }];
                [alertController addAction:settingsAction];
            }
            else
            {
                UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alertController addAction:settingsAction];
                
            }
            
            
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            HUDL = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUDL.labelText = @"wait";
            [locationManager startUpdatingLocation]; 
        } break;
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    //[locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             NSLog(@"placemarks == %@",placemarks);
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//
//             NSLog(@"pm.thoroughfare = %@",placemark.thoroughfare);
//
//             NSLog(@"\nCurrent Location Detected\n");
//             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
//             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
//             NSString *Country = [[NSString alloc]initWithString:placemark.country];
//             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
//             NSLog(@"Address = %@ , CountryArea =  %@",Address, CountryArea);
             
             cityName = placemark.locality;
             thoroughfare = placemark.thoroughfare;
             address = Address;
             lat = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
             lang = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             //CountryArea = NULL;
         }
         
         if (HUDL != nil)
         {
             [HUDL hide:YES];
         }
         
         
         /*---- For more results
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
          ------*/
     }];
    

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (HUDL != nil)
    {
        [HUDL hide:YES];
    }
    [ClsSetting ValidationPromt:@"Location not found! Please try again."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtProxyBid resignFirstResponder];
}

-(BOOL)validation
{
    if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtProxyBid.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Please Enter Proxy Bid Value"];
        return FALSE;
    }
    else
    {
        BOOL result=[self validation1];
        if (result==false)
        {
            if ([_txtProxyBid.text intValue] >= 10000000)
            {
                [ClsSetting ValidationPromt:@"Proxy Bid value must be higher by at least 5% of current price"];
            }
            else
            {
                [ClsSetting ValidationPromt:@"Proxy Bid value must be higher by at least 10% of current price."];
                
            }
        }
        return result;
    }
    return TRUE;
}


- (IBAction)btnCancelPressed:(id)sender
{
    if((_isBidNow==FALSE)&&(proxyvalidation==2))
    {
        proxyvalidation=1;
        _viwProxyBidConfarmation.hidden=YES;
        _viwProxyBid.hidden=NO;
        _viwBidNow.hidden=YES;
        
    }
    else
    {
        [self.delegate cancelAuctionItemBidViewController];
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
}


- (IBAction)btnConfirmPressed:(id)sender
{
    

        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        // 3
        if ((status == kCLAuthorizationStatusDenied)  || (status == kCLAuthorizationStatusRestricted))
        {
            [self CurrentLocationIdentifier];
            return;
        }

    
    if(currentLocation == nil || [cityName isEqualToString:@""])
    {
        [self CurrentLocationIdentifier];
        [ClsSetting ValidationPromt:@"Location not found! Please try again."];
        return;
    }
    
    if (_isBidNow==1)
    {
        if (proxyvalidation==1)
        {
            proxyvalidation=0;
            _viwProxyBidConfarmation.hidden=YES;
            _viwBidNow.hidden=NO;
            _viwProxyBid.hidden=YES;
            [_btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
        }
        else if (proxyvalidation==2)
        {
            _viwProxyBidConfarmation.hidden=YES;
            _viwBidNow.hidden=NO;
            _viwProxyBid.hidden=YES;
            [_btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
            [self getOccttionData];
        }
        else
        {
            [self getOccttionData];
        }
    }
    else
    {
        if ([self validation ])
        {
            if (proxyvalidation==0)
            {
                proxyvalidation=1;
                _lblAlert.text=@"Once submitted can not be changed online. Confirm? ";
                _viwBidNow.hidden=YES;
                _viwProxyBid.hidden=YES;
                _viwProxyBidConfarmation.hidden=NO;
            }
            else if (proxyvalidation==2)
            {
                _viwBidNow.hidden=YES;
                _viwProxyBid.hidden=NO;
                _viwProxyBidConfarmation.hidden=YES;
                [self getOccttionData];
            }
            else
            {
                [self ProxyBid1];
            }
        }
    }
}


-(void)getOccttionData
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"defaultlots?api_key=%@&filter=productid=%@",[ClsSetting apiKey],_objCurrentOuction.strproductid] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    NSMutableArray  *arrItemCount=[parese parseSortCurrentAuction:[dict1 valueForKey:@"resource"]];
    if (arrItemCount.count>0)
    {
        clsCurrentOccution *objCurrentOuction1=[arrItemCount objectAtIndex:0];
        
        if (proxyvalidation==2)
        {
            _objCurrentOuction = objCurrentOuction1;
            [self setPrice];
//            [self setCurrenBidvalue];
            proxyvalidation = 0;
        }
        else
        {
            if ([objCurrentOuction1.strpricers intValue]>[_objCurrentOuction.strpricers intValue] )
            {
                _lblAlert.text=@"The bid value for this lot has change, update your bid?";
                [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                _viwProxyBidConfarmation.hidden=NO;
                _viwBidNow.hidden=YES;
                _viwProxyBid.hidden=YES;
                proxyvalidation=1;
                _objCurrentOuction=objCurrentOuction1;
                [self setPrice];
//                [self setCurrenBidvalue];
            }
            else
            {
                proxyvalidation=0;
                [self BidNow];
            }
        }
    }
}

-(void)calculateNextIncrementValueFromCurrentValueRS:(NSString*)currentValueRS currentValueUS:(NSString*)currentValueUS
{
    int price_rs = [currentValueRS intValue];
    int price_us = [currentValueUS intValue];
    
    if ([currentValueRS intValue] >= 10000000)
    {
        int priceIncreaserete_rs = (price_rs*5)/100;
        int FinalPrice_rs = price_rs + priceIncreaserete_rs;
        strNextIncrmentRS = [NSString stringWithFormat:@"%d",FinalPrice_rs];
        
        int priceIncreaserete_us = (price_us*5)/100;
        int FinalPrice_us = price_us + priceIncreaserete_us;
        strNextIncrmentUS = [NSString stringWithFormat:@"%d",FinalPrice_us];
    }
    else
    {
        int priceIncreaserete_rs = (price_rs*10)/100;
        int FinalPrice_rs = price_rs + priceIncreaserete_rs;
        strNextIncrmentRS = [NSString stringWithFormat:@"%d",FinalPrice_rs];

        
        int priceIncreaserete_us = (price_us*10)/100;
        int FinalPrice_us = price_us + priceIncreaserete_us;
        strNextIncrmentUS = [NSString stringWithFormat:@"%d",FinalPrice_us];
    }
}

-(void)BidNow
{
    NSString *str;
    NSString *strUserid;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
    {
        str=[[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
    }
    else
    {
        str=@"abhi123";
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_id] != nil)
    {
        strUserid=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
    }
    else
    {
        strUserid=@"1972";
    }
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        NSArray *imgNameArr = [_objCurrentOuction.strthumbnail componentsSeparatedByString:@"/"];
        NSString *imgName = [imgNameArr objectAtIndex:1];
        
//        bidByVal int,
//        @deviceTocken VARCHAR(255),
//        @OSversion VARCHAR(255),
//        @modelName VARCHAR(100),
//        @ipAddress VARCHAR(50),
//        @userLocation
        NSString *bidByVal = @"2";
//        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//        if (deviceToken == nil)
//        {
//            deviceToken = @"";
//        }
        NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
        float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
        NSString *OSversion = [NSString stringWithFormat:@"%.1f",ver];
        NSString *modelName = [self deviceName];
        NSString *ipAddress = [ALNetwork currentIPAddress]; //[self getIPAddress];
        
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@",/\`'"];

        //NSString *Address = [address stringByReplacingOccurrencesOfString:@"," withString:@" "];
        
        NSString *Address = [[address componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @" "];
        //[Address stringByReplacingOccurrencesOfString:@"/" withString:@" "];
        
        NSString *Area = [[thoroughfare componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @" "];
        
        //NSString *Area = [thoroughfare stringByReplacingOccurrencesOfString:@"," withString:@" "];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],strNextVAlidPricers_send,_objCurrentOuction.strproductid,strUserid,_objCurrentOuction.strDollarRate,strNextVAlidPriceus_send, imgName, _objCurrentOuction.strReference,_objCurrentOuction.strpricers, _objCurrentOuction.strpriceus,[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline], _objCurrentOuction.strBidclosingtime, _objCurrentOuction.strFirstName, _objCurrentOuction.strLastName, bidByVal, Identifier, OSversion, modelName, ipAddress, cityName, Address, Area, lat, lang, [ClsSetting apiKey]];
        
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSError *error;
             NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             NSLog(@"%@",responseStr);
             NSLog(@"%@",dict1);
             NSDictionary *dictResult=[dict1 objectAtIndex:0];
             NSString *currentStatus = [NSString stringWithFormat:@"%@",[dictResult valueForKey:@"currentStatus"]];
             if ([currentStatus isEqualToString:@"1"])
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:@"Your bid submitted successfully, currently you are leading for this product"];
                 
                 NSDictionary *dict=[[NSMutableDictionary alloc]init];
                 ClsSetting *objSetting=[[ClsSetting alloc]init];
                 
                 NSString *strMessage=[NSString stringWithFormat:@"Dear %@, please note you have been outbid on Lot No %@. Last bid was Rs %@($%@). Place renewed your bid on www.astaguru.com or mobile App.",dictResult[@"Username"],_objCurrentOuction.strReference,dictResult[@"BidAmountRs"],dictResult[@"BidAmountUs"]];
                 
                 [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://gateway.netspaceindia.com/api/sendhttp.php?authkey=131841Aotn6vhT583570b5&mobiles=%@&message=%@&sender=AstGru&route=4&country=91",[dictResult valueForKey:@"mobileNum"],strMessage] view:self.view];
                 
                 
                 if ([ClsSetting NSStringIsValidEmail:[dictResult valueForKey:@"emailID"]])
                 {
                     [self calculateNextIncrementValueFromCurrentValueRS:strNextVAlidPricers_send currentValueUS:strNextVAlidPriceus_send];

                     NSString *subStr = [NSString stringWithFormat:@" AstaGuru - You have been Outbid on Lot No %@",_objCurrentOuction.strReference];
                     
                     NSString *strmsg =  [NSString stringWithFormat:@"Dear %@,\nWe would like to bring it to your notice that you have been outbid on Lot# %@, in the ongoing AstaGuru Online Auction. Your highest bid was on Rs.%@($%@). The current highest bid stands at Rs.%@($%@). Continue to contest for Lot# %@, Please place your updated bid.\n\nLot No : %@\nTitle : %@\nCurrent Highest Bid : Rs.%@($%@)\nNext Incremental Bid Amount : Rs.%@($%@)\n\nIn case you have any queries with regards to the Lots that are part of the auction or the bidding process, please feel free to contact us on 91-22 2204 8138/39 or write to us at contact@astaguru.com. Our team will be glad to assist you with the same.\n\nWarmest Regards,\nTeam AstaGuru.",dictResult[@"Username"], _objCurrentOuction.strReference,dictResult[@"BidAmountRs"],dictResult[@"BidAmountUs"], strNextVAlidPricers_send, strNextVAlidPriceus_send, _objCurrentOuction.strReference, _objCurrentOuction.strReference, _objCurrentOuction.strtitle, strNextVAlidPricers_send, strNextVAlidPriceus_send, strNextIncrmentRS, strNextIncrmentUS];
                     
                     [self SendEmailWithSubject:subStr message:strmsg email:[dictResult valueForKey:@"emailID"] name:dictResult[@"Username"]];
                 }

                 [self.delegate refreshBidPrice];
                 
                 [self.view removeFromSuperview];
                 [self removeFromParentViewController];
                 
             }
             else if ([currentStatus isEqualToString:@"3"])
             {
                 
                 [ClsSetting ValidationPromt:[NSString stringWithFormat:@"%@",[dictResult valueForKey:@"msg"]]];
                 
                 [self.delegate refreshBidPrice];

                 [self.view removeFromSuperview];
                 [self removeFromParentViewController];
                 
             }
             else
             {
                 _lblAlert.text=@"Sorry you have been out bid because of a higher value proxy bid. Would you like to place another bid.";
                 [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                 _viwProxyBidConfarmation.hidden=NO;
                 _viwBidNow.hidden=YES;
                 _viwProxyBid.hidden=YES;
                 proxyvalidation=2;
             }
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:error.localizedDescription];
             }];
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}

-(void)ProxyBid1
{
    if (![self validation1])
    {
        if ([_txtProxyBid.text intValue] >= 10000000)
        {
            [ClsSetting ValidationPromt:@"Proxy Bid value must be higher by at least 5% of current price"];
        }
        else
        {
            [ClsSetting ValidationPromt:@"Proxy Bid value must be higher by at least 10% of current price."];
        }
    }
    else
    {
        NSString *createdBy;
        NSString *strUserid;
        if([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] != nil)
        {
            createdBy = [[NSUserDefaults standardUserDefaults]valueForKey:USER_NAME];
        }
        else
        {
            createdBy = @"abhi123";
        }
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:USER_id] != nil)
        {
            strUserid=[[NSUserDefaults standardUserDefaults]valueForKey:USER_id];
        }
        else
        {
            strUserid=@"1972";
        }
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
        {
            float iproxy = [_txtProxyBid.text floatValue]*[_objCurrentOuction.strDollarRate floatValue];
            int result = (int)roundf(iproxy);
            strProxyPricers = [NSString stringWithFormat:@"%d",result];
            strProxyPriceus = _txtProxyBid.text;
        }
        else
        {
            float iproxy = [_txtProxyBid.text floatValue]/[_objCurrentOuction.strDollarRate floatValue];
            int result = (int)roundf(iproxy);
            strProxyPricers = _txtProxyBid.text;
            strProxyPriceus = [NSString stringWithFormat:@"%d",result];
        }
        
        
        if (_IsUpcoming == 1)
        {
            @try
            {
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"loading";
                NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                
                NSString *bidByVal = @"2";
                
//                NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//                if (deviceToken == nil)
//                {
//                    deviceToken = @"";
//                }
                
                NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
                float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
                
                NSString *OSversion = [NSString stringWithFormat:@"%.1f",ver];
                NSString *modelName = [self deviceName];
                NSString *ipAddress = [ALNetwork currentIPAddress];//[self getIPAddress];
                NSString *Address = [address stringByReplacingOccurrencesOfString:@"," withString:@" "];
                Address = [Address stringByReplacingOccurrencesOfString:@"/" withString:@" "];
                NSString *Area = [thoroughfare stringByReplacingOccurrencesOfString:@"," withString:@" "];
                NSString *strQuery=[NSString stringWithFormat:@"%@/spUpcomingProxyBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL], strUserid, _objCurrentOuction.strproductid, strProxyPricers, strProxyPriceus, createdBy,[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline], bidByVal, Identifier, OSversion, modelName, ipAddress, cityName, Address, Area, lat, lang,[ClsSetting apiKey]];
                
                NSString *url = strQuery;
                NSLog(@"%@",url);
                NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     NSError *error;
                     NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                     //                     NSLog(@"%@",responseStr);
                     NSLog(@"%@",dict1);
                     if (dict1.count>0)
                     {
                         NSDictionary *dictResult= [ClsSetting RemoveNull:[dict1 objectAtIndex:0]];
                         
                         if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"1"])
                         {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             
                             [ClsSetting ValidationPromt:[NSString stringWithFormat:@"%@",[dictResult valueForKey:@"msg"]]];
                             
                             NSMutableDictionary *dictUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                             
                             NSString *subStr = [NSString stringWithFormat:@"AstaGuru - Proxy Bid acknowledgement"];
                             
                             NSString *strname = [NSString stringWithFormat:@"%@ %@",dictUser[@"name"], dictUser[@"lastname"]];
                             
                             
                             NSString *strmsg =  [NSString stringWithFormat:@"Dear %@,\nThank you for placing a Proxy Bid amount of Rs.%@($%@) for Lot No %@ part of our '%@' Auction dated %@.\n\nWe would like to acknowledge having received your Proxy Bid, our operations team will review it and revert with confirmation of the approval.\n\nIn case you are unaware of this transaction please notify us at the earliest about the misrepresentation.\n\nIn case you would like to edit the Proxy Bid value please contact us for the same at contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you.",strname, strProxyPricers, strProxyPriceus, _objCurrentOuction.strReference, [ClsSetting getStringFormHtmlString:_objCurrentOuction.strAuctionname], [dictResult valueForKey:@"auctionDate"]];
                             
                             [self SendEmailWithSubject:subStr message:strmsg email:[ClsSetting TrimWhiteSpaceAndNewLine:dictUser[@"email"]] name:strname];
                         }
                         else if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"0"])
                         {
                             [ClsSetting ValidationPromt:[NSString stringWithFormat:@"%@",[dictResult valueForKey:@"msg"]]];
                         }
                         else
                         {
                             [ClsSetting ValidationPromt:@"This may be a server issue"];
                         }
                         [self.view removeFromSuperview];
                         [self removeFromParentViewController];
                     }
                 }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"Error: %@", error);
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [ClsSetting ValidationPromt:error.localizedDescription];
                     }];
            }
            @catch (NSException *exception)
            {
                
            }
            @finally
            {
            }
        }
        else
        {
            @try
            {
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"loading";
                NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                NSArray *imgNameArr = [_objCurrentOuction.strthumbnail componentsSeparatedByString:@"/"];
                NSString *imgName = [imgNameArr objectAtIndex:1];
                
                NSString *bidByVal = @"2";
                
//                NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//                if (deviceToken == nil)
//                {
//                    deviceToken = @"";
//                }
                
                NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
                
                float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
                
                NSString *OSversion = [NSString stringWithFormat:@"%.1f",ver];
                NSString *modelName = [self deviceName];
                NSString *ipAddress = [ALNetwork currentIPAddress];// [self getIPAddress];
                NSString *Address = [address stringByReplacingOccurrencesOfString:@"," withString:@" "];
                Address = [Address stringByReplacingOccurrencesOfString:@"/" withString:@" "];
                NSString *Area = [thoroughfare stringByReplacingOccurrencesOfString:@"," withString:@" "];
                NSString *strQuery=[NSString stringWithFormat:@"%@/spCurrentProxyBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],strProxyPricers,_objCurrentOuction.strproductid,strUserid,_objCurrentOuction.strDollarRate,strProxyPriceus,imgName,_objCurrentOuction.strReference,_objCurrentOuction.strpricers,_objCurrentOuction.strpriceus,[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline],_objCurrentOuction.strBidclosingtime,_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName, bidByVal, Identifier, OSversion, modelName, ipAddress, cityName, Address, Area, lat, lang, [ClsSetting apiKey]];
                
                NSString *url = strQuery;
                NSLog(@"%@",url);
                NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     //  NSError *error=nil;
                     NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     NSError *error;
                     NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                     NSLog(@"%@",responseStr);
                     NSLog(@"%@",dict1);
                     if (dict1.count>0)
                     {
                         NSDictionary *dictResult= [ClsSetting RemoveNull:[dict1 objectAtIndex:0]];
                         
                         if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"1"])
                         {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [ClsSetting ValidationPromt:@"Your Proxy bid has been submitted successfully,you are currently leading. "];
                             
                             [self.delegate refreshBidPrice];

                             
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                             
                             
                             NSDictionary *dict=[[NSMutableDictionary alloc]init];
                             ClsSetting *objSetting=[[ClsSetting alloc]init];
                             
                             NSString *strMessage=[NSString stringWithFormat:@"Dear %@, please note you have been outbid on Lot No %@. Last bid was Rs %@($%@). Place renewed your bid on www.astaguru.com or mobile App.",dictResult[@"Username"],_objCurrentOuction.strReference,dictResult[@"outBidAmountRs"],dictResult[@"outBidAmountUs"]];
                             
                             [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://gateway.netspaceindia.com/api/sendhttp.php?authkey=131841Aotn6vhT583570b5&mobiles=%@&message=%@&sender=AstGru&route=4&country=91",[dictResult valueForKey:@"mobileNum"],strMessage] view:self.view];
                             
                             if ([ClsSetting NSStringIsValidEmail:[dictResult valueForKey:@"emailID"]])
                             {
                                
                                 [self calculateNextIncrementValueFromCurrentValueRS:dictResult[@"lastBidpriceRs"] currentValueUS:dictResult[@"lastBidpriceUs"]];
                                 
                                 NSString *subStr = [NSString stringWithFormat:@" AstaGuru - You have been Outbid on Lot No %@",_objCurrentOuction.strReference];
                                 
                                 NSString *strmsg =  [NSString stringWithFormat:@"Dear %@,\nWe would like to bring it to your notice that you have been outbid on Lot# %@, in the ongoing AstaGuru Online Auction. Your highest bid was on Rs.%@($%@). The current highest bid stands at Rs.%@ ($%@). Continue to contest for Lot# %@, Please place your updated bid.\n\nLot No : %@\nTitle : %@\nCurrent Highest Bid : Rs.%@($%@)\nNext Incremental Bid Amount : Rs.%@($%@)\n\nIn case you have any queries with regards to the Lots that are part of the auction or the bidding process, please feel free to contact us on 91-22 2204 8138/39 or write to us at contact@astaguru.com. Our team will be glad to assist you with the same.\n\nWarmest Regards,\nTeam AstaGuru.", dictResult[@"Username"], _objCurrentOuction.strReference, dictResult[@"outBidAmountRs"], dictResult[@"outBidAmountUs"], dictResult[@"lastBidpriceRs"], dictResult[@"lastBidpriceUs"], _objCurrentOuction.strReference, _objCurrentOuction.strReference, _objCurrentOuction.strtitle, dictResult[@"lastBidpriceRs"], dictResult[@"lastBidpriceUs"], strNextIncrmentRS, strNextIncrmentUS];

                                 [self SendEmailWithSubject:subStr message:strmsg email:[dictResult valueForKey:@"emailID"] name:dictResult[@"Username"]];
                             }
                             
                         }
                         else if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"2"])
                         {
                             _lblAlert.text=@"Sorry You are out off bid because already higher proxybid is their, do you want to bid again";
                             [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                             _viwProxyBidConfarmation.hidden=NO;
                             _viwBidNow.hidden=YES;
                             _viwProxyBid.hidden=YES;
                             proxyvalidation=2;
                             
                         }
                         else if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"3"])
                         {
                             _lblAlert.text=@"New Proxy Bid Value Should Be Greater Then Current Proxy Bid Value.";
                             [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                             _viwProxyBidConfarmation.hidden=NO;
                             _viwBidNow.hidden=YES;
                             _viwProxyBid.hidden=YES;
                             proxyvalidation=2;
                         }
                         else
                         {
                             _lblAlert.text=@"Sorry, Try again";
                             [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                             _viwProxyBidConfarmation.hidden=NO;
                             _viwBidNow.hidden=YES;
                             _viwProxyBid.hidden=YES;
                             proxyvalidation=2;
                             
                         }
                     }
                     else
                     {
                         [ClsSetting ValidationPromt:@"This may be a server issue"];
                     }
                 }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"Error: %@", error);
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [ClsSetting ValidationPromt:error.localizedDescription];
                     }];
            }
            @catch (NSException *exception)
            {
                
            }
            @finally
            {
            }
        }
    }
}

-(void)SendEmailWithSubject:(NSString*)substr message:(NSString*)strmsg email:(NSString*)email name:(NSString*)name
{
    NSDictionary *dictTo = @{
                             @"name":name,
                             @"email":email
                             };
    
    NSArray*arrTo=[[NSArray alloc]initWithObjects:dictTo, nil];
    NSDictionary *dictMail = @{
                               @"template":@"newsletter",
                               @"to":arrTo,
                               @"subject":substr,
                               @"body_text": strmsg,
                               @"from_name":@"AstaGuru",
                               @"from_email":@"info@infomanav.com",
                               @"reply_to_name":@"AstaGuru",
                               @"reply_to_email":@"info@infomanav.com",
                               };
    [ClsSetting sendEmailWithInfo:dictMail];
}


-(void)passReseposeData1:(id)str
{
    if (_isBidNow==1)
    {
        [ClsSetting ValidationPromt:@"Your bid has been submitted successfully,you are currently leading."];
    }
    else
    {
        [ClsSetting ValidationPromt:@"Your Proxy bid submitted successfully,currently you are leading for this product"];
    }
    
    [self.delegate refreshBidPrice];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.placeholder = @" Enter your value";
}

-(void)setPrice
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:0];
    if ([_objCurrentOuction.strpricers intValue] >= 10000000)
    {
        int price_us = [_objCurrentOuction.strpriceus intValue];
        int priceIncreaserete_us = (price_us*5)/100;
        int FinalPrice_us = price_us + priceIncreaserete_us;
        strNextVAlidPriceus_send = [NSString stringWithFormat:@"%d",FinalPrice_us];
        
        int price_rs = [_objCurrentOuction.strpricers intValue];
        int priceIncreaserete_rs = (price_rs*5)/100;
        int FinalPrice_rs = price_rs + priceIncreaserete_rs;
        strNextVAlidPricers_send = [NSString stringWithFormat:@"%d",FinalPrice_rs];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
        {
            numberFormatter.currencyCode = @"USD";
            if (_IsUpcoming == 1)
            {
                NSString *bidValue = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price_us]];
                _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",bidValue];
            }
            else
            {
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_us]];
                _lblBeadValue.text = [NSString stringWithFormat:@"%@",strNextValidBuild];
                _lblCurrentBidValue.text = [NSString stringWithFormat:@"%@",strNextValidBuild];
            }
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
            
            if (_IsUpcoming == 1)
            {
                NSString *bidValue = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price_rs]];
                _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",bidValue];
            }
            else
            {
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_rs]];
                _lblBeadValue.text = [NSString stringWithFormat:@"%@",strNextValidBuild];
                _lblCurrentBidValue.text = [NSString stringWithFormat:@"%@",strNextValidBuild];
            }
        }
    }
    else
    {
        int price_us = [_objCurrentOuction.strpriceus intValue];
        int priceIncreaserete_us = (price_us*10)/100;
        int FinalPrice_us = price_us + priceIncreaserete_us;
        strNextVAlidPriceus_send = [NSString stringWithFormat:@"%d",FinalPrice_us];
        
        int price_rs = [_objCurrentOuction.strpricers intValue];
        int priceIncreaserete_rs = (price_rs*10)/100;
        int FinalPrice_rs = price_rs + priceIncreaserete_rs;
        strNextVAlidPricers_send = [NSString stringWithFormat:@"%d",FinalPrice_rs];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
        {
            numberFormatter.currencyCode = @"USD";
            
            if (_IsUpcoming == 1)
            {
                NSString *bidValue = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price_us]];
                _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",bidValue];
            }
            else
            {
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_us]];
                _lblBeadValue.text=[NSString stringWithFormat:@"%@", strNextValidBuild];
                _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@", strNextValidBuild];
            }
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
            if (_IsUpcoming == 1)
            {
                NSString *bidValue = [numberFormatter stringFromNumber:[NSNumber numberWithInt:price_rs]];
                _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",bidValue];
            }
            else
            {
                NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_rs]];;
                _lblBeadValue.text=[NSString stringWithFormat:@"%@", strNextValidBuild];
                _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@", strNextValidBuild];
            }
        }
    }
}

//-(void)setCurrenBidvalue
//{
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
//    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
//    [numberFormatter setMaximumFractionDigits:0];
//    if ([_objCurrentOuction.strpricers intValue] >= 10000000)
//    {
//        int price_us = [_objCurrentOuction.strpriceus intValue];
//        int priceIncreaserete_us = (price_us*5)/100;
//        int FinalPrice_us = price_us + priceIncreaserete_us;
//        strNextVAlidPriceus_send=[NSString stringWithFormat:@"%d",FinalPrice_us];
//        
//        int price_rs = [_objCurrentOuction.strpricers intValue];
//        int priceIncreaserete_rs = (price_rs*5)/100;
//        int FinalPrice_rs = price_rs + priceIncreaserete_rs;
//        strNextVAlidPricers_send=[NSString stringWithFormat:@"%d",FinalPrice_rs];
//
//        if (_iscurrencyInDollar==1)
//        {
//            numberFormatter.currencyCode = @"USD";
//
//            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_us]];
//            
//            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//        }
//        else
//        {
//            numberFormatter.currencyCode = @"INR";
//
//            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_rs]];
//            
//            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//        }
//    }
//    else
//    {
//        int price_us = [_objCurrentOuction.strpriceus intValue];
//        int priceIncreaserete_us = (price_us*10)/100;
//        int FinalPrice_us = price_us+priceIncreaserete_us;
//        strNextVAlidPriceus_send = [NSString stringWithFormat:@"%d",FinalPrice_us];
//        
//        int price_rs = [_objCurrentOuction.strpricers intValue];
//        int priceIncreaserete_rs = (price_rs*10)/100;
//        int FinalPrice_rs = price_rs + priceIncreaserete_rs;
//        strNextVAlidPricers_send=[NSString stringWithFormat:@"%d",FinalPrice_rs];
//
//        if (_iscurrencyInDollar==1)
//        {
//            numberFormatter.currencyCode = @"USD";
//            
//            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_us]];
//
//            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//        }
//        else
//        {
//            numberFormatter.currencyCode = @"INR";
//
//            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice_rs]];
//
//            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
//        }
//    }
//}

-(BOOL)validation1
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        if ([strNextVAlidPriceus_send intValue] <= [_txtProxyBid.text intValue])
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        if ([strNextVAlidPricers_send intValue] <= [_txtProxyBid.text intValue])
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    return true;
}

-(void)SendSMSOTP:(NSDictionary*)dict url:(NSString*)strURL view:(UIView*)Callingview
{
    @try {
  
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
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
             }];
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}

- (NSString*) deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      : @"Simulator",
                              @"x86_64"    : @"Simulator",
                              @"iPod1,1"   : @"iPod Touch",        // (Original)
                              @"iPod2,1"   : @"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   : @"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   : @"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   : @"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" : @"iPhone",            // (Original)
                              @"iPhone1,2" : @"iPhone",            // (3G)
                              @"iPhone2,1" : @"iPhone",            // (3GS)
                              @"iPad1,1"   : @"iPad",              // (Original)
                              @"iPad2,1"   : @"iPad 2",            //
                              @"iPad3,1"   : @"iPad",              // (3rd Generation)
                              @"iPhone3,1" : @"iPhone 4",          // (GSM)
                              @"iPhone3,3" : @"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" : @"iPhone 4S",         //
                              @"iPhone5,1" : @"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" : @"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   : @"iPad",              // (4th Generation)
                              @"iPad2,5"   : @"iPad Mini",         // (Original)
                              @"iPhone5,3" : @"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" : @"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" : @"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" : @"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" : @"iPhone 6 Plus",     //
                              @"iPhone7,2" : @"iPhone 6",          //
                              @"iPhone8,1" : @"iPhone 6S",         //
                              @"iPhone8,2" : @"iPhone 6S Plus",    //
                              @"iPhone8,4" : @"iPhone SE",         //
                              @"iPhone9,1" : @"iPhone 7",          //
                              @"iPhone9,3" : @"iPhone 7",          //
                              @"iPhone9,2" : @"iPhone 7 Plus",     //
                              @"iPhone9,4" : @"iPhone 7 Plus",     //
                              @"iPhone10,1": @"iPhone 8",          // CDMA
                              @"iPhone10,4": @"iPhone 8",          // GSM
                              @"iPhone10,2": @"iPhone 8 Plus",     // CDMA
                              @"iPhone10,5": @"iPhone 8 Plus",     // GSM
                              @"iPhone10,3": @"iPhone X",          // CDMA
                              @"iPhone10,6": @"iPhone X",          // GSM
                              
                              @"iPad4,1"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   : @"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   : @"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   : @"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   : @"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   : @"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}

- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end
