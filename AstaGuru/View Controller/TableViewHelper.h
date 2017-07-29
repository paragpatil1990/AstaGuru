//
//  TableViewHelper.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/26/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewHelper : UITableView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) id base;
@property(nonatomic, retain) NSArray *arrOption;

- (id)initWithFrame:(CGRect)rect;
-(void)addSearchTableView;
-(void)spSearch:(NSString *)strSearchType;
@end
