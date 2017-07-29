//
//  ItemOfPastAuctionViewController.h
//  AstaGuru
//
//  Created by Amrit Singh on 7/3/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ItemOfPastAuctionViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UICollectionView *clvPastAuctionItem;
@property (strong, nonatomic) IBOutlet UILabel *noRecords_Lbl;

@property(nonatomic,retain) PastAuction *pastAuction;

@property BOOL isSearch;
@property (nonatomic) BOOL isFilter;

//@property NSArray *arrSearch;
//@property NSString *searchUrl;

@property NSArray *pastAuctionItemArray;

-(void)showAuctionAnalisys;
@end
