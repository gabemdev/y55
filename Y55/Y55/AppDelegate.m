//
//  AppDelegate.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "AppDelegate.h"
#import "TipsViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <Crashlytics/Crashlytics.h>
#import "LoginViewController.h"
#import "TasksViewController.h"
#import "ProfileViewController.h"
#import "AdvicesViewController.h"
#import "MoreViewController.h"

#import "UIColor+Y55.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - App Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Fabric
    [[Twitter sharedInstance] startWithConsumerKey:Y55_TWITTER_CONSUMER_KEY
                                    consumerSecret:Y55_TWITTER_CONSUMER_SECRET];
    [Fabric with:@[CrashlyticsKit, [Twitter sharedInstance]]];
//    [self accessTwitterAccount];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self _checkUser];
    
    //Ovverrides
    [self loadTabBar];
    [self loadAppearance];
    //RootView
    _window.rootViewController = _tabBarController;
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //Defaults
    NSUserDefaults *standarDefaults = [NSUserDefaults standardUserDefaults];
    [standarDefaults registerDefaults:@{
                                        
                                        }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        NSString *versionString = [NSString stringWithFormat:@"%@ (%@)",
                                   info[@"CFBundleShortVersionString"],
                                   info[@"CFBundleVersion"]];
        [standarDefaults setObject:versionString forKey:@"Y55Version"];
        [standarDefaults synchronize];
    });
    
    //Register for Remote Notifications
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self _checkUser];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
        
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

#pragma mark - UITabBarController
- (void)loadTabBar {
    
    _tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *tips = [[TipsViewController alloc] init];
    UINavigationController *tipsNavigationController = [[UINavigationController alloc] initWithRootViewController:tips];
    [tipsNavigationController.navigationBar setTranslucent:NO];
//    tipsNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [tipsNavigationController.tabBarItem setTitle:@"Feed"];
    [tipsNavigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_purpleColor]} forState:UIControlStateSelected];
//    [tips setTitle:@"Tips"];
    
    UIViewController *tasks = [[TasksViewController alloc] init];
    UINavigationController *taskNavigationController = [[UINavigationController alloc] initWithRootViewController:tasks];
    [taskNavigationController.navigationBar setTranslucent:NO];
//    taskNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [taskNavigationController.tabBarItem setTitle:@"Network"];
    
    UIViewController *profile = [[ProfileViewController alloc] init];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profile];
    [profileNavigationController.navigationBar setTranslucent:NO];
//    profileNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [profileNavigationController.tabBarItem setTitle:@"Profile"];
    [profileNavigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_blueColor]} forState:UIControlStateSelected];
    
    UIViewController *advice = [[AdvicesViewController alloc] init];
    UINavigationController *adviceNavigationController = [[UINavigationController alloc] initWithRootViewController:advice];
    [adviceNavigationController.navigationBar setTranslucent:NO];
//    adviceNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [adviceNavigationController.tabBarItem setTitle:@"Stats"];
    [adviceNavigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_greenColor]} forState:UIControlStateSelected];
    
    UIViewController *more = [[MoreViewController alloc] init];
    UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:more];
    [moreNavigationController.navigationBar setTranslucent:NO];
//    moreNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [moreNavigationController.tabBarItem setTitle:@"More"];
    [more.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_yellowColor]} forState:UIControlStateSelected];
    
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Tips" forState:UIControlStateNormal];
    
    _tabBarController.viewControllers = @[tipsNavigationController, taskNavigationController, profileNavigationController, adviceNavigationController, moreNavigationController];
}

#pragma mark - Appearance

- (void)loadAppearance {
    
    UIApplication *application = [UIApplication sharedApplication];
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barStyle = UIBarStyleBlack;
    navigationBar.barTintColor = [UIColor y55_blueColor];
    navigationBar.tintColor = [UIColor colorWithWhite:1.0 alpha:0.5f];
    navigationBar.titleTextAttributes =@{
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         NSFontAttributeName: [UIFont fontWithName:@"Avenir-Heavy" size:20.0]
                                         };
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarStyle:UIBarStyleDefault];
    [tabBar setTranslucent:NO];
    [tabBar setTintColor:[UIColor y55_blueColor]];
    [tabBar setBackgroundImage:[UIImage new]];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_darkTextColor],
                                         NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:14.0f]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_orangeColor]} forState:UIControlStateSelected];
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0, -13.0)];
}

#pragma mark - Settings
-(BOOL)pushNotificationOnOrOff{
    
    BOOL pushEnabled=NO;
    if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        pushEnabled=YES;
    }
    else {
        pushEnabled=NO;
    }
    
    return pushEnabled;
}


- (void)_checkUser {
    TWTRSession *session = [[Twitter sharedInstance] session];
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded || session) {
        if (session) {
            [self accessTwitterAccount];
        } else {
            //Facebook stuff
            
        }
    } else {
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        appDelegate.window.rootViewController = nav;
    }
}


-(void)showError:(NSString*)errorMessage{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [alertView show];
    });
}

- (void)accessTwitterAccount {
    TWTRSession *session = [[Twitter sharedInstance] session];
    if (session) {
        [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
            if (user) {
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", [user name]]];
//                [_tabBarController setSelectedIndex:0];
                ProfileViewController *viewController = [[ProfileViewController alloc] init];
                NSString *imageString = [user profileImageLargeURL];
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
                UIImage *image = [UIImage imageWithData:imageData];
                [viewController.profileImage setImage:image];
                [viewController.nameLabel setText:[user name]];
                [viewController.navigationItem setTitle:[user name]];
                
            }
        }];
    } else {
        NSLog(@"No Session, please sign up");
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        appDelegate.window.rootViewController = nav;
    }
    return;
    
}

@end
