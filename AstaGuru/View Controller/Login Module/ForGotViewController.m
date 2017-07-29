//
//  ForGotViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ForGotViewController.h"
#import "SWRevealViewController.h"
#import "GlobalClass.h"

@interface ForGotViewController ()

@end

@implementation ForGotViewController

-(void)setUpNavigationItem
{
    self.navigationItem.title = @"My AstaGuru";

   // [self.navigationItem setHidesBackButton:YES];
    
   // [self setNavigationBarCloseButton];//Target:self selector:@selector(closePressed)];

    
//    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
//    self.sidebarButton.tintColor=[UIColor whiteColor];
//    self.title=@"Forgot Password";
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    [self.revealViewController setFrontViewController:self.navigationController];
//    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    
    
    //self.navigationItem.title=@"Sign Up";
//    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
//    self.sideleftbarButton.tintColor=[UIColor whiteColor];
//    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor],
//       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];

}

-(void)closePressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    [self setUpNavigationItem];
    
     _scrScreollviw.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [GlobalClass setBorder:_viwInnerview cornerRadius:_viwInnerview.frame.size.width/2 borderWidth:1 color:[UIColor clearColor]];
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

- (IBAction)sendPassword_BtnClick:(UIButton *)sender
{
    if (_email_TextField.text.length == 0)
    {
        [GlobalClass showTost:@"Please enter your email"];
    }
    else if (![GlobalClass isValidEmail:_email_TextField.text])
    {
        [GlobalClass showTost:@"Please enter valid email-id"];
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"users/?api_key=%@&filter=email=%@", [GlobalClass apiKey], [GlobalClass trimWhiteSpaceAndNewLine:_email_TextField.text]];
        
        [GlobalClass call_tableGETWebURL:url parameters:nil view:self.view success:^(id responseObject)
         {
             NSMutableArray *resourceArray = responseObject[@"resource"];
             if (resourceArray.count > 0)
             {
                 NSDictionary *userDict = [GlobalClass removeNullOnly:[resourceArray objectAtIndex:0]];
                 NSLog(@"userDict = %@",userDict);
                 NSString *email = [userDict valueForKey:@"email"];
                 if ([[GlobalClass trimWhiteSpaceAndNewLine:email] isEqualToString:[GlobalClass trimWhiteSpaceAndNewLine:_email_TextField.text]])
                 {
                     NSString *password = [userDict valueForKey:@"password"];
                     NSString *name = [NSString stringWithFormat:@"%@ %@",[userDict valueForKey:@"name"], [userDict valueForKey:@"lastname"]];
                     NSString *username = [userDict valueForKey:@"username"];
                     [self sendEmail:email password:password username:username name:name];
                 }
                 else
                 {
                     [GlobalClass showTost:@"Enter valid email"];
                 }
             }
             else
             {
                 [GlobalClass showTost:@"The email address entered by you was not present in our database. Please check the email address"];
             }
         }failure:^(NSError *error)
         {
             [GlobalClass showTost:error.localizedDescription];
         } callingCount:0];

//        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//        ClsSetting *objSetting=[[ClsSetting alloc]init];
//        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=%@&filter=email=%@",[ClsSetting apiKey],[ClsSetting TrimWhiteSpaceAndNewLine:_email_TextField.text]] view:self.view Post:NO];
//        objSetting.PassReseposeDatadelegate=self;
    }
}

//-(void)passReseposeData:(id)arr
//{
//    //  NSMutableArray *arrOccution=[parese parseCurrentOccution:[arr valueForKey:@"resource"]];
//    NSError *error;
//    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
//    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
//    if (arr1.count>0)
//    {
//        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
//        if ([[dict valueForKey:@"email"] isEqualToString:[ClsSetting TrimWhiteSpaceAndNewLine:_email_TextField.text]])
//        {
////            [ClsSetting ValidationPromt:@"Login Successfully"];
//            NSString *email = [dict valueForKey:@"email"];
//            NSLog(@"email == %@",email);
//            NSString *password = [dict valueForKey:@"password"];
//            NSLog(@"password == %@",password);
//            NSString *name = [dict valueForKey:@"name"];
//            NSLog(@"name == %@",name);
//            NSString *username = [dict valueForKey:@"username"];
//            [self SendEmail:email password:password username:username name:name];
//        }
//        else
//        {
//            [ClsSetting ValidationPromt:@"Enter valid email"];
//        }
//    }
//    else
//    {
//        [ClsSetting ValidationPromt:@"The email address entered by you was not present in our database. Please check the email address"];
//    }
//    
//}

-(void)sendEmail:(NSString*)email password:(NSString*)password username:(NSString*)username name:(NSString*)name
{
    NSDictionary *dictMailParameters = @{
                                         @"to":@[@{
                                                     @"name":name,
                                                     @"email":email,
                                                     }],
                                         @"subject":@"Warm Greetings from AstaGuru Online Auction House.",
                                         @"body_text": [NSString stringWithFormat:@"Dear %@,\n\nYour AstaGuru login credentials are,\nUsername : %@\nPassword : %@\n\nFor any further assistance please feel free to write to us at, contact@astaguru.com or call us on 91-22 2204 8138/39. We will be glad to assist you.\n\nWarm Regards,\nTeam AstaGuru\n",name, username, password]
                                         };
    
    [GlobalClass sendEmail:dictMailParameters success:^(id responseObject)
     {
         [GlobalClass showTost:@"Email is sent to your register mail ID, Please check your mail box."];
     }failure:^(NSError *error)
     {
     }];
}

@end
