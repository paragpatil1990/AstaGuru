//
//  HowToSellViewController.m
//  AstaGuru
//
//  Created by Amrit Singh on 1/30/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import "HowToSellViewController.h"
#import "DropDownListView.h"
#import "ClsSetting.h"

@interface HowToSellViewController ()<kDropDownListViewDelegate,UIDocumentPickerDelegate>
{
    DropDownListView * Dropobj;
    NSString *strPath;
}


@end

@implementation HowToSellViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//self.navigationController.navigationBar.backItem.title = @"Back";
    
    [self setNavigationBarBackButton];
    [self setBroder];
}

-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
 //   [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
 //   [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
  //  [_backButton setTitle:@"Back" forState:UIControlStateNormal];
   // [[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
  //  [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.topItem.title = @"Back";
    self.navigationItem.title=[NSString stringWithFormat:@"How To Sell"];
    
    _arrSelectSource = @[@{@"source":@"News Paper"}, @{@"source":@"Social Media"}, @{@"source":@"Social Networking"}, @{@"source":@"Friend"}];
    
    [ClsSetting SetBorder:_chooseFile_Btn cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0]];
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    [ClsSetting SetBorder:_name_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_email_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_subject_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_choosefile_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_description_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_contact_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_note_View cornerRadius:2 borderWidth:1 color:bColor];
    
    [ClsSetting SetBorder:_aboutus_view cornerRadius:2 borderWidth:1 color:bColor];    
}

- (IBAction)btnchossfilePressed:(id)sender
{
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                            inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (IBAction)btnJobTitlePressed:(id)sender
{
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Job Title" withOption:_arrJobTitle xy:CGPointMake(((SCREEN_WIDTH/2) - (287/2)), 130) size:CGSizeMake(287, SCREEN_HEIGHT/1.8) isMultiple:NO parseKey:@"jobTitle"];
}

//- (IBAction)btnSubmit_Click:(UIButton *)sender {
//}

- (IBAction)BtnSelectSource_Click:(UIButton *)sender
{
    [Dropobj fadeOut];
    
    [self showPopUpWithTitle:@"Select Source" withOption:_arrSelectSource xy:CGPointMake(((SCREEN_WIDTH/2) - (287/2)), 130) size:CGSizeMake(287, SCREEN_HEIGHT/1.8) isMultiple:NO parseKey:@"source"];
    Dropobj.tag = 101;
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple parseKey:parsekey
{
    //    NSString *parsekey;
    //
    //    parsekey = @"jobTitle";
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple parseKey:parsekey];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown1_R:150.0 G:122.0 B:85.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    /*----------------Get Selected Value[Single selection]-----------------*/
    
    if (dropdownListView.tag == 101)
    {
        NSDictionary *dict=[_arrSelectSource objectAtIndex:anIndex];
        _txtSelectSource.text=[dict valueForKey:@"source"];
    }
//    else{
//        NSDictionary *dict=[_arrJobTotle objectAtIndex:anIndex];
//        _txtJobTitle.text=[dict valueForKey:@"jobTitle"];
//    }
}
#pragma mark - iCloud files
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url path]];
        _txtUploadFile.text=[url lastPathComponent];
        NSLog(@"alertMessage:%@",alertMessage);
        strPath=[url path];
        //do stuff
    }
}


- (IBAction)btnSubmit_Click:(UIButton *)sender
{
    if (_txtName.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Name"];
    }
    else if (_txtEmailId.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter Email Id"];
    }
    else if (_txtSubject.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter subject"];
    }
    else if (_txtDescription.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter description"];
    }
    else if (_txtContact.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Enter contact"];
    }
    else if (_txtSelectSource.text.length == 0)
    {
        [ClsSetting ValidationPromt:@"Please select source"];
    }
    else
    {
        NSString *path = strPath;
        if (strPath == nil)
        {
            [ClsSetting ValidationPromt:@"Please choose file"];
        }
        else
        {
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"loading";
            
            NSLog(@"%@",path);
            NSDictionary *params;
            params = @{@"strname":_txtName.text,
                       @"stremail":_txtEmailId.text,
                       @"str_post_name":_txtSubject.text,
                       @"str_msgmsg":_txtDescription.text,
                       @"str_source":_txtSelectSource.text,
                       @"contactdetail":_txtContact.text,
                       @"note":_txtNote.text,
                       };
            
            NSString *boundary = [self generateBoundaryString];
            NSMutableURLRequest *request;
            // configure the request
            request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.adwallz.co/beta/astaguru/PHPMailer-master/examples/sell.php"]]];
            [request setHTTPMethod:@"POST"];
            
            // set content type
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
            NSData *httpBody;
            httpBody = [self createBodyWithBoundary:boundary parameters:params paths:@[path] fieldName:@"imageFile"];
            
            request.HTTPBody = httpBody;
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (connectionError)
                {
                    NSLog(@"error = %@", connectionError);
                    [[[[iToast makeText:@"Imge is not uploded please try again"] setGravity:iToastGravityCenter] setDuration:iToastDurationNormal]show];
                    [HUD hide:YES];
                    return;
                }
                NSError *error;
                NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"%@",dict1);
                if ([[dict1 valueForKey:@"status"] isEqualToString:@"success"])
                {
                    [[[[iToast makeText:@"Thank you. We will get back to you shortly."] setGravity:iToastGravityCenter] setDuration:iToastDurationNormal]show];
//                    _txtMessage.text=@"";
//                    _txtJobTitle.text=@"";
//                    _txtEmailId.text=@"";
//                    _txtName.text=@"";
//                    _txtUploadResume.text=@"";
                    [self.navigationController popViewControllerAnimated:YES];
                    //                NSFileManager *fileManager = [NSFileManager defaultManager];
                    //                NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                }
                [HUD hide:YES];
                // [ClsSetting ValidationPromt:@"Upload Video Successfully"];
                // [[appDelegate window] addSubview:viwLogin];
                NSLog(@"result = %@", result);
            }];
        }
    }
}





- (NSData *)createBodyWithBoundary:(NSString *)boundary
                        parameters:(NSDictionary *)parameters
                             paths:(NSArray *)paths
                         fieldName:(NSString *)fieldName
{
    NSMutableData *httpBody = [NSMutableData data];
    
    // add params (all params are strings)
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // add image data
    
    for (NSString *path in paths)
    {
        NSString *filename  = [path lastPathComponent];
        NSData   *data      = [NSData dataWithContentsOfFile:path];
        NSString *mimetype  = [self mimeTypeForPath:path];
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:data];
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}
- (NSString *)mimeTypeForPath:(NSString *)path
{
    // get a mime type for an extension using MobileCoreServices.framework
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    
    CFRelease(UTI);
    
    return mimetype;
}
-(NSString *)generateBoundaryString
{
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
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

@end
