//
//  AboutUsCollectionViewCell.m
//  AstaGuru
//
//  Created by Aarya Tech on 30/08/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import "AboutUsCollectionViewCell.h"

@implementation AboutUsCollectionViewCell
- (IBAction)btnEmaqilClicked:(id)sender
{
    [_AboutUsdelegate btnEmail:_objAboutUs];
    NSLog(@"%@",_objAboutUs.strEmail);
}

@end
