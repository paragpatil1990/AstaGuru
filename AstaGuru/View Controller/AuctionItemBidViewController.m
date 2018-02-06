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
@interface AuctionItemBidViewController ()<PassResepose>
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
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],strNextVAlidPricers_send,_objCurrentOuction.strproductid,strUserid,_objCurrentOuction.strDollarRate,strNextVAlidPriceus_send, imgName, _objCurrentOuction.strReference,_objCurrentOuction.strpricers, _objCurrentOuction.strpriceus,[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline], _objCurrentOuction.strBidclosingtime, _objCurrentOuction.strFirstName, _objCurrentOuction.strLastName,[ClsSetting apiKey]];
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
                
                NSString *strQuery=[NSString stringWithFormat:@"%@/spUpcomingProxyBid(%@,%@,%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL], strUserid, _objCurrentOuction.strproductid, strProxyPricers, strProxyPriceus, createdBy,[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline],[ClsSetting apiKey]];
                
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
                             
                             
                             NSString *strmsg =  [NSString stringWithFormat:@"Dear %@,\nThank you for placing a Proxy Bid amount of Rs.%@($%@) for Lot No %@ part of our '%@' Auction dated %@.\n\nWe would like to acknowledge having received your Proxy Bid, our operations team will review it and revert with confirmation of the approval.\n\nIn case you are unaware of this transaction please notify us at the earliest about the misrepresentation.\n\nIn case you would like to edit the Proxy Bid value please contact us for the same at contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you.",strname, strProxyPricers, strProxyPriceus, _objCurrentOuction.strReference, [ClsSetting getAttributedStringFormHtmlString:_objCurrentOuction.strAuctionname], [dictResult valueForKey:@"auctionDate"]];
                             
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
                
                NSString *strQuery=[NSString stringWithFormat:@"%@/spCurrentProxyBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=%@",[ClsSetting procedureURL],strProxyPricers,_objCurrentOuction.strproductid,strUserid,_objCurrentOuction.strDollarRate,strProxyPriceus,imgName,_objCurrentOuction.strReference,_objCurrentOuction.strpricers,_objCurrentOuction.strpriceus,[ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline],_objCurrentOuction.strBidclosingtime,_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName,[ClsSetting apiKey]];
                
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
@end
