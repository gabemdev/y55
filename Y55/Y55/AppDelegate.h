//
//  AppDelegate.h
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "TwitterAdapter.h"

@class ACAccount;

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBLoginViewDelegate>

+ (AppDelegate *)sharedAppDelegate;


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UITabBarController *tabBarController;
- (void)_checkUser;

//Social
@property (nonatomic)NSString *accessToken;
-(void)showError:(NSString*)errorMessage;




@end

