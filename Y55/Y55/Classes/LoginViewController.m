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



@interface LoginViewController ()
@property (nonatomic, readonly) UIButton *twitterButton;
@property (nonatomic, readonly) UIButton *facebookButton;
@property (nonatomic, readonly) UIButton *googleButton;
@property (nonatomic, readonly) UIButton *linkedInButton;
@property (nonatomic) UIImageView *logoView;


@end

@implementation LoginViewController
@synthesize twitterButton = _twitterButton;
@synthesize facebookButton = _facebookButton;
@synthesize googleButton = _googleButton;
@synthesize linkedInButton = _linkedInButton;
@synthesize logoView = _logoView;

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
        _twitterButton.backgroundColor = [UIColor colorWithRed:0.00 green:0.65 blue:0.99 alpha:1.00];
        _twitterButton.frame = CGRectMake(0.0f, 0.0f, 300.0f, 48.0);
//        _twitterButton.layer.cornerRadius = 6;
//        _twitterButton.layer.borderWidth = 2.0;
//        _twitterButton.layer.borderColor = [UIColor colorWithRed:0.333 green:0.675 blue:0.933 alpha:1.0f].CGColor;
        _twitterButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _twitterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [_twitterButton setImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
        [_twitterButton setTitle:@"Sign In with Twitter" forState:UIControlStateNormal];
        [_twitterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_twitterButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _twitterButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        [_twitterButton addTarget:self action:@selector(loginTwitter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twitterButton;
}

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [[UIButton alloc] init];
        _facebookButton.translatesAutoresizingMaskIntoConstraints = NO;
        _facebookButton.backgroundColor = [UIColor colorWithRed:0.31 green:0.41 blue:0.64 alpha:1.00];
        _facebookButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        _facebookButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_facebookButton setTitle:@"Sign In with Facebook" forState:UIControlStateNormal];
        [_facebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_facebookButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _facebookButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//        [_facebookButton addTarget:self action:@selector(loginTwitter:) forControlEvents:UIControlEventTouchUpInside];
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
        [_linkedInButton setTitle:@"Sign In with LinkedIn" forState:UIControlStateNormal];
        [_linkedInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_linkedInButton setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
        _linkedInButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//        [_linkedInButton addTarget:self action:@selector(loginTwitter:) forControlEvents:UIControlEventTouchUpInside];
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
    [FBLoginView class];
    
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
    [self _checkUser];
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
}

- (void)hideButtons {
    [_logoView setHidden:YES];
    [_facebookButton setHidden:YES];
    [_twitterButton setHidden:YES];
    [_googleButton setHidden:YES];
    [_linkedInButton setHidden:YES];
}

- (void)showButtons {
    [_logoView setHidden:NO];
    [_facebookButton setHidden:NO];
    [_twitterButton setHidden:NO];
    [_googleButton setHidden:NO];
    [_linkedInButton setHidden:NO];
}
#pragma mark - Twitter SDK
- (void)loginTwitter:(id)sender {
    //    GMHudView *hud = [[GMHudView alloc] initWithTitle:@"Signing in..." loading:YES];
    //    [hud show];
    [self hideButtons];
    [CircleLoading showHUDAddedTo:self.view withTitle:@"Loading..." animated:YES];
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
                if (user) {
                    //                    [hud completeAndDismissWithTitle:[NSString stringWithFormat:@"Welcome %@!", [user name]]];
                    [CircleLoading hideHUDFromView:self.view animated:YES];
                    ProfileViewController *viewController = [[ProfileViewController alloc] init];
                    NSString *imageString = [user profileImageLargeURL];
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
                    UIImage *image = [UIImage imageWithData:imageData];
                    [viewController.profileImage setImage:image];
                    [viewController.nameLabel setText:[user name]];
                    [viewController.navigationItem setTitle:[user name]];
                    [ProgressHUD showSuccess:[NSString stringWithFormat:@"Signed in as %@!", [user name]]];
                    
                    NSLog(@"New Session: %@", session);
                    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
                    appDelegate.window.rootViewController = appDelegate.tabBarController;
                    [appDelegate.tabBarController setSelectedIndex:0];
                    [self performSelector:@selector(clearHUD) withObject:nil afterDelay:2];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", [error localizedDescription]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            }];
            
        } else
        {
            //                [hud failAndDismissWithTitle:[NSString stringWithFormat:@"%@",error.localizedDescription]];
            [self showButtons];
            [CircleLoading hideHUDFromView:self.view animated:YES];
        }
    }];
}


#pragma mark - Facebook SDK
- (void)facebookView {
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    // Align the button in the center horizontally
    loginView.frame = CGRectMake(10.0, 250, 300, 42);
    [self.view addSubview:loginView];
}


- (void)facebookLogin {
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      if (session.isOpen) {
                                          [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                                              if (!error) {
//                                                  self.nameLabel.text = user.name;
//                                                  self.emailLabel.text = [user objectForKey:@"email"];
                                              }
                                          }];
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
                            @"logo" : self.logoView
                            };
    
    
    // Buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[twitter]-10-|" options:kNilOptions metrics:nil views:views]];
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[facebook]-10-|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[google]-10-|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[linked]-10-|" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.facebookButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.googleButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.linkedInButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[google(48)]-44-|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[linked(48)]-10-[google]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[facebook(48)]-10-[linked]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[twitter(48)]-10-[facebook]" options:kNilOptions metrics:nil views:views]];
    
    //Logo
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[logo(150)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[logo(160)]" options:kNilOptions metrics:nil views:views]];
    
    
}

#pragma mark - Actions
- (void)_checkUser {
    TWTRSession *session = [[Twitter sharedInstance] session];
    if (session) {
        [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
            if (user) {
                AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
                appDelegate.window.rootViewController = appDelegate.tabBarController;
                [appDelegate.tabBarController setSelectedIndex:0];
            } else {
                ProfileViewController *viewController = [[ProfileViewController alloc] init];
                [viewController.profileImage setImage:[UIImage new]];
                [viewController.nameLabel setText:@"Name"];
                [viewController.navigationItem setTitle:@" "];
            }
        }];
    } else {
        NSLog(@"No Session, please sign up");
    }
    return;
}

- (void)clearHUD {
    [ProgressHUD dismiss];
}


@end
