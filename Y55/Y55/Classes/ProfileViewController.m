//
//  ProfileViewController.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterProfile.h"

@interface ProfileViewController ()

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (atomic, strong) TwitterProfile *profile;

@end

@implementation ProfileViewController
@synthesize scrollView = _scrollView;
@synthesize profileImage = _profileImage;
@synthesize nameLabel = _nameLabel;
@synthesize aboutLabel = _aboutLabel;
@synthesize urlButton = _urlButton;
@synthesize logoutButton = _logoutButton;

#pragma mark - UIControls

- (UIImageView *)profileImage {
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _profileImage.backgroundColor = [UIColor y55_blueColor];
        [_profileImage setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
        _profileImage.layer.cornerRadius = _profileImage.frame.size.width/2;
        [_profileImage.layer setBorderColor:[UIColor y55_lightTextColor].CGColor];
        [_profileImage.layer setBorderWidth:2.0f];
        _profileImage.clipsToBounds = YES;
        _profileImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _profileImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_nameLabel setFrame:CGRectMake(0.0f, 0.0f, 200.0f, 32.0f)];
        _nameLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0f];
        [_nameLabel setTextColor:[UIColor y55_textColor]];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_nameLabel setText:@"Name"];
    }
    return _nameLabel;
}

- (UITextView *)aboutLabel {
    if (!_aboutLabel) {
        _aboutLabel = [[UITextView alloc] init];
        _aboutLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_aboutLabel setUserInteractionEnabled:NO];
        [_aboutLabel setFrame:CGRectMake(0.0f, 0.0f, 200.0f, 100.0f)];
        _aboutLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
        [_aboutLabel setTextColor:[UIColor y55_darkTextColor]];
        [_aboutLabel setTextAlignment:NSTextAlignmentCenter];
        [_aboutLabel setScrollEnabled:YES];
        [_aboutLabel setScrollsToTop:YES];
        [_aboutLabel setText:@"Description"];
//        [_aboutLabel setBackgroundColor:[UIColor blueColor]];
    }
    return _aboutLabel;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton y55_redButton];
        _logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_logoutButton setFrame:CGRectMake(0.0f, self.view.bounds.size.height - 44, 300.0f, 42.0f)];
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
        _scrollView.contentSize = CGSizeMake(self.view.center.x, self.view.bounds.size.height-100);
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
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.profileImage];
    [_scrollView addSubview:self.nameLabel];
    [_scrollView addSubview:self.aboutLabel];
    [_scrollView addSubview:self.logoutButton];
    [self setupViewConstraints];
    
//    [self getTwitterInfo];
    [self loadSocialInfo];
    [self getProfileInfo];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadSocialInfo];
    [self getProfileInfo];
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
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
            UIImage *image = [UIImage imageWithData:imageData];
            [_profileImage setImage:image];
            
            [_nameLabel setText:[user name]];
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
                          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                              NSLog(@"%@", json);
//                              NSString *profileImageUrl = [user profileImageLargeURL];
//                              NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrl]];
//                              UIImage *image = [UIImage imageWithData:imageData];
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
//                              [_profileImage setImage:image];
//                              [_nameLabel setText:[json objectForKey:@"name"]];
                              [_aboutLabel setText:[json objectForKey:@"description"]];
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
    [_nameLabel setText:[self.profile name]];
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
                            @"nameLabel":self.nameLabel,
                            @"aboutLabel":self.aboutLabel,
                            @"logoutButton":self.logoutButton
                            };
    
    //Scroll View
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    //Profile Image
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[profileImage(100)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[profileImage(100)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    //Name Label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[nameLabel(200)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[profileImage]-[nameLabel(32)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    //About Label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[aboutLabel(200)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.aboutLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameLabel][aboutLabel(100)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
    
    //Logout Button
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[logoutButton(300)]"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoutButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.scrollView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[aboutLabel]-140-[logoutButton]-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views]];
}

#pragma mark - Actions
- (void)editProfile:(id)sender {
    
}

- (void)logout:(id)sender {
    [[Twitter sharedInstance] logOut];
    [TwitterKit logOut];
     [self signOut:nil];
    
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
    _nameLabel.text = @"Name";
    _aboutLabel.text = @"Description";
    
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    appDelegate.window.rootViewController = nav;
}

@end
