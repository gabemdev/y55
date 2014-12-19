//
//  MainProfileViewController.m
//  Y55
//
//  Created by Rockstar. on 12/13/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "MainProfileViewController.h"
#import "LoginViewController.h"

#import "MainProfile.h"
#import <SAMGradientView/SAMGradientView.h>
#import "GMDPTR.h"

@interface MainProfileViewController () <GMDPTRViewDelegate>
@property (nonatomic, readonly) MainProfile *profile;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) SAMGradientView *backgroundView;
@property (nonatomic, copy) GMDPTRView *pullToRefresh;
@property (nonatomic) LoginViewController *loginViewController;
@property (nonatomic) BOOL autoRefreshing;
@property (nonatomic) NSTimer *autoRefreshTimer;
@property (nonatomic) BOOL loading;

@end

@implementation MainProfileViewController

#pragma mark - Accessors
@synthesize profile = _profile;
@synthesize scrollView = _scrollView;
@synthesize backgroundView = _backgroundView;
@synthesize pullToRefresh = _pullToRefresh;
@synthesize autoRefreshing = _autoRefreshing;
@synthesize autoRefreshTimer = _autoRefreshTimer;
@synthesize loading = _loading;

- (MainProfile *)profile {
    if (!_profile) {
        _profile = [[MainProfile alloc] init];
    }
    return _profile;
}

- (SAMGradientView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[SAMGradientView alloc] init];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.gradientColors = @[
                                           [UIColor y55_blueColor],
                                           [UIColor y55_purpleColor]
                                           ];
        _backgroundView.dimmedGradientColors = _backgroundView.gradientColors;
    }
    return _backgroundView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (GMDPTRView *)pullToRefresh {
    if (!_pullToRefresh) {
        _pullToRefresh = [[GMDPTRView alloc] initWithScrollView:self.scrollView delegate:self];
        _pullToRefresh.defaultContentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
        
        GMDPTRSimple *contentView = [[GMDPTRSimple alloc] init];
        contentView.statusLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.8f];
        contentView.statusLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0];
        contentView.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _pullToRefresh.contentView = contentView;
    }
    return _pullToRefresh;
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_loading];
    
    if (loading) {
        self.navigationItem.title = @"Updating...";
        [self.pullToRefresh startLoading];
    } else {
        self.navigationItem.title = @"";
        [self.pullToRefresh finishLoading];
    }
}

- (void)setAutoRefreshing:(BOOL)autoRefreshing {
    if (_autoRefreshing == autoRefreshing) {
        return;
    }
    
    _autoRefreshing = autoRefreshing;
    
    if (_autoRefreshing) {
        self.autoRefreshTimer = [NSTimer timerWithTimeInterval:60.0 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.autoRefreshTimer forMode:NSRunLoopCommonModes];
    } else {
        [self.autoRefreshTimer invalidate];
    }
}

- (void)refresh:(id)sender {
    if (self.loading) {
        return;
    }
    self.loading = YES;
    
    if ([Y55User sharedInstance].isLoggedIn) {
        [self update];
        self.loading = NO;
    }
}

- (void)update {
    Y55User *user = [Y55User sharedInstance];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *profile = user.profileImageUrl;
        NSURL *profileURL = [NSURL URLWithString:profile];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *profileData = [NSData dataWithContentsOfURL:profileURL];
            if (profileData) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.profile.profileImage.image = [UIImage imageWithData:profileData];
                });
            } else {
                self.profile.profileImage.image = [UIImage imageNamed:@"no-user"];
            }
        });
    });
    
    self.profile.status.text = user.status;
    if (!user.status) {
        self.profile.status.text = user.location;
    }
    
    self.profile.nameLabel.text = user.name;
    
    [self viewDidLayoutSubviews];
    
}

#pragma mark - NSObject
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    SAMGradientView *gradient = [[SAMGradientView alloc] initWithFrame:self.view.bounds];
    gradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gradient.gradientColors = @[
                                [UIColor y55_blueColor],
                                [UIColor y55_purpleColor]
                                ];
    gradient.gradientLocations = @[@0.5f, @0.51f];
    gradient.dimmedGradientColors = gradient.gradientColors;
    [self.view addSubview:gradient];
    
    [self.view addSubview:self.scrollView];
    [self pullToRefresh];
    
    gradient = [[SAMGradientView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 30.0)];
    gradient.backgroundColor = [UIColor clearColor];
    gradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    gradient.gradientColors = @[
                                [UIColor y55_blueColor],
                                [[UIColor y55_blueColor] colorWithAlphaComponent:0.0]
                                ];
    gradient.gradientLocations = @[@0.6f, @1];
    gradient.dimmedGradientColors = gradient.gradientColors;
    [self.view addSubview:gradient];
    
    [self.scrollView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.profile];
    
    [self refresh:nil];
    [self preferencesDidChange];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(preferencesDidChange) name:NSUserDefaultsDidChangeNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(updateTimerPaused:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(updateTimerPaused:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(refresh:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self setupViewConstraints];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _checkUser];
    [self update];
    self.autoRefreshing = [[NSUserDefaults standardUserDefaults] boolForKey:kY55AutomaticallyRefresh];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.autoRefreshing = NO;
}


#pragma mark - Private
- (void)setupViewConstraints {
    NSDictionary *views = @{
                            @"scrollView" : self.scrollView,
                            @"backgroundView": self.backgroundView,
                            @"profile" : self.profile
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    
    
}


#pragma mark - Actions

- (void)logout:(id)sender {
    [self signOut:nil];
}

- (void)signOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Out" message:@"Are you sure you want to sign out of Y55?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Out", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex !=1) {
        return;
    }
    [[Y55User sharedInstance] logout];
//    self.profile.profileImage.image = [UIImage imageNamed:@"no-user"];
//    self.profile.status.text = @"Name";
//    self.profile.nameLabel.text = @"Add bio";
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    [delegate.tabBarController setSelectedIndex:0];
}

- (void)_checkUser {
    if ([[Y55User sharedInstance] isLoggedIn]) {
        AppDelegate *delegate = [AppDelegate sharedAppDelegate];
        delegate.window.rootViewController = delegate.tabBarController;
    }
    else {
        NSLog(@"Y55AppDelegate User is not logged in");
        if (!self.loginViewController) {
            self.loginViewController = [[LoginViewController alloc] init];
        }
        [[Y55User sharedInstance] logout];
        AppDelegate *delegate = [AppDelegate sharedAppDelegate];
        delegate.window.rootViewController = self.loginViewController;
    }
}

#pragma mark - Preferences
- (void)preferencesDidChange {
    [UIApplication sharedApplication].idleTimerDisabled = [[NSUserDefaults standardUserDefaults] boolForKey:kY55DisableSleepKey];
    [self updateTimerPaused:nil];
}

- (void)updateTimerPaused:(NSNotification *)notification {
    BOOL active = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    self.autoRefreshing = active && [[NSUserDefaults standardUserDefaults] boolForKey:kY55AutomaticallyRefresh];
}


#pragma mark - SSPullToRefreshViewDelegate

- (void)pullToRefreshViewDidStartLoading:(GMDPTRView *)view {
    [self refresh:view];
}


- (BOOL)pullToRefreshViewShouldStartLoading:(GMDPTRView *)view {
    return !self.loading;
}

@end
