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
    [self.delegate didSendEmail:self.objAboutUs];
}

@end
