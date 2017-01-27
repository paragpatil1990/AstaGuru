//
//  TopStaticCollectionViewCell.m
//  AstaGuru
//
//  Created by Aarya Tech on 02/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "TopStaticCollectionViewCell.h"
#import "ClsSetting.h"
#import "parese.h"
#import "AppDelegate.h"

@implementation TopStaticCollectionViewCell
-(void)setISelectedIndex:(int)iSelectedIndex
{
    AppDelegate *objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    if (objAppDelegate.isRefreshstart==0)
    {
        
        objAppDelegate.isRefreshstart=1;
        _isRefreshstart=1;
        _timer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(Refresh) userInfo:nil repeats:YES];
        
//        _countDownTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(reloadCell) userInfo:nil repeats:YES];

        
    }

    _iSelectedIndex=iSelectedIndex;
  
}
-(void)awakeFromNib
{
    /*if (_isRefreshstart==0)
    {
        
        _isRefreshstart=1;
        _timer =[NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(Refresh) userInfo:nil repeats:YES];
        
    }*/
    [super awakeFromNib];
    _arrSort=[[NSMutableArray alloc]initWithObjects:@"Lots",@"Latest",@"Significant",@"Popular",@"Closing soon",nil];
    _clvSortBy.dataSource=self;
    _clvSortBy.delegate=self;
    NSLog(@"%d",_iSelected);
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 26)];
    [lbl setFont:[UIFont systemFontOfSize:10]];
    float widthIs =
    [[_arrSort objectAtIndex:indexPath.row]
     boundingRectWithSize:lbl.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:lbl.font }
     context:nil]
    .size.width;
    if (indexPath.row==2 ||indexPath.row==4)
    {
       return CGSizeMake(widthIs+10,26);
    }
    return CGSizeMake(40,26);
}
    
    

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return   _arrSort.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"Sort";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
    lblTitle.text=[_arrSort objectAtIndex:indexPath.row];
    
     UIView *viwLineSelected = (UIView *)[cell viewWithTag:21];
    AppDelegate *objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (indexPath.row==objAppDelegate.iSelectedSortInCurrentAuction)
    {
        UILabel *lblline = (UILabel *)[cell viewWithTag:21];
        lblTitle.textColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
        
        lblline.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1];
        viwLineSelected.hidden=NO;
        
    }
    else
    {
        lblTitle.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
       
        viwLineSelected.hidden=YES;
    }

    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
     objAppDelegate.iSelectedSortInCurrentAuction=(int)indexPath.row;
    
    
    if (indexPath.row==0)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"defaultlots?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:_mainView Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
   else if (indexPath.row==1)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"lotslatest?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:_mainView Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
    else if (indexPath.row==2)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"lotssignificant?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:_mainView Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
    else if (indexPath.row==3)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"lotspopular?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:_mainView Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
    else if (indexPath.row==4)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        ClsSetting *objSetting=[[ClsSetting alloc]init];
        [objSetting CallWeb:dict url:[NSString stringWithFormat:@"lotsclosingtime?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed"] view:_mainView Post:NO];
        objSetting.PassReseposeDatadelegate=self;
    }
    [_clvSortBy reloadData];
}


-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    arrItemCount=[parese parseSortCurrentAuction:[dict1 valueForKey:@"resource"]];;
    [_passSortDataDelegate CurrentAuctionSortData:arrItemCount intdex:0 iSelectedntdex:_iSelected];
    
}


-(void)Refresh
{
    NSString *strFunctionName;
     AppDelegate *objAppDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (objAppDelegate.iSelectedSortInCurrentAuction==0)
    {
        strFunctionName=@"defaultlots";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction==1)
    {
        strFunctionName=@"lotslatest";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction==2)
    {
        strFunctionName=@"lotssignificant";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction==3)
    {
        strFunctionName=@"lotspopular";
    }
    else if (objAppDelegate.iSelectedSortInCurrentAuction==4)
    {
        strFunctionName=@"lotsclosingtime";
    }
    
   /* NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"%@?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",strFunctionName] view:_mainView Post:NO];
    objSetting.PassReseposeDatadelegate=self;
    */
    
    
    @try {
        
        
        NSMutableDictionary *Discparam=[[NSMutableDictionary alloc]init];
        // [Discparam setValue:@"cr2016" forKey:@"validate"];
        //[Discparam setValue:@"banner" forKey:@"action"];
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //AFHTTPResponseSerializer serializer
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        ClsSetting *objsetting=[[ClsSetting alloc]init];
        NSString  *strQuery=[NSString stringWithFormat:@"%@%@?api_key=c6935db431c0609280823dc52e092388a9a35c5f8793412ff89519e967fd27ed",[objsetting Url],strFunctionName];
        NSString *url = strQuery;
        NSLog(@"%@",url);
        
        NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:encoded parameters:Discparam success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //  NSError *error=nil;
//             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             NSError *error;
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
            // NSLog(@"%@",responseStr);
            // NSLog(@"%@",dict);
             
             NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
             arrItemCount=[parese parseSortCurrentAuction:[dict valueForKey:@"resource"]];;
             [_passSortDataDelegate CurrentAuctionSortData:arrItemCount intdex:1 iSelectedntdex:0];
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                
//                 if ([operation.response statusCode]==404)
//                 {
//                     [ClsSetting ValidationPromt:@"No Record Found"];
//                 }
//                 else
//                 {
////                     [ClsSetting internetConnectionPromt];
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

-(void)reloadCell
{
    
}

@end
