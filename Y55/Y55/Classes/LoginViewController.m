//
//  LoginViewController.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "ProfileViewController.h"



@interface LoginViewController ()
@property (nonatomic, readonly) UIButton *twitterButton;

@end

@implementation LoginViewController
@synthesize twitterButton = _twitterButton;

- (UIButton *)twitterButton {
    if (!_twitterButton) {
        _twitterButton = [[UIButton alloc] init];
        _twitterButton.translatesAutoresizingMaskIntoConstraints = NO;
        _twitterButton.frame = CGRectMake(0.0f, 0.0f, 300.0f, 48.0);
        _twitterButton.layer.cornerRadius = 6;
        _twitterButton.layer.borderWidth = 2.0;
        _twitterButton.layer.borderColor = [UIColor colorWithRed:0.333 green:0.675 blue:0.933 alpha:1.0f].CGColor;
        _twitterButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _twitterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_twitterButton setImage:[UIImage imageNamed:@"Twitter"] forState:UIControlStateNormal];
        [_twitterButton setTitle:@"  Sign In with Twitter" forState:UIControlStateNormal];
        [_twitterButton setTitleColor:[UIColor colorWithRed:0.333 green:0.675 blue:0.933 alpha:1.0] forState:UIControlStateNormal];
        _twitterButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        [_twitterButton addTarget:self action:@selector(loginTwitter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twitterButton;
}

#pragma mark - UIViewController
- (instancetype)init {
    if ((self = [super init])) {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.twitterButton];
    [self setupViewConstraints];
}


#pragma mark - Twitter SDK
//- (void)getTwitterAccountOnCompletion:(void(^)(ACAccount *))completionHandler {
//    ACAccountStore *store = [[ACAccountStore alloc] init];
//    ACAccountType *twitterType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//    [store requestAccessToAccountsWithType:twitterType options:nil completion:^(BOOL granted, NSError *error) {
//        if(granted) {
//            // Remember that twitterType was instantiated above
//            NSArray *twitterAccounts = [store accountsWithAccountType:twitterType];
//            
//            // If there are no accounts, we need to pop up an alert
//            if(twitterAccounts == nil || [twitterAccounts count] == 0) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts"
//                                                                message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//                [alert show];
//            } else {
//                //Get the first account in the array
//                ACAccount *twitterAccount = [twitterAccounts objectAtIndex:0];
//                //Save the used SocialAccountType so it can be retrieved the next time the app is started.
////                [[NSUserDefaults standardUserDefaults] setInteger:SocialAccountTypeTwitter forKey:kSocialAccountTypeKey];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                //Call the completion handler so the calling object can retrieve the twitter account.
//                completionHandler(twitterAccount);
//            }
//        }
//    }];
//
//}
//
//- (void)getFacebookAccountOnCompletion:(void(^)(ACAccount *))completionHandler {
//    ACAccountStore *store = [[ACAccountStore alloc] init];
//    ACAccountType *facebookType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
//    [store requestAccessToAccountsWithType:facebookType options:nil completion:^(BOOL granted, NSError *error) {
//        if (granted) {
//            NSArray *facebookAccounts = [store accountsWithAccountType:facebookType];
//            
//            if (!facebookAccounts || [facebookAccounts count] == 0) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Facebook Accounts" message:@"There are no Facebook accounts configured. You can add or create a Facebook account in Settings."
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//                [alert show];
//            } else {
//                ACAccount *facebookAccount = [facebookAccounts objectAtIndex:0];
////                [[NSUserDefaults standardUserDefaults] setInteger:SocialAccountTypeTwitter forKey:kSocialAccountTypeKey];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                completionHandler(facebookAccount);
//            }
//        }
//    }];
//}


#pragma mark - AutoLayout
- (void)setupViewConstraints {
    NSDictionary *views = @{
                            @"twitter":self.twitterButton,
                            };
    
    
    //Logout Button
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[twitter(300)]"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[twitter(48)]-44-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
}

#pragma mark - Actions
- (void)loginTwitter:(id)sender {
    
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session != nil) {
            AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
            appDelegate.window.rootViewController = appDelegate.tabBarController;
        }
    }];
}

@end
