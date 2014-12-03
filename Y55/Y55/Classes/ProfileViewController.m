//
//  ProfileViewController.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterProfile.h"
#import "ProfileView.h"

@interface ProfileViewController ()

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (atomic, strong) TwitterProfile *profile;

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

#pragma mark - UIControls

- (UIImageView *)bannerImage {
    if (!_bannerImage) {
        _bannerImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _bannerImage.backgroundColor = [UIColor y55_blueColor];
        [_bannerImage setFrame:CGRectMake(0.0f, 0.0f, 300.0f, 160.0f)];
        _bannerImage.clipsToBounds = YES;
        _bannerImage.translatesAutoresizingMaskIntoConstraints = NO;
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
        [_aboutLabel setFrame:CGRectMake(0.0f, 0.0f, 200.0f, 80.0f)];
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
        _scrollView.frame = self.view.bounds;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-100);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _scrollView;
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editProfile:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 180.0f, self.view.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor y55_lightTextColor];
    
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.profileImage];
    [_scrollView addSubview:self.bannerImage];
//    [_scrollView addSubview:self.nameLabel];
    [_scrollView addSubview:self.aboutLabel];
    [_scrollView addSubview:self.logoutButton];
    [_scrollView addSubview:self.userNameLabel];
    [_scrollView addSubview:self.followers];
    [_scrollView addSubview:self.followersCount];
    [_scrollView addSubview:self.following];
    [_scrollView addSubview:self.followingCount];
    [_scrollView addSubview:lineView];
    [_scrollView sendSubviewToBack:self.bannerImage];
    
    
    [self setupViewConstraints];
    
    [self loadSocialInfo];
    [self getProfileInfo];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Social

-(void)loadSocialInfo {
    TWTRSession *session = [[Twitter sharedInstance] session];
    [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
        if (user) {
            NSString *imageString = [user profileImageLargeURL];
            NSLog(@"%@", imageString);
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
            UIImage *image = [UIImage imageWithData:imageData];
            [_profileImage setImage:image];
            
            [_userNameLabel setText:[NSString stringWithFormat:@"@%@", [user screenName]]];
//            [_nameLabel setText:[user name]];
            [self.navigationItem setTitle:[user name]];
            
        }
    }];
}

- (void)getProfileInfo{
    TWTRSession *session = [[Twitter sharedInstance] session];
    [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
        if (user) {
            NSString *userString = @"https://api.twitter.com/1.1/users/show.json";
            NSDictionary* params = @{@"screen_name" : [user screenName]};
            NSError *error;
            NSURLRequest *request = [[[Twitter sharedInstance] APIClient] URLRequestWithMethod:@"GET"
                                                                                           URL:userString
                                                                                    parameters:params
                                                                                         error:&error];
            
            if (request) {
                [[[Twitter sharedInstance] APIClient] sendTwitterRequest:request
                                                              completion:^(NSURLResponse *response,
                                                                           NSData *data, NSError *connectionError) {
                      if (data) {
                          NSError *jsonError;
                          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:0
                                                                                 error:&jsonError];
                          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                              NSString *bannerURLStrong = [NSString stringWithFormat:@"%@/mobile_retina",[json objectForKey:@"profile_banner_url"]];
                              
//                              NSString *profileImageURLString = [NSString stringWithFormat:@"%@",[json objectForKey:@"profile_image_url"]];
//                              profileImageURLString = [profileImageURLString stringByReplacingOccurrencesOfString:@"_normal" withString:@"_reasonably_small"];
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSURL *url = [NSURL URLWithString:bannerURLStrong];
                                  NSData *data = [NSData dataWithContentsOfURL:url];
                                  _bannerImage.image = [UIImage imageWithData:data];
                                  
                                  [_aboutLabel setText:[json objectForKey:@"description"]];
                                  [_followingCount setText:[NSString stringWithFormat:@"%@",[json objectForKey:@"friends_count"]]];
                                  [_followersCount setText:[NSString stringWithFormat:@"%@",[json objectForKey:@"followers_count"]]];
                              });
                          });
                      }
                      else {
                          NSLog(@"Error: %@", connectionError);
                      }
                  }];
            }
            else {
                NSLog(@"Error: %@", error);
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    
    
    
}

- (void)twitterProfileReceived:(NSDictionary *)jsonResponse {
    self.profile = [[TwitterProfile alloc] initWithJSON:jsonResponse];
//    [_nameLabel setText:[self.profile name]];
    [_aboutLabel setText:[self.profile descriptionLabel]];
}

//- (void)loadInfoWithSession:(TWTRSession *)session {
//    [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
//        if (user) {
//            NSLog(@"%@", [user profileImageMiniURL]);
//            NSLog(@"%@", [user screenName]);
//            NSLog(@"%@", [user name]);
//            NSLog(@"%@", [user formattedScreenName]);
//
//
//            NSString *screnNameString = [user screenName];
//            NSString *nameString = [user name];
//            NSString *formatString = [user formattedScreenName];
//
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                //Profile Image
//                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrl]];
//                UIImage *image = [UIImage imageWithData:imageData];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [_profileImage setImage:image];
//                    [_nameLabel setText:nameString];
//                });
//            });
//        }
//    }];
//
//}

#pragma mark - Private
- (void)setupViewConstraints {
    NSDictionary *views = @{
                            @"scrollView":self.scrollView,
                            @"profileImage":self.profileImage,
                            @"banner" : self.bannerImage,
                            @"nameLabel":self.nameLabel,
                            @"aboutLabel":self.aboutLabel,
                            @"logoutButton":self.logoutButton,
                            @"user":self.userNameLabel,
                            @"followers":self.followers,
                            @"following":self.following,
                            @"followerCount":self.followersCount,
                            @"followingCount":self.followingCount
                            };
    
    //---------------------------
    // Scroll View
    //---------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    //---------------------------
    // Profile Image
    //---------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[profileImage(80)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[profileImage(80)]" options:kNilOptions metrics:nil views:views]];
    //    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage
    //                                                          attribute:NSLayoutAttributeCenterX
    //                                                          relatedBy:NSLayoutRelationEqual
    //                                                             toItem:self.scrollView
    //                                                          attribute:NSLayoutAttributeCenterX
    //                                                         multiplier:1.0
    //                                                           constant:0.0]];
    
    
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
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-113-[user(32)]" options:kNilOptions metrics:nil views:views]];
    
    //--------------------------
    // About Label
    //--------------------------
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[aboutLabel(300)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[profileImage]-42-[aboutLabel(60)]" options:kNilOptions metrics:nil views:views]];
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
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-40-[followerCount(40)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[followerCount(22)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-120-[followingCount(40)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[followingCount(22)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-40-[followers(100)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[followers(22)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage]-120-[following(100)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[following(22)]" options:kNilOptions metrics:nil views:views]];
    
    
    
    //------------------------
    // Logout Button
    //------------------------
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[logoutButton]-|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:self.view.bounds.size.height-120]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    
     
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[logoutButton]-10-|" options:kNilOptions metrics:nil views:views]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
//    
////    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|--[logoutButton(42)]-44-|" options:kNilOptions metrics:nil views:views]];
    
}



#pragma mark - Actions
- (void)editProfile:(id)sender {
    
}

- (void)logout:(id)sender {
    TWTRSession *session = [[Twitter sharedInstance] session];
    if (session) {
        [[Twitter sharedInstance] logOut];
        [TwitterKit logOut];
        [self signOut:nil];
    }
    
    
}

- (void)signOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Out" message:@"Are you sure you want to sign out of Hipster" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Out", nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex !=1) {
        return;
    }
    [self.navigationItem setTitle:@""];
    _profileImage.image = [UIImage new];
//    _nameLabel.text = @"Name";
    _aboutLabel.text = @"Description";
    
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    appDelegate.window.rootViewController = nav;
}

@end
