//
//  ProfileViewController.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterProfile.h"
#import "TwitterAdapter.h"
#import "LoginViewController.h"

@interface ProfileViewController ()

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic) LoginViewController *loginViewController;
@property (nonatomic) BOOL autoRefreshing;
@property (nonatomic) NSTimer *autoRefreshTimer;
@property (nonatomic) BOOL loading;

@end

@implementation ProfileViewController
@synthesize scrollView = _scrollView;
@synthesize profileImage = _profileImage;
@synthesize bannerImage = _bannerImage;
@synthesize followers = _followers;
@synthesize following = _following;
@synthesize followersCount = _followersCount;
@synthesize followingCount = _followingCount;
@synthesize userNameLabel = _userNameLabel;
@synthesize aboutLabel = _aboutLabel;
@synthesize logoutButton = _logoutButton;
@synthesize nameLabel = _nameLabel;
@synthesize lineView = _lineView;
@synthesize autoRefreshing = _autoRefreshing;
@synthesize autoRefreshTimer = _autoRefreshTimer;
@synthesize loading = _loading;

#pragma mark - UIControls

- (UIImageView *)bannerImage {
    if (!_bannerImage) {
        _bannerImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _bannerImage.backgroundColor = [UIColor y55_blueColor];
        [_bannerImage setFrame:CGRectMake(0.0f, 0.0f, 300.0f, 160.0f)];
        _bannerImage.clipsToBounds = YES;
        _bannerImage.translatesAutoresizingMaskIntoConstraints = NO;
        _bannerImage.image = [UIImage imageNamed:@"profile-bg"];
    }
    return _bannerImage;
}

- (UIImageView *)profileImage {
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _profileImage.backgroundColor = [UIColor y55_blueColor];
        [_profileImage setFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
        _profileImage.layer.cornerRadius = _profileImage.frame.size.width/2;
        [_profileImage.layer setBorderColor:[UIColor y55_lightTextColor].CGColor];
        [_profileImage.layer setBorderWidth:2.0f];
        _profileImage.clipsToBounds = YES;
        _profileImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _profileImage;
}

- (UILabel *)followers {
    if (!_followers) {
        _followers = [[UILabel alloc] init];
        _followers.translatesAutoresizingMaskIntoConstraints = NO;
        [_followers setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 22.0f)];
        _followers.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
        [_followers setTextColor:[UIColor y55_textColor]];
        [_followers setTextAlignment:NSTextAlignmentLeft];
        [_followers setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_followers setText:@"Followers"];
    }
    return _followers;
}

- (UILabel *)following {
    if (!_following) {
        _following = [[UILabel alloc] init];
        _following.translatesAutoresizingMaskIntoConstraints = NO;
        [_following setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 22.0f)];
        _following.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
        [_following setTextColor:[UIColor y55_textColor]];
        [_following setTextAlignment:NSTextAlignmentLeft];
        [_following setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_following setText:@"Following"];
    }
    return _following;
}

- (UILabel *)followersCount {
    if (!_followersCount) {
        _followersCount = [[UILabel alloc] init];
        _followersCount.translatesAutoresizingMaskIntoConstraints = NO;
        [_followersCount setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 22.0f)];
        _followersCount.font = [UIFont fontWithName:@"Avenir-Medium" size:16.0f];
        [_followersCount setTextColor:[UIColor y55_darkTextColor]];
        [_followersCount setTextAlignment:NSTextAlignmentLeft];
        [_followersCount setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_followersCount setText:@"0"];
    }
    return _followersCount;
}

- (UILabel *)followingCount {
    if (!_followingCount) {
        _followingCount = [[UILabel alloc] init];
        _followingCount.translatesAutoresizingMaskIntoConstraints = NO;
        [_followingCount setFrame:CGRectMake(0.0f, 0.0f, 40.0f, 22.0f)];
        _followingCount.font = [UIFont fontWithName:@"Avenir-Medium" size:16.0f];
        [_followingCount setTextColor:[UIColor y55_textColor]];
        [_followingCount setTextAlignment:NSTextAlignmentLeft];
        [_followingCount setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_followingCount setText:@"0"];
    }
    return _followingCount;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_nameLabel setFrame:CGRectMake(0.0f, 0.0f, 200.0f, 32.0f)];
        _nameLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0f];
        [_nameLabel setTextColor:[UIColor y55_textColor]];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_nameLabel setText:@"Name"];
    }
    return _nameLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_userNameLabel setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 32.0f)];
        _userNameLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16.0f];
        [_userNameLabel setTextColor:[UIColor y55_blueColor]];
        [_userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [_userNameLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [_userNameLabel setText:@"@username"];
    }
    return _userNameLabel;
}

- (UITextView *)aboutLabel {
    if (!_aboutLabel) {
        _aboutLabel = [[UITextView alloc] init];
        _aboutLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_aboutLabel setUserInteractionEnabled:NO];
        [_aboutLabel setFrame:CGRectMake(0.0f, 0.0f, 200.0f, 60.0f)];
        _aboutLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
        [_aboutLabel setTextColor:[UIColor y55_darkTextColor]];
        [_aboutLabel setTextAlignment:NSTextAlignmentLeft];
        [_aboutLabel setScrollEnabled:YES];
        [_aboutLabel setScrollsToTop:YES];
        [_aboutLabel setText:@"Description"];
        [_aboutLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _aboutLabel;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton y55_redButton];
        _logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_logoutButton setFrame:CGRectMake(0.0f, 0.0f, 300.0f, 42.0f)];
        [_logoutButton sizeToFit];
        [_logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
        [_logoutButton setTitleShadowColor:[UIColor y55_textColor] forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.frame = self.view.bounds;
//        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-100);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _scrollView;
}

//- (UIView *)lineView {
//    if (!_lineView) {
//        _lineView = [[UIView alloc] init];
//        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
//        _lineView.frame = CGRectMake(0.0f, 0.0f ,300, 30);
//        _lineView.backgroundColor = [UIColor y55_lightTextColor];
//    }
//    return _lineView;
//}

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
    [self getTwitterProfile];
}

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController
- (instancetype)init {
    if ((self = [super init])) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.profileImage];
    [_scrollView addSubview:self.bannerImage];
    [_scrollView addSubview:self.aboutLabel];
//    [_scrollView addSubview:self.logoutButton];
    [_scrollView addSubview:self.userNameLabel];
    [_scrollView addSubview:self.followers];
    [_scrollView addSubview:self.followersCount];
    [_scrollView addSubview:self.following];
    [_scrollView addSubview:self.followingCount];
    [_scrollView sendSubviewToBack:self.bannerImage];
    
    [self getTwitterProfile];
    
    [self refresh:nil];
    [self preferencesDidChange];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(preferencesDidChange) name:NSUserDefaultsDidChangeNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(updateTimerPaused:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(updateTimerPaused:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(refresh:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self setupViewConstraints];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _checkUser];
    self.autoRefreshing = [[NSUserDefaults standardUserDefaults] boolForKey:kY55AutomaticallyRefresh];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.autoRefreshing = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Social

- (void)getTwitterProfile {
    Y55User *user = [Y55User sharedInstance];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *banner = user.bannerImageUrl;
        NSURL *bannerURL = [NSURL URLWithString:banner];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *bannerData = [NSData dataWithContentsOfURL:bannerURL];
            if (bannerData) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.bannerImage.image = [UIImage imageWithData:bannerData];
                });
            } 
        });
    });
    
    
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSString *profile = user.profileImageUrl;
       NSURL *profileURL = [NSURL URLWithString:profile];
       
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           NSData *profileData = [NSData dataWithContentsOfURL:profileURL];
           if (profileData) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   self.profileImage.image = [UIImage imageWithData:profileData];
               });
           }
       });
   });
    
    self.followersCount.text = user.followerCount;
    self.followingCount.text = user.followingCount;
    if ([user.followerCount isEqual:@"(null)"] && [user.followingCount isEqual:@"(null)"]) {
        [self.followingCount setHidden:YES];
        [self.followersCount setHidden:YES];
        [self.followers setHidden:YES];
        [self.following setHidden:YES];
    }
    
    self.userNameLabel.text = user.screenName;
    if ([user.screenName  isEqual: @"@(null)"]) {
        self.userNameLabel.text = user.email;
    }
    
    self.aboutLabel.text = user.status;
    if (!user.status) {
        self.aboutLabel.text = user.location;
    }
    [self.navigationItem setTitle:[user name]];
    
}

#pragma mark - Private
- (void)setupViewConstraints {
    NSDictionary *views = @{
                            @"scrollView":self.scrollView,
                            @"profileImage":self.profileImage,
                            @"banner" : self.bannerImage,
                            @"aboutLabel":self.aboutLabel,
                            @"user":self.userNameLabel,
                            @"followers":self.followers,
                            @"following":self.following,
                            @"followerCount":self.followersCount,
                            @"followingCount":self.followingCount
                            };
    
    //---------------------------
    // Scroll View
    //---------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    
    //---------------------------
    // Profile Image
    //---------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[profileImage(80)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[profileImage(80)]" options:kNilOptions metrics:nil views:views]];
    
    //-----------------------------
    // Banner Image
    //-----------------------------
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[banner(115)]" options:kNilOptions metrics:nil views:views]];
    
//    //---------------------------
//    // Name Label
//    //---------------------------
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-13-[nameLabel(200)]"
//                                                                      options:kNilOptions
//                                                                      metrics:nil
//                                                                        views:views]];
//    
////    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
////                                                          attribute:NSLayoutAttributeCenterX
////                                                          relatedBy:NSLayoutRelationEqual
////                                                             toItem:self.scrollView
////                                                          attribute:NSLayoutAttributeCenterX
////                                                         multiplier:1.0
////                                                           constant:0.0]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[nameLabel(32)]"
//                                                                      options:kNilOptions
//                                                                      metrics:nil
//                                                                        views:views]];
    
    //--------------------------
    // User Name
    //--------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[user(200)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-123-[user(32)]" options:kNilOptions metrics:nil views:views]];
    
    //--------------------------
    // About Label
    //--------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[aboutLabel(300)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[aboutLabel(60)]" options:kNilOptions metrics:nil views:views]];
    //    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.aboutLabel
    //                                                          attribute:NSLayoutAttributeCenterX
    //                                                          relatedBy:NSLayoutRelationEqual
    //                                                             toItem:self.scrollView
    //                                                          attribute:NSLayoutAttributeCenterX
    //                                                         multiplier:1.0
    //                                                           constant:0.0]];
    
    //------------------------
    // Followers
    //------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-50-[followerCount(40)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[followerCount(22)]" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-140-[followingCount(40)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[followingCount(22)]" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-50-[followers(100)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-135-[followers(22)]" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-140-[following(100)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-135-[following(22)]" options:kNilOptions metrics:nil views:views]];
    
    
    
    //------------------------
    // Logout Button
    //------------------------
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:self.view.bounds.size.height-120]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[logoutButton]-|" options:kNilOptions metrics:nil views:views]];
    
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
    self.bannerImage.image = [UIImage imageNamed:@"profile-bg"];
    self.profileImage.image = [UIImage new];
//    self.aboutLabel.text = @"";
    self.nameLabel.text = @"";
    self.followersCount.text = @"";
    self.followingCount.text = @"";
    self.userNameLabel.text = @"";
}

- (void)_checkUser {
    if ([[Y55User sharedInstance] isLoggedIn]) {
        AppDelegate *delegate = [AppDelegate sharedAppDelegate];
        delegate.window.rootViewController = delegate.tabBarController;
        [delegate.tabBarController setSelectedIndex:0];
    }
    else {
        NSLog(@"Y55AppDelegate User is not logged in");
        if (!self.loginViewController) {
            self.loginViewController = [[LoginViewController alloc] init];
        }
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

@end
