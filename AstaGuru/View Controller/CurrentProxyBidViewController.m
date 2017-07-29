//
//  CurrentProxyBidViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 6/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "CurrentProxyBidViewController.h"

@interface CurrentProxyBidViewController ()

@end

@implementation CurrentProxyBidViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:255.0f alpha:.5];
    [GlobalClass setBorder:self.contentView cornerRadius:8 borderWidth:1 color:[UIColor whiteColor]];
    [GlobalClass setBorder:self.lblLot cornerRadius:self.lblLot.frame.size.height/2 borderWidth:1 color:[UIColor whiteColor]];

    self.scrollKeyboard.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    //Confirm button tag.
    //Tag0 - If confirm button tag 0 then show confirm message and set confirm button tag 1 set the proxy bid view hidden Yes;
    //Tag1 - If confirm button tag 1 then get new bid price and check with current bid value. If bid value not changed then submit bid else set confirm button tag 2, set conform button title "Ok" and set the proxy bid view hidden Yes.
    //Tag2 - If confirm button tag 2 then set confirm button tag 1, set new bid price, set confirm button title "Confirm" and set the proxy bid view hidden No.
    //Tag3 - If confirm button tag 3 then call parrent vc delegate and remove from parrent vc.
    self.btnConfirm.tag = 0;
}

-(void)setCurrentAuction:(CurrentAuction *)currentAuction
{
    _currentAuction = currentAuction;
    self.lblLot.text = [NSString stringWithFormat:@"Lot:%@",currentAuction.strreference];
    [self setBidPrice];
}

-(void)setBidPrice
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        self.lblBidPrice.text = self.currentAuction.formatedNextValidBidPriceUS;
    }
    else
    {
        self.lblBidPrice.text = self.currentAuction.formatedNextValidBidPriceRS;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancelPressed:(UIButton *)sender
{
    [self.delegate didProxyBidCancel];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)btnConfirmPressed:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        if (self.txtProxyBid.text.length == 0 )
        {
            [GlobalClass showTost:@"Please enter proxy value."];
        }
        else if ([self isValidAmount])
        {
            sender.tag = 1;
            self.proxyBidView.hidden = YES;
            self.lblAlert.text=@"Once submitted can not be changes online";
        }
        else
        {
            if ([self.currentAuction.strnextpricers integerValue] < 10000000)
            {
                [GlobalClass showTost:@"Proxy Bid value must be greater by at least 10% of current price."];
            }
            else
            {
                [GlobalClass showTost:@"Proxy Bid value must be greater by at least 5% of current price."];
            }
        }
    }
    else if (sender.tag == 1)
    {
        [self getAuctionByID:self.currentAuction view:self.view auction:^(CurrentAuction *currentAuction){
            if ([self.currentAuction.strBidpricers intValue] < [currentAuction.strBidpricers intValue] )
            {
                self.btnConfirm.tag = 2;
                self.proxyBidView.hidden = YES;
                self.lblAlert.text = @"The bid value for this lot has change, update your bid?";
                [self.btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                //on ok pressed we set new bid price.
            }
            else
            {
                [self proxyBid];
            }
            self.currentAuction = currentAuction;
        }];
    }
    else if (sender.tag == 2)
    {
        self.btnConfirm.tag = 0;
        self.proxyBidView.hidden = NO;
        [self.btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
        
        [self setBidPrice];
    }
    else //if (sender.tag == 3)
    {
        [self.delegate didProxyBidCancel];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
//    else
//    {
//        [self.delegate didProxyBidCancel];
//        [self.view removeFromSuperview];
//        [self removeFromParentViewController];
//    }
}

-(void)proxyBid
{
    
    NSArray *imgNameArr = [self.currentAuction.strthumbnail componentsSeparatedByString:@"/"];
    NSString *imgName = [imgNameArr lastObject];
    NSString *proxyAmountRS;
    NSString *proxyAmountUS;
    CGFloat proxyAmount = [self.txtProxyBid.text floatValue];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        CGFloat proxyRate = proxyAmount*[self.currentAuction.strDollarRate floatValue];
        NSInteger result = (NSInteger)roundf(proxyRate);
        proxyAmountRS = [NSString stringWithFormat:@"%ld",(long)result];
        proxyAmountUS = self.txtProxyBid.text;
    }
    else
    {
        CGFloat proxyRate = proxyAmount*[self.currentAuction.strDollarRate floatValue];
        NSInteger result = (NSInteger)roundf(proxyRate);
        proxyAmountRS = self.txtProxyBid.text;
        proxyAmountUS = [NSString stringWithFormat:@"%ld",(long)result];
    }
    
    NSString *strUrl=[NSString stringWithFormat:@"spCurrentProxyBid(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)",proxyAmountRS, self.currentAuction.strproductid, [GlobalClass getUserID], self.currentAuction.strDollarRate, proxyAmountUS, imgName, self.currentAuction.strreference, self.currentAuction.strBidpricers, self.currentAuction.strBidpriceus, self.currentAuction.strOnline, self.currentAuction.strBidclosingtime, self.currentAuction.strFirstName, self.currentAuction.strLastName];
    
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         NSArray *statusArray = (NSArray*)responseObject;
         if (statusArray.count > 0)
         {
             NSDictionary *statusDic = [GlobalClass removeNullOnly:responseObject[0]];
             NSInteger currentStatus = [statusDic[@"currentStatus"] integerValue];
             if (currentStatus == 1)
             {
                 if ([statusDic[@"mobileNum"] length] > 0)
                 {
                     NSString *strMessage=[NSString stringWithFormat:@"Dear %@, please note you have been outbid on Lot No %@. Last bid was Rs %@($%@). Place renewed your bid on www.astaguru.com or mobile App.", statusDic[@"Username"], self.currentAuction.strreference, statusDic[@"outBidAmountRs"], statusDic[@"outBidAmountUs"]];
                     
                     NSDictionary *parameters = @{@"mobiles":statusDic[@"mobileNum"],
                                                  @"message":strMessage};
                     [GlobalClass sendSMS:parameters success:^(id responseObject){} failure:^(NSError *error){}];
                 }
                 if ([GlobalClass isValidEmail:statusDic[@"emailID"]])
                 {
                     NSInteger currentBidPriceRS = [statusDic[@"lastBidpriceRs"] integerValue];
                     NSInteger curentBidPriceUS = [statusDic[@"lastBidpriceUs"] integerValue];
                     NextBidPrice bidPrice = [GlobalClass getIncrementBidPriceRS:currentBidPriceRS BidPriceUS:curentBidPriceUS];
                     
                     NSString *subStr = [NSString stringWithFormat:@" AstaGuru - You have been Outbid on Lot No %@",self.currentAuction.strreference];
                     
                     NSString *strmsg =  [NSString stringWithFormat:@"Dear %@,\nWe would like to bring it to your notice that you have been outbid on Lot# %@, in the ongoing AstaGuru Online Auction. Your highest bid was on Rs.%@($%@). The current highest bid stands at Rs.%@ ($%@). Continue to contest for Lot# %@, Please place your updated bid.\n\nLot No : %@\nTitle : %@\nCurrent Highest Bid : Rs.%@($%@)\nNext Incremental Bid Amount : Rs.%ld($%ld)\n\nIn case you have any queries with regards to the Lots that are part of the auction or the bidding process, please feel free to contact us on 91-22 2204 8138/39 or write to us at contact@astaguru.com. Our team will be glad to assist you with the same.\n\nWarmest Regards,\nTeam AstaGuru.", statusDic[@"Username"], self.currentAuction.strreference, statusDic[@"outBidAmountRs"], statusDic[@"outBidAmountUs"], statusDic[@"lastBidpriceRs"], statusDic[@"lastBidpriceUs"], self.currentAuction.strreference, self.currentAuction.strreference, self.currentAuction.strtitle, statusDic[@"lastBidpriceRs"], statusDic[@"lastBidpriceUs"], (long)bidPrice.nextBidPriceRS, (long)bidPrice.nextBidPriceUS];
                     NSDictionary *dictMailParameters = @{
                                                          @"to":@[@{
                                                                      @"name":statusDic[@"Username"],
                                                                      @"email":statusDic[@"emailID"]
                                                                      }],
                                                          @"subject":subStr,
                                                          @"body_text": strmsg
                                                          };
                     
                     [GlobalClass sendEmail:dictMailParameters success:^(id responseObject)
                      {
                      }failure:^(NSError *error)
                      {
                      }];
                 }
                 
                 self.btnConfirm.tag = 3;
                 self.proxyBidView.hidden = YES;
                 self.lblAlert.text = @"Your proxy bid submitted successfully, You are currently the highest bidder on this lot";
                 [self.btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                 //on ok pressed we close proxy bid.
             }
             else if (currentStatus == 2)
             {
                 self.btnConfirm.tag = 2;
                 self.proxyBidView.hidden = YES;
                 self.lblAlert.text = @"Sorry! you are out off bid because already higher proxybid is there, do you want to bid again?";
                 [self.btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                 //on ok pressed we set new bid price.
             }
             else if (currentStatus == 3)
             {
                 self.btnConfirm.tag = 2;
                 self.proxyBidView.hidden = YES;
                 if ([self.currentAuction.strnextpricers integerValue] < 10000000)
                 {
                     self.lblAlert.text = @"Proxy Bid value must be greater by at least 10% of current price.";
                 }
                 else
                 {
                     self.lblAlert.text = @"Proxy Bid value must be greater by at least 5% of current price.";
                 }
                 //self.lblAlert.text=@"New proxy bid value must be greater than current proxy bid value.";
                 [self.btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                 //on ok pressed we set new bid price.
             }
             else
             {
                 [GlobalClass showTost:@"Sorry! Some thing went wrong."];
             }
         }
         else
         {
             [GlobalClass showTost:@"Sorry! Some thing went wrong."];
         }
         
     } failure:^(NSError *error){[GlobalClass showTost:error.localizedDescription];} callingCount:0];
}
-(BOOL)isValidAmount
{
    NSInteger proxyAmount = [self.txtProxyBid.text integerValue];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSD"])
    {
        if (proxyAmount >= [self.currentAuction.strnextpriceus integerValue])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        if (proxyAmount >= [self.currentAuction.strnextpricers integerValue])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
