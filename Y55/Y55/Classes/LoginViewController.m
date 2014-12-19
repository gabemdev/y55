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
#import "CircleLoading.h"
#import "AppDelegate.h"
#import "LocalyticsUtilities.h"

#import "TwitterAdapter.h"
#import "TwitterProfile.h"

@interface LoginViewController ()

@property (nonatomic, readonly) UIButton *twitterButton;
@property (nonatomic, readonly) UIButton *facebookButton;
@property (nonatomic, readonly) UIButton *googleButton;
@property (nonatomic, readonly) UIButton *linkedInButton;
@property (nonatomic, readonly) UILabel *infoLabel;
@property (nonatomic) UIImageView *logoView;
@property (nonatomic)NSString *accessToken;

@end

@implementation LoginViewController
//@synthesize accounts, accountStore;
@synthesize twitterButton = _twitterButton;
@synthesize facebookButton = _facebookButton;
@synthesize googleButton = _googleButton;
@synthesize linkedInButton = _linkedInButton;
@synthesize logoView = _logoView;
@synthesize infoLabel = _infoLabel;

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.frame = CGRectMake(0.0f, 0.0f, 100.0f, 42.0f);
        _infoLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:17.0f];
        _infoLabel.textColor = [UIColor y55_textColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.numberOfLines = 0;
        _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _infoLabel.clipsToBounds = YES;
        _infoLabel.text = @"Sign in with";
    }
    return _infoLabel;
}

- (UIImageView *)logoView {
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        _logoView.frame = CGRectMake(0.0f, 0.0f, 150.0f, 160.0f);
        _logoView.translatesAutoresizingMaskIntoConstraints = NO;
        _logoView.clipsToBounds = YES;
        _logoView.backgroundColor = [UIColor y55_staticColor];
        _logoView.image = [UIImage imageNamed:@"Logo"];
    }
    return _logoView;
}

- (UIButton *)twitterButton {
    if (!_twitterButton) {
        _twitterButton = [[UIButton alloc] init];
        _twitterButton.translatesAutoresizingMaskIntoConstraints = NO;
        _twitterButton.backgroundColor = [UIColor clearColor];
        _twitterButton.frame = CGRectMake(0.0f, 0.0f, 300.0f, 48.0);
        _twitterButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _twitterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_twitterButton setBackgroundImage:[UIImage imageNamed:@"Twitter"] forState:UIControlStateNormal];
        [_twitterButton setBackgroundImage:[UIImage imageNamed:@"Twitter"] forState:UIControlStateHighlighted];
        [_twitterButton setTitle:@"Sign In with Twitter" forState:UIControlStateNormal];
        [_twitterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_twitterButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _twitterButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        [_twitterButton addTarget:self action:@selector(twitter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twitterButton;
}

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [[UIButton alloc] init];
        _facebookButton.translatesAutoresizingMaskIntoConstraints = NO;
        _facebookButton.backgroundColor = [UIColor clearColor];
        _facebookButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _facebookButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook"] forState:UIControlStateNormal];
        [_facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook"] forState:UIControlStateHighlighted];
        [_facebookButton setTitle:@"Sign In with Facebook" forState:UIControlStateNormal];
        [_facebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_facebookButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _facebookButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        [_facebookButton addTarget:self action:@selector(facebook:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookButton;
}

- (UIButton *)googleButton {
    if (!_googleButton) {
        _googleButton = [[UIButton alloc] init];
        _googleButton.translatesAutoresizingMaskIntoConstraints = NO;
        _googleButton.backgroundColor = [UIColor colorWithRed:0.95 green:0.33 blue:0.23 alpha:1.00];
        _googleButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _googleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_googleButton setBackgroundImage:[UIImage imageNamed:@"Google"] forState:UIControlStateNormal];
        [_googleButton setBackgroundImage:[UIImage imageNamed:@"Google"] forState:UIControlStateHighlighted];
        [_googleButton setTitle:@"Sign In with Google+" forState:UIControlStateNormal];
        [_googleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_googleButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _googleButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//        [_googleButton addTarget:self action:@selector(loginTwitter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _googleButton;
}

- (UIButton *)linkedInButton {
    if (!_linkedInButton) {
        _linkedInButton = [[UIButton alloc] init];
        _linkedInButton.translatesAutoresizingMaskIntoConstraints = NO;
        _linkedInButton.backgroundColor = [UIColor colorWithRed:0.05 green:0.46 blue:0.66 alpha:1.00];
        _linkedInButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _linkedInButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_linkedInButton setBackgroundImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
        [_linkedInButton setBackgroundImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateHighlighted];
        [_linkedInButton setTitle:@"Sign In with LinkedIn" forState:UIControlStateNormal];
        [_linkedInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_linkedInButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _linkedInButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        [_linkedInButton addTarget:self action:@selector(linkedIn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkedInButton;
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
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.view setBackgroundColor:[UIColor clearColor]];
    [self loadButtons];
    [self setupViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showButtons];
    [CircleLoading hideHUDFromView:self.view animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - UI
- (void)loadButtons {
    [self.view addSubview:self.twitterButton];
    [self.view addSubview:self.facebookButton];
    [self.view addSubview:self.googleButton];
    [self.view addSubview:self.linkedInButton];
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.infoLabel];
}

- (void)hideButtons {
    [self.logoView setHidden:YES];
    [_facebookButton setHidden:YES];
    [_twitterButton setHidden:YES];
    [_googleButton setHidden:YES];
    [_linkedInButton setHidden:YES];
    [_infoLabel setHidden:YES];
}

- (void)showButtons {
    [_logoView setHidden:NO];
    [_facebookButton setHidden:NO];
    [_twitterButton setHidden:NO];
    [_googleButton setHidden:NO];
    [_linkedInButton setHidden:NO];
    [_infoLabel setHidden:NO];
}

#pragma mark - Twitter SDK
- (void)twitter:(id)sender {
    [self hideButtons];
    [[LocalyticsSession shared] tagEvent:@"Login Twitter"];
    [CircleLoading showHUDAddedTo:self.view withTitle:@"Loading..." animated:YES];
    SimpleAuth.configuration[@"twitter"] = @{
                                             @"consumer_key" : @"XSYNXCM3aD7ZRqzjLjRiDMS8G",
                                             @"consumer_secret" : @"TxEEeRY4TKV6mnEGiUyFGIYJOoIQIFgRPwRIZ54Y6iRtOwlTvK"
                                             };
    [SimpleAuth authorize:@"twitter" completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        if (error) {
            [self showButtons];
            [CircleLoading hideHUDFromView:self.view animated:YES];
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertview performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
            
        } else {
            NSLog(@"%@", responseObject);
            [[Y55User sharedInstance] loginWithDictionary:responseObject];
            
        }
    }];
}

#pragma mark - Facebook SDK
- (void)facebook:(id)sender {
    [self hideButtons];
    [[LocalyticsSession shared] tagEvent:@"Login Facebook"];
    [CircleLoading showHUDAddedTo:self.view withTitle:@"Loading..." animated:YES];
    SimpleAuth.configuration[@"facebook"] = @{
                                              @"app_id"  : @"313589268843231"
                                              };
    [SimpleAuth authorize:@"facebook" completion:^(id responseObject, NSError *error) {
        if (error) {
            [self showButtons];
            [CircleLoading hideHUDFromView:self.view animated:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        } else {
            NSLog(@"%@", responseObject);
            [[Y55User sharedInstance] loginWithDictionary:responseObject];
        }
    }];
    
}

#pragma mark - LinkedIn
- (void)linkedIn:(id)sender {
    [self hideButtons];
    [[LocalyticsSession shared] tagEvent:@"Login LinkedIn"];
    [CircleLoading showHUDAddedTo:self.view withTitle:@"Loading..." animated:YES];
    SimpleAuth.configuration[@"linkedin-web"] = @{
                                                  @"client_id": @"78uf7g26obbpkv",
                                                  @"client_secret": @"tFnezVOXVTaaIKXX",
                                                  @"redirect_uri": @"http://www.y55happy.com/ios/"};
    [SimpleAuth authorize:@"linkedin-web" completion:^(id responseObject, NSError *error) {
        if (error) {
            [self showButtons];
            [CircleLoading hideHUDFromView:self.view animated:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        } else {
            NSLog(@"responseObject: %@", responseObject);
            [[Y55User sharedInstance] loginWithDictionary:responseObject];
        }
    }];
}

#pragma mark - AutoLayout
- (void)setupViewConstraints {
    NSDictionary *views = @{
                            @"twitter":self.twitterButton,
                            @"facebook": self.facebookButton,
                            @"google" : self.googleButton,
                            @"linked" : self.linkedInButton,
                            @"logo" : self.logoView,
                            @"label" : self.infoLabel
                            };
    
    
    // Buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[twitter(300)]" options:kNilOptions metrics:nil views:views]];
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[facebook(300)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[google(300)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[linked(300)]" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.facebookButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.googleButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.linkedInButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[google(60)]-10-|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[linked(60)]-10-[google]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[facebook(60)]-10-[linked]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[twitter(60)]-10-[facebook]" options:kNilOptions metrics:nil views:views]];
    
    //Logo
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[logo(150)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[logo(160)]" options:kNilOptions metrics:nil views:views]];
    
    //Label
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(22)]-5-[twitter]" options:kNilOptions metrics:nil views:views]];
}

#pragma mark - Actions
- (void)clearHUD {
    [ProgressHUD dismiss];
}


@end
