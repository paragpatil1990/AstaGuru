//
//  AuctionAnalyisisViewController.m
//  AstaGuru
//
//  Created by Apple.Inc on 16/12/17.
//  Copyright © 2017 4Fox Solutions. All rights reserved.
//

#import "AuctionAnalyisisViewController.h"
#import "ClsSetting.h"
#import "AuctionAnalysisTableViewCell.h"
@interface AuctionAnalyisisViewController ()
@property(nonatomic, retain) NSMutableArray *array1;
@property(nonatomic, retain) NSMutableArray *array2;
@property(nonatomic, retain) NSMutableArray *array3;

@end

@implementation AuctionAnalyisisViewController

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.

    [super viewDidLoad];
    
    self.array1 = [[NSMutableArray alloc] init];
    self.array2 = [[NSMutableArray alloc] init];
    self.array3 = [[NSMutableArray alloc] init];

    [self spGetAuctionAnalysis];
    
    self.table_AuctionAnalysis.backgroundColor  = [UIColor whiteColor];
    self.table_AuctionAnalysis.rowHeight = UITableViewAutomaticDimension;
    self.table_AuctionAnalysis.estimatedRowHeight = 300;
    
    self.table_AuctionAnalysis.hidden = YES;
    
    [self setNavigationBarBackButton];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpNavigationItem];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
   // self.navigationController.navigationBar.backItem.title = @"Back";
}

-(void)setNavigationBarBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
  //  [_backButton imageView].contentMode = UIViewContentModeScaleAspectFit;
  //  [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
  //  [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    //[[_backButton titleLabel] setFont:[UIFont fontWithName:@"WorkSans-Medium" size:18]];
   // [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
    [_backButton setTintColor:[UIColor whiteColor]];
    [_backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_backBarButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    [self.navigationItem setLeftBarButtonItem:_backBarButton];
}

-(void)backPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpNavigationItem
{
    self.title=[NSString stringWithFormat:@"Auction Analysis"];

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, -20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    
    UIButton *btnBack1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, -20)];
    [btnBack1 setImage:[UIImage imageNamed:@"icon-myastaguru"] forState:UIControlStateNormal];
    [btnBack1 addTarget:self action:@selector(myastaguru) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnBack1];
    UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -12;
    UIBarButtonItem *spaceFix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    spaceFix.width = -8;
   
    [self.navigationItem setRightBarButtonItems:@[spaceFix,barButtonItem,spaceFix1, barButtonItem1]];
}

-(void)searchPressed
{
    [ClsSetting Searchpage:self.navigationController];
}

-(void)myastaguru
{
    [ClsSetting myAstaGuru:self.navigationController];
}

-(void)spGetAuctionAnalysis
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
        
        NSString *auctionId = [ClsSetting TrimWhiteSpaceAndNewLine:_objCurrentOuction.strOnline];
        
        NSString  *strQuery=[NSString stringWithFormat:@"%@/spGetAuctionAnalysis(%@)?api_key=%@",[ClsSetting procedureURL], auctionId, [ClsSetting apiKey]];
        
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             NSError *error;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             NSMutableArray *auctiuonAnalysis = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
             NSLog(@"%@",auctiuonAnalysis);
             
             NSMutableArray *titleArray = auctiuonAnalysis[0];
             NSDictionary *titleDic = titleArray[0];
             
             NSString *ht = [ClsSetting getAttributedStringFormHtmlString:titleDic[@"Auctionname"]];

             
             self.lbl_title.text = ht; //titleDic[@"Auctionname"];
             self.lbl_date.text = titleDic[@"Date"];
             
             NSMutableArray *analysisArray1 = auctiuonAnalysis[1];
             for (int i = 0; i<analysisArray1.count; i++)
             {
                 NSDictionary *dic = analysisArray1[i];
                 if ([dic[@"typeFlg"] intValue] == 2)
                 {
                     [self.array2 addObject:dic];
                 }
                 else
                 {
                     [self.array1 addObject:dic];
                 }
             }
             
             self.array3 = auctiuonAnalysis[2];
             
//             for (int i = 0; i<analysisArray2.count; i++)
//             {
//                 NSDictionary *dic
//                 [self.array3 addObject:analysisArray2];
//             }
             self.table_AuctionAnalysis.hidden = NO;

             [self.table_AuctionAnalysis reloadData];
             
//             NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
//
//             arrItemCount=[parese parseMyAuctionGallery:dict1 fromBid:1];
//
//             [arrBidHistoryData addObjectsFromArray:arrItemCount];
//
//             [_clsBidHistory reloadData];
             
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {
        return self.array1.count;
    }
    else if (section == 1)
    {
        return self.array2.count;
    }
    else
    {
        return self.array3.count;
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.section==0)
//    {
//        return 100;
//    }
//    else
//    {
//        return 40;
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     return cell;
     */
    
    if (indexPath.section == 0)
    {
        static NSString* cellIdentifier = @"section1cell";
        AuctionAnalysisTableViewCell *cell = (AuctionAnalysisTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableDictionary *dic = [ClsSetting RemoveNullOnly:_array1[indexPath.row]]; //_array1[indexPath.row];
                
        cell.lbl_astristName.text = dic[@"auctionTitle"];
        cell.lbl_us.text = dic[@"numberOfLots"];
        cell.lbl_rs.text = [NSString stringWithFormat:@"%@%s", dic[@"lotPercentage"],"%"];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        static NSString* cellIdentifier = @"section1cell";
        AuctionAnalysisTableViewCell *cell = (AuctionAnalysisTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableDictionary *dic = [ClsSetting RemoveNullOnly: _array2[indexPath.row]];

        cell.lbl_astristName.text = dic[@"auctionTitle"];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        [numberFormatter setCurrencySymbol:@""];
        [numberFormatter setCurrencyCode:@"USD"];
        cell.lbl_us.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger :[dic[@"winingValueUs"] integerValue]]];
        
        [numberFormatter setCurrencyCode:@"INR"];
        cell.lbl_rs.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:[dic[@"winningValueRs"] integerValue]]];
        
//        cell.lbl_us.text = dic[@"winingValueUs"];
//        cell.lbl_rs.text = dic[@"winningValueRs"];
       
        return cell;
    }
    else
    {
        static NSString* cellIdentifier = @"section3cell";
        AuctionAnalysisTableViewCell* cell = (AuctionAnalysisTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableDictionary *dic = [ClsSetting RemoveNullOnly: _array3[indexPath.row]];
        
        cell.lbl_lotno.text = dic[@"productid"];
        cell.lbl_astristName.text = [NSString stringWithFormat:@"%@ %@", dic[@"FirstName"], dic[@"LastName"]];
        cell.lbl_title.text = dic[@"title"];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencySymbol:@""];
        [numberFormatter setMaximumFractionDigits:0];

        double rsValue = [dic[@"pricers"] doubleValue];
        double usValue = [dic[@"priceus"] doubleValue];
        
        double incresedRateRs = (rsValue*15)/100;
        double incresedRateUs = (usValue*15)/100;

        double incresedPriceRs = round(rsValue + incresedRateRs);
        double incresedPriceUs = round(usValue + incresedRateUs);

        [numberFormatter setCurrencyCode:@"USD"];
        cell.lbl_us.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:incresedPriceUs]];
        
        [numberFormatter setCurrencyCode:@"INR"];
        cell.lbl_rs.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:incresedPriceRs]];

        
       // cell.lbl_us.text = [ //dic[@"priceus"];
       // cell.lbl_rs.text = dic[@"pricers"];
       
        return cell;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//WithFrame:CGRectMake(0, 0, tableView.frame.size.width, 56)];
    UIView *hview = [[UIView alloc] init];
    //hview.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1];
    if (section == 0 || section == 1)
    {
        hview.frame = CGRectMake(0, 0, tableView.frame.size.width, 44);
        static NSString* cellIdentifier = @"section1cell";
        AuctionAnalysisTableViewCell* cell1 = (AuctionAnalysisTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell1.contentView.frame = hview.frame;
        cell1.contentView.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1];
        [hview addSubview:cell1.contentView];
        
//        [cell1.contentView layoutSubviews];
//        [cell1.contentView layoutIfNeeded];
//        [cell1 layoutSubviews];
//        [cell1 layoutIfNeeded];
        
        UIFont *font= [UIFont fontWithName:@"WorkSans-Medium" size:15];

        if (section == 0)
        {
            cell1.lbl_astristName.text = @"";
            cell1.lbl_us.text = @"No.";
            cell1.lbl_rs.text = @"Percentage";
            cell1.lbl_rs.numberOfLines = 0;
        }
        else
        {
            cell1.lbl_astristName.text = @"";
            cell1.lbl_us.text = @"US($)";
            cell1.lbl_rs.text = @"RS(₹)";
        }
        cell1.lbl_us.font = font;
        cell1.lbl_rs.font = font;

        
        
        //[cell1 layoutIfNeeded];

        // Left border
//        CALayer *leftBorder = [CALayer layer];
//        leftBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, cell1.frame.size.height);
//        leftBorder.backgroundColor = [UIColor blackColor].CGColor;
//        [cell1.contentView.layer addSublayer:leftBorder];
//
//        // Right border
//        CALayer *rightBorder = [CALayer layer];
//        rightBorder.frame = CGRectMake(cell1.frame.size.width-1, 0.0f, 1.0f, cell1.frame.size.height);
//        rightBorder.backgroundColor = [UIColor blackColor].CGColor;
//        [cell1.contentView.layer addSublayer:rightBorder];
        
       // [self roundTopCornersRadius:8 view:cell1.contentView color:[UIColor lightGrayColor]];
        
        //[self setMaskTo:cell1.contentView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radious:4];

    }
    else
    {
        hview.frame = CGRectMake(0, 0, tableView.frame.size.width, 56);
        static NSString* cellIdentifier = @"section2cell";
        AuctionAnalysisTableViewCell* cell1 = (AuctionAnalysisTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell1.contentView.frame = hview.frame;
        cell1.contentView.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1];
        [UIColor whiteColor];
        [hview addSubview:cell1.contentView];

//        [cell1.contentView layoutSubviews];
//        [cell1.contentView layoutIfNeeded];
//        [cell1 layoutSubviews];
//        [cell1 layoutIfNeeded];
        
        UIFont *font= [UIFont fontWithName:@"WorkSans-Medium" size:15];

        cell1.lbl_lotno.text = @"Lot";
        cell1.lbl_astristName.text = @"Artist & Work";
        cell1.lbl_us.text = @"US($)";
        cell1.lbl_rs.text = @"RS(₹)";
        
        cell1.lbl_lotno.font = font;
        cell1.lbl_astristName.font = font;
        cell1.lbl_us.font = font;
        cell1.lbl_rs.font = font;
        
        //[cell1 layoutIfNeeded];

        // Left border
//        CALayer *leftBorder = [CALayer layer];
//        leftBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, cell1.frame.size.height);
//        leftBorder.backgroundColor = [UIColor blackColor].CGColor;
//        [cell1.contentView.layer addSublayer:leftBorder];
//
//        // Right border
//        CALayer *rightBorder = [CALayer layer];
//        rightBorder.frame = CGRectMake(cell1.frame.size.width-1, 0.0f, 1.0f, cell1.frame.size.height);
//        rightBorder.backgroundColor = [UIColor blackColor].CGColor;
//        [cell1.contentView.layer addSublayer:rightBorder];
        
       // [self roundTopCornersRadius:8 view:cell1.contentView color:[UIColor lightGrayColor]];

        //[self setMaskTo:cell1.contentView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radious:4];
        
//        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
//        cell1.contentView.backgroundColor=[UIColor lightGrayColor];
//        [hview addSubview:vi];

    }
    

    return hview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 44;
    }
    return 56;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    vi.backgroundColor=[UIColor whiteColor];
    [v addSubview:vi];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}


-(void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius view:(UIView*)view color:(UIColor*)color
{
    CGRect bounds = view.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
    
    CAShapeLayer*   frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
    frameLayer.strokeColor = color.CGColor;
    frameLayer.fillColor = nil;
    
    [view.layer addSublayer:frameLayer];
}

-(void)roundTopCornersRadius:(CGFloat)radius view:(UIView*)view color:(UIColor*)color
{
    [self roundCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) radius:radius view:view color:color];
}

-(void)roundBottomCornersRadius:(CGFloat)radius view:(UIView*)view color:(UIColor*)color
{
    [self roundCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) radius:radius  view:view color:color];
}

// set the corner radius to the specified corners of the passed container
- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners radious:(CGFloat)radius
{
//    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
//                                                  byRoundingCorners:corners
//                                                        cornerRadii:CGSizeMake(8.0, 8.0)];
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(radius, radius)];

//    [rounded setLineWidth:1.0];
//    //to give stroke color
//    [[UIColor grayColor] setStroke];
//
//    //to color your border
//    [[UIColor grayColor] setFill];
//
//    [rounded fill];
//    [rounded stroke];

    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
//    shape.frame = view.bounds;
    [shape setPath:rounded.CGPath];
//    shape.strokeColor = [UIColor lightGrayColor].CGColor;
//    shape.fillColor = nil;
    view.layer.mask = shape;
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
