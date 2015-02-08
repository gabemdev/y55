//
//  AppDelegate.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <Crashlytics/Crashlytics.h>
#import "LocalyticsUtilities.h"
#import "LocalyticsSession.h"

#import "LoginViewController.h"
#import "FeedViewController.h"
#import "NetworkViewController.h"
#import "MainProfileViewController.h"
#import "StatsViewController.h"
#import "MoreViewController.h"
#import <Accounts/Accounts.h>
#import "Y55User.h"

#import "UIColor+Y55.h"
#import "CircleLoading.h"


@interface AppDelegate ()
@property (nonatomic) LoginViewController *loginViewController;

@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - App Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Fabric
    [Fabric with:@[CrashlyticsKit]];
    [self configureAuthorizaionProviders];
    
    LLStartSession(@"c82a4d317ab6b56a26a1e92-f10d0106-80ec-11e4-291b-004a77f8b47f");
    [[LocalyticsSession shared] LocalyticsSession:@"c82a4d317ab6b56a26a1e92-f10d0106-80ec-11e4-291b-004a77f8b47f"];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Ovverrides
    [self loadTabBar];
    [self loadAppearance];
    //RootView
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    [self updateRootVC];
    
    //Login
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootVC) name:UserDidLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootVC) name:UserDidLogoutNotification object:nil];
    
    //Defaults
    NSUserDefaults *standarDefaults = [NSUserDefaults standardUserDefaults];
    [standarDefaults registerDefaults:@{
                                        kY55AutomaticallyRefresh: @YES,
                                        kY55DisableSleepKey: @NO
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

- (void)updateRootVC
{
    if ([[Y55User sharedInstance] isLoggedIn]) {
        NSLog(@"CPAppDelegate.application:didFinishLaunchingWithOptions: user is logged in");
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Signed in!"]];
        _window.rootViewController = _tabBarController;
        
    }
    else {
        NSLog(@"Y55AppDelegate User is not logged in");
        if (!self.loginViewController) {
            self.loginViewController = [[LoginViewController alloc] init];
        }
        self.window.rootViewController = self.loginViewController;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self _checkUser];
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
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


#pragma mark - UITabBarController
- (void)loadTabBar {
    
    _tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *feed = [[FeedViewController alloc] init];
    UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feed];
    [feedNavigationController.navigationBar setTranslucent:NO];
//    tipsNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [feedNavigationController.tabBarItem setTitle:@"Feed"];
//    [feedNavigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_purpleColor]} forState:UIControlStateSelected];
//    [tips setTitle:@"Tips"];
    
    UIViewController *network = [[NetworkViewController alloc] init];
    UINavigationController *networkNavigationController = [[UINavigationController alloc] initWithRootViewController:network];
    [networkNavigationController.navigationBar setTranslucent:NO];
//    taskNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [networkNavigationController.tabBarItem setTitle:@"Network"];
    
    UIViewController *profile = [[MainProfileViewController alloc] init];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profile];
    [profileNavigationController.navigationBar setTranslucent:NO];
//    profileNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [profileNavigationController.tabBarItem setTitle:@"Profile"];
//    [profileNavigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_blueColor]} forState:UIControlStateSelected];
    
    UIViewController *stats = [[StatsViewController alloc] init];
    UINavigationController *statsNavigationController = [[UINavigationController alloc] initWithRootViewController:stats];
    [statsNavigationController.navigationBar setTranslucent:NO];
//    adviceNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [statsNavigationController.tabBarItem setTitle:@"Stats"];
//    [statsNavigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_greenColor]} forState:UIControlStateSelected];
    
    UIViewController *more = [[MoreViewController alloc] init];
    UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:more];
    [moreNavigationController.navigationBar setTranslucent:NO];
//    moreNavigationController.navigationBar.barTintColor = [UIColor y55_blueColor];
    [moreNavigationController.tabBarItem setTitle:@"More"];
//    [more.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_yellowColor]} forState:UIControlStateSelected];
    
    
    _tabBarController.viewControllers = @[feedNavigationController, networkNavigationController, profileNavigationController, statsNavigationController, moreNavigationController];
    
    [_tabBarController setSelectedIndex:0];
}

#pragma mark - Appearance

- (void)loadAppearance {
    
    UIApplication *application = [UIApplication sharedApplication];
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
    navigationBar.tintColor = [UIColor colorWithWhite:1.0 alpha:0.5f];
    navigationBar.titleTextAttributes = @{
                                          NSForegroundColorAttributeName: [UIColor whiteColor],
                                          NSFontAttributeName: [UIFont fontWithName:@"Avenir-Medium" size:20.0]
                                          };
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarStyle:UIBarStyleDefault];
    [tabBar setTranslucent:NO];
    [tabBar setTintColor:[UIColor y55_blueColor]];
    [tabBar setBackgroundImage:[UIImage new]];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_darkTextColor],
                                         NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:14.0f]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor y55_blueColor]} forState:UIControlStateSelected];
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
    if ([[Y55User sharedInstance] isLoggedIn]) {
        NSLog(@"CPAppDelegate.application:didFinishLaunchingWithOptions: user is logged in");
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back!"]];
        _window.rootViewController = _tabBarController;
        [_tabBarController setSelectedIndex:0];
    }
    else {
        NSLog(@"Y55AppDelegate User is not logged in");
        if (!self.loginViewController) {
            self.loginViewController = [[LoginViewController alloc] init];
        }
        self.window.rootViewController = self.loginViewController;
    }
}

#pragma mark - Private

- (void)configureAuthorizaionProviders {
    
    // consumer_key and consumer_secret are required
    SimpleAuth.configuration[@"twitter"] = @{
                                             @"consumer_key" : @"XSYNXCM3aD7ZRqzjLjRiDMS8G",
                                             @"consumer_secret" : @"TxEEeRY4TKV6mnEGiUyFGIYJOoIQIFgRPwRIZ54Y6iRtOwlTvK"
                                             };
    
    // app_id is required
    SimpleAuth.configuration[@"facebook"] = @{
                                              @"app_id"  : @"313589268843231"
                                              };
    
    // client_id, client_secret, and redirect_uri are required
    SimpleAuth.configuration[@"linkedin-web"] = @{
                                                  @"client_id": @"78uf7g26obbpkv",
                                                  @"client_secret": @"tFnezVOXVTaaIKXX",
                                                  @"redirect_uri": @"http://www.y55happy.com/ios/"};
    
    SimpleAuth.configuration[@"google-web"] = @{
                                               @"client_id": @"739097956061-61oqbh8cuuo8btt1p2c85kegu5gclfcv.apps.googleusercontent.com",
                                               @"client_secret": @"uK8B_KK8F6R_WJXKaLij4Bx6",
                                               @"redirect_uri": @"http://localhost"
                                               };
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




@end
