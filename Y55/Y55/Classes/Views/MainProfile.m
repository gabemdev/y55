//
//  MainProfile.m
//  Y55
//
//  Created by Rockstar. on 12/13/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "MainProfile.h"

@implementation MainProfile

#pragma mark - Accessors
@synthesize profileImage = _profileImage;
@synthesize nameLabel = _nameLabel;
@synthesize status = _status;


- (UIImageView *)profileImage {
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _profileImage.translatesAutoresizingMaskIntoConstraints = NO;
        _profileImage.backgroundColor = [UIColor y55_staticColor];
        _profileImage.layer.cornerRadius = 75;
        [_profileImage.layer setBorderColor:[UIColor y55_lightTextColor].CGColor];
        [_profileImage.layer setBorderWidth:2.0f];
        _profileImage.clipsToBounds = YES;
        _profileImage.image = [UIImage imageNamed:@"no-user"];
    }
    return _profileImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0f];
        [_nameLabel setTextColor:[UIColor y55_lightTextColor]];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_nameLabel setText:@"Name"];
    }
    return _nameLabel;
}

- (UILabel *)status {
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.translatesAutoresizingMaskIntoConstraints = NO;
        _status.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
        [_status setTextColor:[UIColor whiteColor]];
        [_status setTextAlignment:NSTextAlignmentCenter];
//        [_status setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        [_status setNumberOfLines:2];
        [_status setText:@"Add Bio"];
    }
    return _status;
}


#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self setupViews];
        [self setupConstraints];
        [self getTwitterProfile];
    }
    return self;
}

#pragma mark - Configuration

- (CGFloat)verticalSpacing {
    return 16.0;
}

- (void)setupViews {
    [self addSubview:self.profileImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.status];
}

#pragma mark - Private

- (void)setupConstraints {
    NSDictionary *views = @{
    @"profile" : self.profileImage,
    @"name" : self.nameLabel,
    @"status" : self.status
    };
    
    CGFloat verticalSpacing = [self verticalSpacing];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profile(150)]" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[profile(150)]" options:kNilOptions metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[status(320)]" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[status(30)]" options:kNilOptions metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profileImage attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing / 2]];
    

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.status attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.status attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing / 2 - 10]];
    
}

- (void)getTwitterProfile {
    Y55User *user = [Y55User sharedInstance];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *profile = user.profileImageUrl;
        NSURL *profileURL = [NSURL URLWithString:profile];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *profileData = [NSData dataWithContentsOfURL:profileURL];
            if (profileData) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.profileImage.image = [UIImage imageWithData:profileData];
                });
            } else {
                self.profileImage.image = [UIImage imageNamed:@"no-user"];
            }
        });
    });
    
    self.status.text = user.status;
    if (!user.status) {
        self.status.text = user.location;
    }
    
    self.nameLabel.text = user.name;
    
}

@end
