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
    NSString *strNextVAlidPriceus;
    NSString *strNextVAlidPricers;
    NSString *strdollarRate;
    
    int webservicecount;
    int proxyvalidation;
}
@end

@implementation AuctionItemBidViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viwContentview.layer.cornerRadius = 5;
    _viwContentview.layer.masksToBounds = YES;
    self.scrKeytboard.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [_btnLodId setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
      [_btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
    if (_IsSort==1)
    {
        strdollarRate=[[NSUserDefaults standardUserDefaults]valueForKey:@"DollarRate"];
    }
    else
    {
    strdollarRate=_objCurrentOuction.strDollarRate;
    }
    
   
    //proxyvalidation=1;
    if (_isBidNow==YES)
    {
        _viwProxyBid.hidden=YES;
        _viwBidNow.hidden=NO;
        
    }
    else
    {
        _viwBidNow.hidden=YES;
         _viwProxyBid.hidden=NO;
    }
    
   /* NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    int price =[_objCurrentOuction.strpricers intValue];
    int priceIncreaserete=(price*10)/100;
    
    strNextVAlidPricers=[NSString stringWithFormat:@"%d",price+priceIncreaserete];
    
    int price1 =[_objCurrentOuction.strpriceus intValue];
    int priceIncreaserete1=(price1*10)/100;
    
    int FinalPrice=price1+priceIncreaserete1;
    strNextVAlidPriceus=[NSString stringWithFormat:@"%d",FinalPrice];
    if (_iscurrencyInDollar==1)
    {
        numberFormatter.currencyCode = @"USD";
        NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
        
        
       
        
        int price =[_objCurrentOuction.strpriceus intValue];
        int priceIncreaserete=(price*10)/100;
        
        int FinalPrice=price+priceIncreaserete;
        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
        _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
      
       
    }
    else
    {
        numberFormatter.currencyCode = @"INR";
        NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
        
        
       
        
        int price =[_objCurrentOuction.strpricers intValue];
        int priceIncreaserete=(price*10)/100;
        
        int FinalPrice=price+priceIncreaserete;
        NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];;
        _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
    }
    */
    [self setPrice:_objCurrentOuction];
    // Do any additional setup after loading the view.
}

-(void)setPrice:(clsCurrentOccution*)objCurrentAuction
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:0];
    int price =[objCurrentAuction.strpricers intValue];
    int priceIncreaserete=(price*10)/100;
    
    strNextVAlidPricers=[NSString stringWithFormat:@"%d",price+priceIncreaserete];
    
    int price1 =[objCurrentAuction.strpriceus intValue];
    int priceIncreaserete1=(price1*10)/100;
    
    int FinalPrice=price1+priceIncreaserete1;
    strNextVAlidPriceus=[NSString stringWithFormat:@"%d",FinalPrice];
    if ([objCurrentAuction.strpricers intValue] > 10000000) // 10000000
    {
        if (_iscurrencyInDollar==1)
        {
            numberFormatter.currencyCode = @"USD";
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentAuction.strpriceus];
            
            int price =[objCurrentAuction.strpriceus intValue];
            int priceIncreaserete=(price*5)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            
            
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentAuction.strpricers];

            int price =[objCurrentAuction.strpricers intValue];
            int priceIncreaserete=(price*5)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];;
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        }
    }
    else{
        if (_iscurrencyInDollar==1)
        {
            numberFormatter.currencyCode = @"USD";
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentAuction.strpriceus];
            
            int price =[objCurrentAuction.strpriceus intValue];
            int priceIncreaserete=(price*10)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            
            
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:objCurrentAuction.strpricers];
            int price =[objCurrentAuction.strpricers intValue];
            int priceIncreaserete=(price*10)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];;
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        }
    }

    // Do any additional setup after loading the view.

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtProxyBid resignFirstResponder];
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
                _lblAlert.text=@"Once submitted can not be changes online ";
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
            
          [self ProxyBid];
                
            }
        }
    
    }
    
    
}
-(BOOL)validation
{
    if ([ClsSetting TrimWhiteSpaceAndNewLine:_txtProxyBid.text].length==0)
    {
        [ClsSetting ValidationPromt:@"Please enter proxy value"];
        return FALSE;
    }
    else //if ([_txtProxyBid.text intValue]<[_lblBeadValue.text intValue])
    {
        //[ClsSetting ValidationPromt:@"Proxy bid value is always greater then current bid"];
        BOOL result=[self validation1];
        if (result==false)
        {
            [ClsSetting ValidationPromt:@"Proxy bid value is always greater then current bid"];
        }
        
        return result;
    }
     return TRUE;
}
-(void)ProxyBid
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    webservicecount=1;
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"AuctionList?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}
-(void)passReseposeData:(id)arr
{
    if (webservicecount==1)
    {
        
    
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    arrItemCount=[dict1 valueForKey:@"resource"];
    for (int i=0; i<arrItemCount.count; i++)
    {
        NSDictionary *dict=[arrItemCount objectAtIndex:i];
        if ([[dict valueForKey:@"AuctionId"] intValue]==[[[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentAuctionID"] intValue])
        {
            if (_iscurrencyInDollar)
            {
                int iproxy=([_txtProxyBid.text intValue]*[[dict valueForKey:@"DollarRate"] intValue]);
                strProxyPricers=[NSString stringWithFormat:@"%d",iproxy];
                strProxyPriceus=_txtProxyBid.text;
            }
            else
            {
                int iproxy=([_txtProxyBid.text intValue]/[[dict valueForKey:@"DollarRate"] intValue]);
                strProxyPricers=_txtProxyBid.text;
                strProxyPriceus=[NSString stringWithFormat:@"%d",iproxy];
            }
            
        }
    }
    
[self ProxyBid1];
    }
    else
    {
        
        NSError *error;
        NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
        NSMutableArray  *arrItemCount=[parese parseCurrentOccution:[dict1 valueForKey:@"resource"]];
        if (arrItemCount.count>0)
        {
            clsCurrentOccution * objCurrentOuction1=[arrItemCount objectAtIndex:0];
        
        if (proxyvalidation==2)
        {
            
            _objCurrentOuction=objCurrentOuction1;
            [self setCurrenBidvalue];
             proxyvalidation=0;
            
        }
        else
        {
        
        
           // [ClsSetting ValidationPromt:@"You are outoff bid please"];
            
            if ([objCurrentOuction1.strpricers intValue]>[_objCurrentOuction.strpricers intValue] )
            {
                //[ClsSetting ValidationPromt:@"You are outoff bid, please verify next bid value"];
                _lblAlert.text=@"The bid value for this lot has change, update your bid?";
                [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                _viwProxyBidConfarmation.hidden=NO;
                _viwBidNow.hidden=YES;
                _viwProxyBid.hidden=YES;
                proxyvalidation=1;
                _objCurrentOuction=objCurrentOuction1;
                [self setCurrenBidvalue];
            }
            else
            {
                proxyvalidation=0;
                [self BidNow];
            }
        }
        NSLog(@"%@",dict1);
    
    }
    }
}
-(void)BidNow
{
NSLog(@"%@", [NSUserDefaults standardUserDefaults]);
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
   
    /*NSDictionary *params = @{
                             @"AuctionId":@"27",
                             @"Bidpricers":strNextVAlidPricers,
                             @"Bidpriceus":strNextVAlidPriceus,
                             @"Firstname":_objCurrentOuction.strFirstName,
                             @"Lastname":_objCurrentOuction.strLastName,
                             @"Reference":_objCurrentOuction.strReference,
                             @"Thumbnail":_objCurrentOuction.strthumbnail,
                             @"UserId":strUserid,
                             @"Username":str,
                             @"anoname":@"sfsfsd",
                             @"currentbid":@"0",
                             @"daterec":@"",
                             @"earlyproxy":@"",
                             @"productid":_objCurrentOuction.strproductid,
                             @"proxy":@"",
                             @"recentbid":@"",
                             @"validbidpricers":@"",
                             @"validbidpriceus":@"",
                            
                             };
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
    
    NSDictionary *pardsams = @{@"resource": arr};*/
    
    
    
    /*ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPostWeb:pardsams url:[NSString stringWithFormat:@"%@bidrecord?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[objClssetting Url],str] view:self.view];*/
    
   
    @try {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"loading";
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        ClsSetting *objsetting=[[ClsSetting alloc]init];
        
        NSArray *imgNameArr = [_objCurrentOuction.strthumbnail componentsSeparatedByString:@"/"];
        NSString *imgName = [imgNameArr objectAtIndex:1];
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting UrlProcedure],strNextVAlidPricers,_objCurrentOuction.strproductid,strUserid,strdollarRate,strNextVAlidPriceus,imgName,_objCurrentOuction.strReference,_objCurrentOuction.strpricers,_objCurrentOuction.strpriceus,_objCurrentOuction.strOnline,_objCurrentOuction.strBidclosingtime,_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
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
             if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"1"])
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [ClsSetting ValidationPromt:@"Your bid submitted successfully, currently you are leading for this product"];
                 
                 NSDictionary *dict=[[NSMutableDictionary alloc]init];
                 ClsSetting *objSetting=[[ClsSetting alloc]init];
                 NSString *strMessage=[NSString stringWithFormat:@"Dear User, please note you have been outbid on Lot No %@. Last bid was Rs %@ ($%@). Place your renewed bid on www.astaguru.com or mobile App.",_objCurrentOuction.strReference,strNextVAlidPricers,strNextVAlidPriceus];
                 
                 [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://gateway.netspaceindia.com/api/sendhttp.php?authkey=131841Aotn6vhT583570b5&mobiles=%@&message=%@&sender=AstGru&route=4&country=91",[dictResult valueForKey:@"mobilrNum"],strMessage] view:self.view];
               
                 [self.delegate refreshData];
                 [self.view removeFromSuperview];
                 [self removeFromParentViewController];
                 
             }
            else if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"3"])
             {
                 
                 [ClsSetting ValidationPromt:[NSString stringWithFormat:@"%@",[dictResult valueForKey:@"msg"]]];
                 
                 [self.view removeFromSuperview];
                 [self removeFromParentViewController];
                 
             }
             else
             {
                 //[ClsSetting ValidationPromt:@"Sorry You are out off bid because already higher proxybid is their, do y"];
                 _lblAlert.text=@"Sorry You are out off bid because already higher proxybid is their, do you want to bid again";
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

//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
//                 if ([operation.response statusCode]==404)
//                 {
//                     [ClsSetting ValidationPromt:@"No Record Found"];
//                     
//                 }
//                 else
//                 {
//                     [ClsSetting internetConnectionPromt];
//                     
//                 }
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
        [ClsSetting ValidationPromt:@"Proxy bid is always greater that next valid build"];
    }
    else
    {
        NSLog(@"%@", [NSUserDefaults standardUserDefaults]);
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
        
        if (_IsUpcoming == 1)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"MM/dd/yyyy hh:mm:ss a"]; //01/20/2017 09:55:15 AM
            NSString *dtstr = [dateFormat stringFromDate:[NSDate date]];
            NSDictionary *params = @{
                                     @"Userid":strUserid,
                                     @"Productid":_objCurrentOuction.strproductid,
                                     @"ProxyAmt":strProxyPricers,
                                     @"ProxyAmtus":strProxyPriceus,
                                     @"Status":@"0",
                                     @"Auctionid":_Auction_id,
                                     @"Createdby":[[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] valueForKey:@"name"],
                                     @"CreatedDt":dtstr
                                     };
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
            
            NSDictionary *pardsams = @{@"resource": arr};
            
            NSLog(@"%@",pardsams);
            
            ClsSetting *objClssetting=[[ClsSetting alloc] init];
            // objClssetting.PassReseposeDatadelegate=self;
            objClssetting.PassReseposeDatadelegate=self;
            [objClssetting calllPostWeb:pardsams url:[NSString stringWithFormat:@"%@ProxyAuctionDetails?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[objClssetting Url],str] view:self.view];
        }
        else
        {
            @try
            {
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"loading";
                NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
                // [Discparam setValue:@"cr2016" forKey:@"validate"];
                //[Discparam setValue:@"banner" forKey:@"action"];
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                ClsSetting *objsetting=[[ClsSetting alloc]init];
                NSArray *imgNameArr = [_objCurrentOuction.strthumbnail componentsSeparatedByString:@"/"];
                NSString *imgName = [imgNameArr objectAtIndex:1];
                
                NSString *strQuery=[NSString stringWithFormat:@"%@/spCurrentProxyBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting UrlProcedure],strProxyPricers,_objCurrentOuction.strproductid,strUserid,strdollarRate,strProxyPriceus,imgName,_objCurrentOuction.strReference,_objCurrentOuction.strpricers,_objCurrentOuction.strpriceus,_objCurrentOuction.strOnline,_objCurrentOuction.strBidclosingtime,_objCurrentOuction.strFirstName,_objCurrentOuction.strLastName];
                
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
                         NSDictionary *dictResult=[dict1 objectAtIndex:0];
                         
                         if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"1"])
                         {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [ClsSetting ValidationPromt:@"Your Proxy bid submitted successfully,currently you are leading for this product"];
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                             NSDictionary *dict=[[NSMutableDictionary alloc]init];
                             ClsSetting *objSetting=[[ClsSetting alloc]init];
                             NSString *strMessage=[NSString stringWithFormat:@"Dear User, please note you have been outbid on Lot No %@. Last bid was Rs %@ ($%@). Place your renewed bid on www.astaguru.com or mobile App.",_objCurrentOuction.strReference,strNextVAlidPricers,strNextVAlidPriceus];
                             
                             [objSetting SendSMSOTP:dict url:[NSString stringWithFormat:@"http://gateway.netspaceindia.com/api/sendhttp.php?authkey=131841Aotn6vhT583570b5&mobiles=%@&message=%@&sender=AstGru&route=4&country=91",[dictResult valueForKey:@"mobileNum"],strMessage] view:self.view];
                             
                         }
                         else if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"2"])
                         {
                             //[ClsSetting ValidationPromt:@"Sorry You are out off bid because already higher proxybid is their, do y"];
                             _lblAlert.text=@"Sorry You are out off bid because already higher proxybid is their, do you want to bid again";
                             [_btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                             _viwProxyBidConfarmation.hidden=NO;
                             _viwBidNow.hidden=YES;
                             _viwProxyBid.hidden=YES;
                             proxyvalidation=2;
                             
                         }
                         else if ([[dictResult valueForKey:@"currentStatus"] isEqualToString:@"3"])
                         {
                             //[ClsSetting ValidationPromt:@"Sorry You are out off bid because already higher proxybid is their, do y"];
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
                         [ClsSetting ValidationPromt:@"Something went rong"];
                     }
                 }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"Error: %@", error);
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [ClsSetting ValidationPromt:error.localizedDescription];

//                         if ([operation.response statusCode]==404)
//                         {
//                             [ClsSetting ValidationPromt:@"No Record Found"];
//                             
//                         }
//                         else
//                         {
//                             [ClsSetting internetConnectionPromt];
//                             
//                         }
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


-(void)passReseposeData1:(id)str
{
    if (_isBidNow==1)
    {
        [ClsSetting ValidationPromt:@"Your bid submitted successfully"];
    }
    else
    {
        [ClsSetting ValidationPromt:@"Your Proxy bid submitted successfully,currently you are leading for this product"];
    }
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.placeholder = @" Enter your value";
}
-(void)getOccttionData
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    webservicecount=2;
http://54.169.222.181/api/v2/guru/_table/Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&limit=10&offset=21&related=*&filter=online=27
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"Acution?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=productid=%@",_objCurrentOuction.strproductid] view:self.view Post:NO];
    objSetting.PassReseposeDatadelegate=self;
}

-(void)setCurrenBidvalue
{
    if ([_objCurrentOuction.strpricers intValue] > 10000000) // 10000000
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        int price =[_objCurrentOuction.strpriceus intValue];
        int priceIncreaserete=(price*5)/100;
        
        strNextVAlidPriceus=[NSString stringWithFormat:@"%d",price+priceIncreaserete];
        
        int price1 =[_objCurrentOuction.strpricers intValue];
        int priceIncreaserete1=(price1*5)/100;
        
        int FinalPrice=price1+priceIncreaserete1;
        strNextVAlidPricers=[NSString stringWithFormat:@"%d",FinalPrice];
        if (_iscurrencyInDollar==1)
        {
            numberFormatter.currencyCode = @"USD";
            [numberFormatter setMaximumFractionDigits:0];
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
            int price =[_objCurrentOuction.strpriceus intValue];
            int priceIncreaserete=(price*5)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
            [numberFormatter setMaximumFractionDigits:0];
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
            int price =[_objCurrentOuction.strpricers intValue];
            int priceIncreaserete=(price*5)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];;
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        }

    }
    else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        int price =[_objCurrentOuction.strpriceus intValue];
        int priceIncreaserete=(price*10)/100;
        
        strNextVAlidPriceus=[NSString stringWithFormat:@"%d",price+priceIncreaserete];
        
        int price1 =[_objCurrentOuction.strpricers intValue];
        int priceIncreaserete1=(price1*10)/100;
        
        int FinalPrice=price1+priceIncreaserete1;
        strNextVAlidPricers=[NSString stringWithFormat:@"%d",FinalPrice];
        if (_iscurrencyInDollar==1)
        {
            numberFormatter.currencyCode = @"USD";
            [numberFormatter setMaximumFractionDigits:0];
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpriceus];
            int price =[_objCurrentOuction.strpriceus intValue];
            int priceIncreaserete=(price*10)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        }
        else
        {
            numberFormatter.currencyCode = @"INR";
            [numberFormatter setMaximumFractionDigits:0];
//            NSString *strCurrentBuild = [numberFormatter stringFromNumber:_objCurrentOuction.strpricers];
            int price =[_objCurrentOuction.strpricers intValue];
            int priceIncreaserete=(price*10)/100;
            
            int FinalPrice=price+priceIncreaserete;
            NSString *strNextValidBuild = [numberFormatter stringFromNumber:[NSNumber numberWithInt:FinalPrice]];;
            _lblBeadValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
            _lblCurrentBidValue.text=[NSString stringWithFormat:@"%@",strNextValidBuild];
        }
    }
}
-(BOOL)validation1
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        if ([strNextVAlidPriceus intValue] < [_txtProxyBid.text intValue])
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
       
        
        if ([strNextVAlidPricers intValue] < [_txtProxyBid.text intValue])
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
-(void)smsforOutOffBidPerson
{

}
-(void)EmailforOutOffBidPerson
{
    
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
             
            
             
             //[MBProgressHUD hideHUDForView:self.view animated:YES];
             
             
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
@end
