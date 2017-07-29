//
//  CategoryListSidePageViewController.m
//  AstaGuru
//
//  Created by Aarya Tech on 05/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "CategoryViewController.h"
#import "Category.h"

@interface CategoryViewController ()
{
    NSArray *arrCategory;
}
@end

@implementation CategoryViewController

-(void)setUpNavigationItem
{
    self.title=@"Categories";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrCategory=[[NSMutableArray alloc]init];
    [self getCategoryData];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}

-(void)getCategoryData
{
 
    NSString  *strUrl = [NSString stringWithFormat:@"category?api_key=%@", [GlobalClass apiKey]];
    
    [GlobalClass call_tableGETWebURL:strUrl parameters:nil view:self.view success:^(id responseObject)
     {
         arrCategory = [Category parseCategory:[responseObject valueForKey:@"resource"]];
         if (arrCategory.count == 0){
             [GlobalClass showTost:@"Information not available"];
         }
         [self.clvCategoryList reloadData];
     } failure:^(NSError *error){
         [GlobalClass showTost:error.localizedDescription];
     } callingCount:0];
}

-(void)passReseposeData1:(id)str
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==2)
    {
        return   CGSizeMake((collectionView.frame.size.width),10);
    }
    else
    {
        return   CGSizeMake((collectionView.frame.size.width/2)-10, 80);
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
 
    if (indexPath.section==0||indexPath.section==2)
    {
        cell = [self configureBlankCell:collectionView indexPath:indexPath];
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
        
        Category *objCategory=[arrCategory objectAtIndex:indexPath.row];
        
        UILabel *lblCategoryName = (UILabel *)[cell viewWithTag:11];
        lblCategoryName.text = objCategory.strCategoryName;
        [GlobalClass setBorder:cell cornerRadius:1 borderWidth:1 color:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1]];
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
