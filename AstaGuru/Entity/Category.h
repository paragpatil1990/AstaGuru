//
//  clsCategory.h
//  AstaGuru
//
//  Created by Aarya Tech on 21/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject
@property(nonatomic,retain)NSString *strCategoryid;
@property(nonatomic,retain)NSString *strCategoryName;
@property(nonatomic,retain)NSString *strPrVat;
@property(nonatomic)NSInteger isSelected;

+(NSMutableArray*)parseCategory:(NSArray*)json;

@end
