//
//  Y55User.h
//  Y55
//
//  Created by Rockstar. on 12/9/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UserDidLoginNotification;
extern NSString *const UserDidLogoutNotification;

@interface Y55User : NSObject

+ (Y55User *)sharedInstance;

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *accessTokenSecret;

@property (strong, nonatomic) NSString *facebookToken;
@property (strong, nonatomic) NSString *linkedIntoken;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *profileImageUrl;
@property (strong, nonatomic) NSString *bannerImageUrl;
@property (strong, nonatomic) NSString *followerCount;
@property (strong, nonatomic) NSString *followingCount;

//Facebook
@property (strong, nonatomic) NSString *fbName;
@property (strong, nonatomic) NSString *fbImageUrl;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *email;


- (void)loginWithDictionary:(NSDictionary *)dictionary;
- (BOOL)isLoggedIn;
- (void)logout;


@end
