//
//  FeedViewController.m
//  Y55
//
//  Created by Rockstar. on 12/10/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "FeedViewController.h"
#import "ProfileTest.h"


@interface FeedViewController ()
@property (nonatomic, readonly) ProfileTest *profile;
@property (nonatomic, readonly) ProfileTest *profile2;
@property (nonatomic, readonly) ProfileTest *profile3;
@property (nonatomic, readonly) ProfileTest *profile4;

@end

@implementation FeedViewController

#pragma mark - Accessors
@synthesize profile = _profile;
@synthesize profile2 = _profile2;
@synthesize profile3 = _profile3;
@synthesize profile4 = _profile4;

- (ProfileTest *)profile {
    if (!_profile) {
        _profile = [[ProfileTest alloc] init];
        _profile.titleLabel.text = @"Self-Assessment";
        _profile.titleLabel.textAlignment = NSTextAlignmentCenter;
        _profile.imageView.image = [UIImage imageNamed:@"profile-bg"];
    }
    return _profile;
}

- (ProfileTest *)profile2 {
    if (!_profile2) {
        _profile2 = [[ProfileTest alloc] init];
        _profile2.titleLabel.text = @"Happiness Test";
        
    }
    return _profile2;
}

- (ProfileTest *)profile3 {
    if (!_profile3) {
        _profile3 = [[ProfileTest alloc] init];
        _profile3.titleLabel.text = @"Find Friends";
    }
    return _profile3;
}

- (ProfileTest *)profile4 {
    if (!_profile4) {
        _profile4 = [[ProfileTest alloc] init];
        _profile4.titleLabel.text = @"Happy Coach";
    }
    return _profile4;
}

#pragma mark - NSObject
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backgroundView addSubview:self.profile];
    [self.backgroundView addSubview:self.profile2];
    [self.backgroundView addSubview:self.profile3];
    [self.backgroundView addSubview:self.profile4];
    [self layoutConstraints];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configuration
- (CGFloat)verticalSpacing {
    return 16.0;
}



- (void)layoutConstraints {
    CGFloat verticalSpacing = self.verticalSpacing;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:verticalSpacing * 3]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:verticalSpacing * 3]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profile.titleLabel attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing * 3]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profile2.titleLabel attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing * 3]];
   
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile4 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
    
    
    
}



@end
