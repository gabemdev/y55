//
//  TwitterProfile.m
//  Y55
//
//  Created by Rockstar. on 11/29/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "TwitterProfile.h"

@implementation TwitterProfile

- (instancetype)initWithJSON:(NSDictionary *)jsonObject {
    if ((self = [super init])) {
        self.name = [jsonObject objectForKey:@"name"];
        self.followerCount = [jsonObject objectForKey:@"followers_count"];
        self.followingCount = [jsonObject objectForKey:@"friends_count"];
        self.screenName = [jsonObject objectForKey:@"screen_name"];
        self.url = [jsonObject objectForKey:@"url"];
        self.descriptionLabel = [jsonObject objectForKey:@"description"];
        
        self.profileImageUrl = [jsonObject objectForKey:@"profile_image_url"];
        self.profileImageUrl = [self.profileImageUrl stringByReplacingOccurrencesOfString:@"_normal" withString:@"_bigger"];
        
        self.profileBannerUrl = [jsonObject objectForKey:@"profile_banner_url"];
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0)) {
            self.profileBannerUrl = [self.profileBannerUrl stringByAppendingString:@"/mobile_retina"];
        } else {
            self.profileBannerUrl = [self.profileBannerUrl stringByAppendingString:@"/mobile"];
        }
    }
    return self;
}

- (instancetype)initWithFacebook:(NSDictionary *)facebookObject {
    if ((self = [super init])) {
        self.name = [facebookObject objectForKey:@"name"];
    }
    return self;
}

@end
