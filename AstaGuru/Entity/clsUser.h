//
//  clsUser.h
//  AstaGuru
//
//  Created by sumit mashalkar on 15/09/16.
//  Copyright © 2016 Aarya Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clsUser : NSObject
@property(nonatomic,retain)NSString *strUserid;
@property(nonatomic,retain)NSString *strUsername;
@property(nonatomic,retain)NSString *strPassword;
@property(nonatomic,retain)NSString *strName;
@property(nonatomic,retain)NSString *straddress1;
@property(nonatomic,retain)NSString *strAddress2;
@property(nonatomic,retain)NSString *strCity;
@property(nonatomic,retain)NSString *strMobile;
@property(nonatomic,retain)NSString *strCountry;
@property(nonatomic,retain)NSString *strZip;
@property(nonatomic,retain)NSString *strTelephone;
@property(nonatomic,retain)NSString *strEmail;
@property(nonatomic)BOOL
bAdmin;
@property(nonatomic,retain)NSString *strSmsCode;
@property(nonatomic,retain)NSString *strMobileVerified;
@property(nonatomic,retain)NSString *strActivationcodel;
@property(nonatomic,retain)NSString *EmailVerified;

@end
