//
//  clsCategory.m
//  AstaGuru
//
//  Created by Aarya Tech on 21/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "Category.h"
#import "GlobalClass.h"
@implementation Category

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+(NSMutableArray*)parseCategory:(NSMutableArray*)json
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc]init];
    for (int j=0; j<json.count; j++)
    {
        Category *objCategory = [[Category alloc]init];
        
        NSDictionary *categoryDic = [GlobalClass removeNullOnly:[json objectAtIndex:j]];
        objCategory.strCategoryid = [categoryDic valueForKey:@"categoryid"];
        objCategory.strCategoryName = [categoryDic valueForKey:@"category"];
        objCategory.strPrVat = [categoryDic valueForKey:@"PrVat"];
        [categoryArray addObject:objCategory];
    }
    return categoryArray;
}

@end
