//
//  BottomMenuCollectionViewCell.h
//  AstaGuru
//
//  Created by Amrit Singh on 6/27/17.
//  Copyright © 2017 Aarya Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomMenuCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblSelectedLine;
@property (strong, nonatomic) IBOutlet UILabel *lblMenuName;
@property (strong, nonatomic) IBOutlet UIButton *btnLive;

@end
