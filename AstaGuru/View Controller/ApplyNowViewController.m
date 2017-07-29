//
//  ClientRelationViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/12/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//
#import "ApplyNowViewController.h"
#import "DropDownListView.h"
#import "GlobalClass.h"

@interface ApplyNowViewController ()<kDropDownListViewDelegate,UIDocumentPickerDelegate>
{
    DropDownListView * Dropobj;
    NSString *strPath;
}

@end

@implementation ApplyNowViewController

-(void)setUpNavigationItem
{
    self.title=@"Careers";
    [self setNavigationBarBackButton];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationItem];
    [self setBroder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    _arrSelectSource = @[@{@"source":@"News Paper"}, @{@"source":@"Social Media"}, @{@"source":@"Social Networking"}, @{@"source":@"Friend"}];
    
}

-(void) setBroder
{
    UIColor *bColor = [UIColor colorWithRed:219.0f/255.0f green:219.0f/255.0f blue:219.0f/255.0f alpha:1];
    
    [GlobalClass setBorder:_name_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_email_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_job_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_choosefile_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_message_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_aboutus_view cornerRadius:2 borderWidth:1 color:bColor];
    
    [GlobalClass setBorder:_chooseFile_Btn cornerRadius:2 borderWidth:1 color:[UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0]];

}

- (void)didReceiveMemoryWarning
{
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
    else{
        NSDictionary *dict=[_arrJobTitle objectAtIndex:anIndex];
        _txtJobTitle.text=[dict valueForKey:@"jobTitle"];
    }
}
#pragma mark - iCloud files
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
          NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url path]];
        _txtUploadResume.text=[url lastPathComponent];
        NSLog(@"alertMessage:%@",alertMessage);
        strPath=[url path];
        //do stuff
        
    }
}

- (IBAction)segmentClicked:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (sender.selectedSegmentIndex==1)
    {
        
    }
    
}


- (IBAction)btnSubmit:(id)sender
{
    
    if (_txtName.text.length == 0)
    {
        [GlobalClass showTost:@"Please enter your name"];
    }
    else if (_txtEmailId.text.length == 0)
    {
        [GlobalClass showTost:@"Please enter your email id"];
    }
    else if (_txtJobTitle.text.length == 0)
    {
        [GlobalClass showTost:@"Please select job title"];
    }
    else if (_txtMessage.text.length == 0)
    {
        [GlobalClass showTost:@"Please enter your message"];
    }
    else if (_txtSelectSource.text.length == 0)
    {
        [GlobalClass showTost:@"Please select source"];
    }
    else
    {
//        NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths1 objectAtIndex:0];
        NSString *path = strPath;
        if (strPath == nil)
        {
            [GlobalClass showTost:@"Please choose file"];
        }
        else
        {
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"loading";

            NSLog(@"%@",path);
            NSDictionary *params;
            params = @{@"strname":_txtName.text,
                       @"stremail":_txtEmailId.text,
                       @"str_post_name":_txtJobTitle.text,
                       @"str_msgmsg":_txtMessage.text,
                       @"str_source":_txtSelectSource.text,
                       };
            
            NSString *boundary = [self generateBoundaryString];
            NSMutableURLRequest *request;
            // configure the request
            request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.adwallz.co/beta/astaguru/PHPMailer-master/examples/smtp.php"]]];
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
                    [GlobalClass showTost:@"Imge is not uploded please try again"];
                    [HUD hide:YES];
                    return;
                }
                NSError *error;
                NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"%@",dict1);
                if ([[dict1 valueForKey:@"status"] isEqualToString:@"success"])
                {
                    [GlobalClass showTost:@"Thank you for applying for the job. We will get back to you shortly."];
                    _txtMessage.text=@"";
                    _txtJobTitle.text=@"";
                    _txtEmailId.text=@"";
                    _txtName.text=@"";
                    _txtUploadResume.text=@"";
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [HUD hide:YES];
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

@end
