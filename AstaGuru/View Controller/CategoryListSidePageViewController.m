//
//  CategoryListSidePageViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 05/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CategoryListSidePageViewController.h"
#import "ClsSetting.h"
#import "SWRevealViewController.h"
#import "clsCategory.h"
#import "AppDelegate.h"
@interface CategoryListSidePageViewController ()<PassResepose>
{
    NSMutableArray *arrCategory;
}
@end

@implementation CategoryListSidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrCategory=[[NSMutableArray alloc]init];
    [self getCategoryData];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
-(void)getCategoryData
{
    
   
    
 
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    ClsSetting *objSetting=[[ClsSetting alloc]init];
    objSetting.PassReseposeDatadelegate=self;
    [objSetting CallWeb:dict url:[NSString stringWithFormat:@"category?api_key=%@",[ClsSetting apiKey]] view:self.view Post:NO];
    
}

-(void)passReseposeData1:(id)str
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavigationItem
{
    self.navigationItem.title=@"Categories";
    self.sideleftbarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-close"] style:UIBarButtonItemStyleDone target:self action:@selector(closePressed)];
    self.sideleftbarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:self.sideleftbarButton];
    
    self.sidebarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signs"] style:UIBarButtonItemStyleDone target:self.revealViewController action:@selector(revealToggle:)];
    self.sidebarButton.tintColor=[UIColor whiteColor];
    [[self navigationItem] setLeftBarButtonItem:self.sidebarButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
-(void)closePressed
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UIViewController *viewController =rootViewController;
    AppDelegate * objApp = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    objApp.window.rootViewController = viewController;
    
}
-(void)passReseposeData:(id)arr
{
    NSError *error;
    NSMutableArray *dict1 = [NSJSONSerialization JSONObjectWithData:arr options:0 error:&error];
    
    NSLog(@"%@",dict1);
    NSMutableArray *arrItemCount=[[NSMutableArray alloc]init];
    // arrItemCount=[parese parsePastOccution:[dict1 valueForKey:@"resource"]];
    arrItemCount=[parese parseCategory:[dict1 valueForKey:@"resource"]];
    
    [arrCategory addObjectsFromArray:arrItemCount];
    _clvCategoryList.hidden=NO;
    [_clvCategoryList reloadData];
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 3;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==2)
    {
        return   CGSizeMake((collectionView1.frame.size.width),20);
    }
    else
    {
        
        return   CGSizeMake((collectionView1.frame.size.width/2)-7,83);
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0 ||section==2)
    {
        return 1;
    }
    else
    {
        return  arrCategory.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell;
    
    
    
    
    // if (isList==FALSE)
    // {
    
    if (indexPath.section==0||indexPath.section==2)
    {
        
        
        static NSString *identifier = @"blankcell";
        UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        
        cell = cell2;
        
    }
    else
    {
        clsCategory *objCategory=[arrCategory objectAtIndex:indexPath.row];
       UICollectionViewCell   *CurrentSelectedGridCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryList" forIndexPath:indexPath];
        UILabel *lblCategoryName = (UILabel *)[CurrentSelectedGridCell viewWithTag:101];
        lblCategoryName.text=[NSString stringWithFormat:@"%@",objCategory.strCategoryName];
        
        CurrentSelectedGridCell.layer.borderWidth=1;
        CurrentSelectedGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        CurrentSelectedGridCell.layer.borderColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
        cell= CurrentSelectedGridCell;
        
    }
    
    
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
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
