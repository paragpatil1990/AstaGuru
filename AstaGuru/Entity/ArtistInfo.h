//
//  clsArtistInfo.h
//  AstaGuru
//
//  Created by sumit mashalkar on 16/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalClass.h"
@interface ArtistInfo : NSObject
@property(nonatomic,retain)NSString *strArtistid;
@property(nonatomic,retain)NSString *strFirstName;
@property(nonatomic,retain)NSString *strLastName;
@property(nonatomic,retain)NSString *strProfile;
@property(nonatomic,retain)NSString *strPicture;
@property(nonatomic,retain)NSString *strTitle;
@property(nonatomic,retain)NSString *strartistofthemonth;
@property(nonatomic)NSInteger isSelected;

+(NSMutableArray*)parseArtistInfo:(NSArray*)json;

@end
