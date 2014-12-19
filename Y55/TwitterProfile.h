//
//  TwitterProfile.h
//  Y55
//
//  Created by Rockstar. on 11/29/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterProfile : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSNumber* followerCount;
@property (nonatomic, strong) NSNumber* followingCount;
@property (nonatomic, strong) NSNumber* twitterId;
@property (nonatomic, strong) NSString* screenName;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* profileImageUrl;
@property (nonatomic, strong) NSString* profileBannerUrl;
@property (nonatomic, strong) NSString *descriptionLabel;


-(instancetype)initWithJSON:(NSDictionary*)jsonObject;
-(instancetype)initWithFacebook:(NSDictionary *)facebookObject;

@end
