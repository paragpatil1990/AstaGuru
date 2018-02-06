//
//  GetInTouchViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 21/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "GetInTouchViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "DropDownListView.h"
#import "ClsSetting.h"
#import <MessageUI/MessageUI.h>
@interface GetInTouchViewController ()<kDropDownListViewDelegate,PassResepose,MFMailComposeViewControllerDelegate>
{
    DropDownListView * Dropobj;
    NSMutableArray *arrCategory;
}
@end

@implementation GetInTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Contact Us";
    arrCategory=[[NSMutableArray alloc]init];
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect frame= _segmentedmenu.frame;
        [_segmentedmenu setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 50)];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,nil];
        
        
        [_segmentedmenu setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        
        
    }
    else
    {
        
        
        //CGRect frame= _segmentedmenu.frame;
        //[_segmentedmenu setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30)];
    }
    
    _segmentedmenu.layer.borderWidth = 1.0;
    _segmentedmenu.layer.cornerRadius=3.0;
    _segmentedmenu.layer.borderColor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0].CGColor;
   
    [self getCategoryData];
    [self setBroder];
    // Do any additional setup after loading the view.
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];

    [ClsSetting SetBorder:_name_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_email_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_phone_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_category_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_message_view cornerRadius:2 borderWidth:1 color:bColor];
    
}

-(void)getCategoryData
{
     NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"category?api_key=%@",[ClsSetting apiKey]] view:self.view Post:NO];
    
}
-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    // arrItemCount=[parese parsePastOccution:[dict1 valueForKey:@"resource"]];
    arrItemCount=[dict1 valueForKey:@"resource"];
    
    [arrCategory addObjectsFromArray:arrItemCount];
   
}
-(void)closePressed
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    _segmentedmenu.selectedSegmentIndex=1;
    for (int i=0; i<[_segmentedmenu.subviews count]; i++)
    {
        UIColor *tintcolor = [UIColor colorWithRed:150/255.0 green:122/255.0 blue:85/255.0 alpha:1.0];
        if ([[_segmentedmenu.subviews objectAtIndex:i]isSelected])
        {
            
            [[_segmentedmenu.subviews objectAtIndex:i] setTintColor:tintcolor];
            
        }
        else
        {
            [[_segmentedmenu.subviews objectAtIndex:i] setTintColor:[UIColor whiteColor]];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        tintcolor,NSForegroundColorAttributeName,nil];
            [_segmentedmenu setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
    }
    
    
    //_scrContact.contentSize=CGSizeMake(self.view.frame.size.width, _viwmap.frame.size.height+ _viwmap.frame.origin.y+30);
    //_viwcontentview.frame=CGRectMake(_viwcontentview.frame.origin.x, _viwcontentview.frame.origin.y, self.view.frame.size.width, _scrContact.contentSize.height);
}
    // Do any additional setup after loading the view.

- (IBAction)segmentedPressed:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (sender.selectedSegmentIndex==1)
    {
        
    }
}


- (IBAction)getintouch:(id)sender
{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Categories" withOption:arrCategory xy:CGPointMake(((SCREEN_WIDTH/2) - (287/2)), 130) size:CGSizeMake(287, SCREEN_HEIGHT/1.8) isMultiple:NO ];
}

#pragma mark - on btn click show drop down menu
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    NSString *parsekey;
   
        parsekey = @"category";
   
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple parseKey:parsekey];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown1_R:150.0 G:122.0 B:85.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
   
   
    NSDictionary *dict=[arrCategory objectAtIndex:anIndex];
    ;
    _txtCategory.text=[dict valueForKey:@"category"];
    
        
   
    
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    /*
     //----------------Get Selected Value[Multiple selection]-----------------
     if (ArryData.count>0) {
     _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
     CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
     _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
     }
     else{
     _lblSelectedCountryNames.text=@"";
     }
     */
}
- (void)DropDownListViewDidCancel
{
    
}

- (IBAction)btnSubmit:(id)sender
{
    if (_txtname.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Name"];
    }
    else if (_txtEmail.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Email Id"];
    }
    else if (![ClsSetting NSStringIsValidEmail:_txtEmail.text])
    {
        [ClsSetting ValidationPromt:@"Enter Valid Emaild Id"];
    }
    else if (_txtPhone.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Number"];
    }
    else if (_txtCategory.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Select category"];
    }
    else if (_txtMessage.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Message"];
    }
    else
    {
        MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
        [composer setMailComposeDelegate:self];
        
        if ([MFMailComposeViewController canSendMail])
        {
            [composer setToRecipients:[NSArray arrayWithObjects:@"contact@astaguru.com", nil]];
            [composer setSubject:[NSString stringWithFormat:@"Get in touch:"]];
            
            //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
            NSString *message=[NSString stringWithFormat:@"Hello AstaGuru Team,\n Name: %@\n EmailID: %@\n Phone: %@\n Category: %@\n Message: %@ ",[ClsSetting TrimWhiteSpaceAndNewLine:_txtname.text ],[ClsSetting TrimWhiteSpaceAndNewLine:_txtEmail.text ],[ClsSetting TrimWhiteSpaceAndNewLine:_txtPhone.text ],[ClsSetting TrimWhiteSpaceAndNewLine:_txtCategory.text ],[ClsSetting TrimWhiteSpaceAndNewLine:_txtMessage.text ]];
            
            [composer setMessageBody:message isHTML:NO];
            [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:composer animated:YES completion:nil];
        }
        else {
        }
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
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
