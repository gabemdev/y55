//
//  Y55User.m
//  Y55
//
//  Created by Rockstar. on 12/9/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "Y55User.h"
#import "Y55APIClient.h"
#import "ProfileViewController.h"

NSString *const UserDidLoginNotification = @"UserDidLoginNotification";
NSString *const UserDidLogoutNotification = @"UserDidLogoutNotification";

static NSString *const kPersistKey = @"Y55.Y55User";

@interface Y55User ()
@property (strong, nonatomic) NSDictionary *authAttributes;
- (void)setAuthAttributes:(NSDictionary *)authAttributes;

- (NSDictionary *)load;
- (BOOL)persist;
@end

@implementation Y55User

+ (Y55User *)sharedInstance {
    static dispatch_once_t once;
    static Y55User *instance;
    dispatch_once(&once, ^{
        instance = [[Y55User alloc] init];
        [instance load];
    });
    return instance;
}

#pragma mark - auth attributes, and persistence

@synthesize authAttributes = _authAttributes;

- (void)setAuthAttributes:(NSDictionary *)authAttributes
{
    if (![_authAttributes isEqualToDictionary:authAttributes]) {
        NSLog(@"Y55ser.setAttributes: changed");
        _authAttributes = authAttributes;
        
        if (authAttributes) {
            NSDictionary *credentials = [authAttributes objectForKey:@"credentials"];
            self.accessToken = [credentials objectForKey:@"token"];
            self.accessTokenSecret = [credentials objectForKey:@"secret"];
            
            Y55APIClient *apiClient = [Y55APIClient sharedInstance];
            [apiClient setAccessToken:self.accessToken
                               secret:self.accessTokenSecret];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSDictionary *info = [authAttributes objectForKey:@"info"];
                self.bannerImageUrl = [NSString stringWithFormat:@"%@", info[@"banner"]];
                self.profileImageUrl = [NSString stringWithFormat:@"%@", info[@"image"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.status = info[@"description"];
                    self.screenName = [NSString stringWithFormat:@"@%@",info[@"nickname"]];
                    self.name = info[@"name"];
                    self.followerCount = [NSString stringWithFormat:@"%@",info[@"followers"]];
                    self.followingCount = [NSString stringWithFormat:@"%@",info[@"following"]];
                    self.email = [NSString stringWithFormat:@"%@",info[@"email"]];
                    self.location = info[@"location"];
                });
            });
        }
    }
}


- (NSDictionary *)load
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = (NSData *)[ud objectForKey:kPersistKey];
    self.authAttributes = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return self.authAttributes;
}

- (BOOL)persist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = (NSData *)[NSKeyedArchiver archivedDataWithRootObject:self.authAttributes];
    [ud setObject:data forKey:kPersistKey];
    BOOL retVal = [ud synchronize];
    if (retVal) {
        NSLog(@"Y55ser.persist: success");
    }
    else {
        NSLog(@"Y55User.persist: failure");
    }
    return retVal;
}

#pragma mark - login, logout

- (void)loginWithDictionary:(NSDictionary *)dictionary
{
    self.authAttributes = dictionary;
    [self persist];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:nil];
}

- (BOOL)isLoggedIn
{
    return ([self.authAttributes objectForKey:@"credentials"] != nil);
}

- (void)logout
{
    self.authAttributes = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}
@end
