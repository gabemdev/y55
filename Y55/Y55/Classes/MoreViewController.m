//
//  MoreViewController.m
//  Y55
//
//  Created by Rockstar. on 12/2/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "MoreViewController.h"
#import "MainViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize bannerImage = _bannerImage;
@synthesize profileImage = _profileImage;

- (UIImageView *)bannerImage {
    if (!_bannerImage) {
        _bannerImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _bannerImage.backgroundColor = [UIColor y55_greenColor];
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

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationItem setTitle:@"More"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 120.0f, self.view.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor y55_lightTextColor];
    
    [self.scrollView addSubview:self.bannerImage];
    [self.scrollView addSubview:self.profileImage];
    [self getProfile];
    [self layoutConstraints];
    // Do any additional setup after loading the view.
}

- (void)getProfile{
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
                          
                          NSString *profileImageURLString = [NSString stringWithFormat:@"%@",[json objectForKey:@"profile_image_url"]];
                          profileImageURLString = [profileImageURLString stringByReplacingOccurrencesOfString:@"_normal" withString:@"_reasonably_small"];
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              NSURL *url = [NSURL URLWithString:bannerURLStrong];
                              NSData *data = [NSData dataWithContentsOfURL:url];
                              _bannerImage.image = [UIImage imageWithData:data];
                              
                              NSURL *imgURL = [NSURL URLWithString:profileImageURLString];
                              NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
                              _profileImage.image = [UIImage imageWithData:imgData];

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

- (void)layoutConstraints {
    NSDictionary *views = @{@"profileImage" : self.profileImage,
                            @"banner" : self.bannerImage};
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bannerImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profileImage(80)]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[profileImage(80)]" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[banner(160)]" options:kNilOptions metrics:nil views:views]];
    
}

@end
