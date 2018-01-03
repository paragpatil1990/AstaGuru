//
//  ForGotViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "ForGotViewController.h"
#import "SWRevealViewController.h"
#import "ClsSetting.h"
@interface ForGotViewController ()<PassResepose>

@end

@implementation ForGotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
     _scrScreollviw.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _viwInnerview.layer.cornerRadius = _viwInnerview.frame.size.width/2;
    _viwInnerview.clipsToBounds = YES;
    // Do any additional setup after loading the view.
}
-(void)setUpNavigationItem
{
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    self.title=@"Forgot Password";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.revealViewController setFrontViewController:self.navigationController];
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    
    
    //self.navigationItem.title=@"Sign Up";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"WorkSans-Medium" size:17]}];
    
    
}
-(void)searchPressed
{
    
}
-(void)myastaguru
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)closePressed
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
        [ClsSetting ValidationPromt:@"Please enter your email"];
    }
    else{
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"users/?api_key=%@&filter=email=%@",[ClsSetting apiKey],[ClsSetting TrimWhiteSpaceAndNewLine:_email_TextField.text]] view:self.view Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
}

-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    NSMutableArray *arr1=[dict1 valueForKey:@"resource"];
    if (arr1.count>0)
    {
        NSMutableDictionary *dict=[arr1 objectAtIndex:0];
        if ([[dict valueForKey:@"email"] isEqualToString:[ClsSetting TrimWhiteSpaceAndNewLine:_email_TextField.text]])
        {
//            [ClsSetting ValidationPromt:@"Login Successfully"];
            NSString *email = [dict valueForKey:@"email"];
            NSLog(@"email == %@",email);
            NSString *password = [dict valueForKey:@"password"];
            NSLog(@"password == %@",password);
            NSString *name = [dict valueForKey:@"name"];
            NSLog(@"name == %@",name);
            NSString *username = [dict valueForKey:@"username"];
            [self SendEmail:email password:password username:username name:name];
        }
        else
        {
            [ClsSetting ValidationPromt:@"Enter valid email"];
        }
    }
    else
    {
        [ClsSetting ValidationPromt:@"The email address entered by you was not present in our database. Please check the email address"];
    }
    
}
-(void)SendEmail:(NSString*)email password:(NSString*)password username:(NSString*)username name:(NSString*)name
{
    NSDictionary *dictTo = @{
                             @"name":name,
                             @"email":email,
                             };
    NSArray*arrTo=[[NSArray alloc]initWithObjects:dictTo, nil];
    // NSDictionary *dictMail=[[NSDictionary alloc]init];
    NSDictionary *dictMail = @{
                               @"template":@"newsletter",
                               @"to":arrTo,
                               @"subject":@"Astaguru Password",
                               @"body_text":[NSString stringWithFormat:@"Hi %@ \n Your Astaguru Login Credentials are, \n Username:%@ \n Password:%@",name,username ,password],
                               @"from_name":@"AstaGuru",
                               @"from_email":@"info@infomanav.com",
                               @"reply_to_name":@"AstaGuru",
                               @"reply_to_email":@"info@infomanav.com",
                               
                               };
    [ClsSetting sendEmailWithInfo:dictMail];

    [ClsSetting ValidationPromt:@"Email is sent to your register mail ID,Please check your mail box."];
}

@end
