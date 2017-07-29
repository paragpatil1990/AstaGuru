//
//  UpcommingProxyBidViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 7/1/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "UpcommingProxyBidViewController.h"

@interface UpcommingProxyBidViewController ()

@end

@implementation UpcommingProxyBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:255.0f alpha:.5];
    [GlobalClass setBorder:self.contentView cornerRadius:8 borderWidth:1 color:[UIColor whiteColor]];
    [GlobalClass setBorder:self.lblLot cornerRadius:self.lblLot.frame.size.height/2 borderWidth:1 color:[UIColor whiteColor]];

    self.scrollKeyboard.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    
    //Confirm button tag.
    //Tag0 - If confirm button tag 0 then show confirm message and set confirm button tag 1 set the proxy bid view hidden Yes;
    //Tag1 - If confirm button tag 1 then submit bid.
    //Tag2 - If confirm button tag 2 then call parrent vc delegate and remove from parrent vc.
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
        self.lblBidPrice.text = self.currentAuction.formatedCurrentBidPriceUS;
    }
    else
    {
        self.lblBidPrice.text = self.currentAuction.formatedCurrentBidPriceRS;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancelPressed:(UIButton *)sender
{
    [self.delegate didUpcommingProxyBidCancel];
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
                [GlobalClass showTost:@"Proxy Bid value must be greater by at least 10% of current price"];
            }
            else
            {
                [GlobalClass showTost:@"Proxy Bid value must be greater by at least 5% of current price"];
            }
        }
    }
    else if (sender.tag == 1)
    {
        [self upcommingProxyBid];
    }
    else //if (sender.tag == 2)
    {
        //on ok pressed we close proxy bid.
        [self.delegate didUpcommingProxyBidCancel];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
//    else
//    {
//        //on ok pressed we close proxy bid.
//
//        [self.delegate didUpcommingProxyBidCancel];
//        [self.view removeFromSuperview];
//        [self removeFromParentViewController];
//    }
}

-(void)upcommingProxyBid
{
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
    
    NSString *strUrl = [NSString stringWithFormat:@"spUpcomingProxyBid(%@,%@,%@,%@,%@,%@)",[GlobalClass getUserID], self.currentAuction.strproductid,  proxyAmountRS, proxyAmountUS, [GlobalClass getName], self.currentAuction.strOnline];
    
    [GlobalClass call_procGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         NSArray *statusArray = (NSArray*)responseObject;
         if (statusArray.count > 0)
         {
             NSDictionary *statusDic = [GlobalClass removeNullOnly:responseObject[0]];
             NSInteger currentStatus = [statusDic[@"currentStatus"] integerValue];
             if (currentStatus == 1)
             {
                 if ([GlobalClass isValidEmail:statusDic[@"email"]])
                 {
                     NSMutableDictionary *dictUser = [[NSUserDefaults standardUserDefaults] objectForKey:USER];
                     
                     NSString *strname = [NSString stringWithFormat:@"%@ %@",dictUser[@"name"], dictUser[@"lastname"]];
                     
                     NSString *subStr = [NSString stringWithFormat:@"AstaGuru - Proxy Bid acknowledgement"];
                     
                     NSString *strmsg =  [NSString stringWithFormat:@"Dear %@,\nThank you for placing a Proxy Bid amount of Rs.%@($%@) for Lot No %@ part of our '%@' Auction dated %@.\n\nWe would like to acknowledge having received your Proxy Bid, our operations team will review it and revert with confirmation of the approval.\n\nIn case you are unaware of this transaction please notify us at the earliest about the misrepresentation.\n\nIn case you would like to edit the Proxy Bid value please contact us for the same at contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you.",strname, proxyAmountRS, proxyAmountUS, self.currentAuction.strreference, [GlobalClass convertHTMLTextToPlainText:self.currentAuction.strAuctionname], statusDic[@"auctionDate"]];
                     
                     NSDictionary *dictMailParameters = @{@"to":@[@{@"name":strname,
                                                                    @"email":statusDic[@"email"]}],
                                                          @"subject":subStr,
                                                          @"body_text": strmsg
                                                          };
                     
                     [GlobalClass sendEmail:dictMailParameters success:^(id responseObject)
                      {
                      }failure:^(NSError *error)
                      {
                      }];
                 }
                 
                 self.btnConfirm.tag = 2;
                 self.proxyBidView.hidden = YES;
                 self.lblAlert.text = statusDic[@"msg"];
                 [self.btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                 //on ok pressed we close proxy bid.
             }
             else if (currentStatus == 0)
             {
                 self.btnConfirm.tag = 2;
                 self.proxyBidView.hidden = YES;
                 self.lblAlert.text = statusDic[@"msg"];
                 [self.btnConfirm setTitle:@"Ok" forState:UIControlStateNormal];
                 //on ok pressed we close proxy bid.
             }
             else
             {
                 [GlobalClass showTost:@"Some thing went wrong."];
                 [self.view removeFromSuperview];
                 [self removeFromParentViewController];
             }
         }
         else
         {
             [GlobalClass showTost:@"Some thing went wrong."];
         }
         
     } failure:^(NSError *error){
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
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
