//
//  AppDelegate.h
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UITabBarController *tabBarController;

+ (AppDelegate *)sharedAppDelegate;

@property (nonatomic) TWTRSession *mainSession;
@property (nonatomic) TWTRUser *mainUser;

- (void)accessTwitterAccount;


@end

