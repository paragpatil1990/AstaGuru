//
//  SearchViewController.h
//  AstaGuru
//
//  Created by Aarya Tech on 18/10/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *clvSearchBaR;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
