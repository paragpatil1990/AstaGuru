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
@interface AuctionItemBidViewController ()<PassResepose>
{
    NSString *strProxyPriceus;
    NSString *strProxyPricers;
    NSString *strNextVAlidPriceus;
    NSString *strNextVAlidPricers;
    int webservicecount;
    int proxyvalidation;
}
@end

@implementation AuctionItemBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viwContentview.layer.cornerRadius = 5;
    _viwContentview.layer.masksToBounds = YES;
    self.scrKeytboard.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [_btnLodId setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
      [_btnLot setTitle:[NSString stringWithFormat:@"Lot:%@",_objCurrentOuction.strReference] forState:UIControlStateNormal];
    proxyvalidation=1;
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
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
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
        [self getOccttionData];
     
    }
    else
    {
        
        if ([self validation ])
        {
            if (proxyvalidation==1)
            {
                proxyvalidation=2;
                _viwBidNow.hidden=YES;
                _viwProxyBid.hidden=YES;
                _viwProxyBidConfarmation.hidden=NO;
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
    else if ([_txtProxyBid.text intValue]<[_lblBeadValue.text intValue])
    {
        [ClsSetting ValidationPromt:@"Proxy bid value is always greater then current bid"];
        return FALSE;
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
        if ([[dict valueForKey:@"AuctionId"] intValue]==27)
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
           // [ClsSetting ValidationPromt:@"You are outoff bid please"];
            
            if ([objCurrentOuction1.strpricers intValue]>[_objCurrentOuction.strpricers intValue] )
            {
                [ClsSetting ValidationPromt:@"You are outoff bid, please verify next bid value"];
                _objCurrentOuction=objCurrentOuction1;
                [self setCurrenBidvalue];
            }
            else
            {
                [self BidNow];
            }
        }
        NSLog(@"%@",dict1);
    
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
   
    NSDictionary *params = @{
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
    
    NSDictionary *pardsams = @{@"resource": arr};
    
    
    
    ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPostWeb:pardsams url:[NSString stringWithFormat:@"%@bidrecord?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[objClssetting Url],str] view:self.view];
}

-(void)ProxyBid1
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
    
    NSDictionary *params = @{
                             @"AuctionId":@"27",
                             @"ProxyAmt":strProxyPricers,
                             @"ProxyAmtus":strProxyPriceus,
                             @"Createdby":str,
                             @"CreatedDt":@"",
                             @"Status":@"True",
                             @"userid":strUserid,
                             @"ConfirmedBy":@"",
                             @"ConfirmedDt":@"",
                             @"productid":_objCurrentOuction.strproductid,
                             };
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:params,nil];
    
    NSDictionary *pardsams = @{@"resource": arr};
    
    NSLog(@"%@",pardsams);
    
    ClsSetting *objClssetting=[[ClsSetting alloc] init];
    // objClssetting.PassReseposeDatadelegate=self;
    objClssetting.PassReseposeDatadelegate=self;
    [objClssetting calllPostWeb:pardsams url:[NSString stringWithFormat:@"%@ProxyAuctionDetails?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed&filter=username=%@",[objClssetting Url],str] view:self.view];
}


-(void)passReseposeData1:(id)str
{
    if (_isBidNow==1)
    {
        [ClsSetting ValidationPromt:@"Your bid submitted successfully"];
    }
    else
    {
        [ClsSetting ValidationPromt:@"Your proxy bid submitted successfully"];
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
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
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
}
@end
