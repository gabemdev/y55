//
//  ProfileTest.m
//  Y55
//
//  Created by Rockstar. on 12/15/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "ProfileTest.h"

@implementation ProfileTest
@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage new]];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.borderColor = [UIColor y55_lightTextColor].CGColor;
        _imageView.layer.borderWidth = 2;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        _titleLabel.text = @"Description";
    }
    return _titleLabel;
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Configuration
- (CGFloat)verticalSpacing {
    return 16.0;
}

- (void)setupViews {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

#pragma mark - Private

- (void)setupConstraints {
    NSDictionary *views = @{
        @"image" : self.imageView,
        @"title" : self.titleLabel
        };
    
    CGFloat verticalSpacing = self.verticalSpacing;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[image(130)]" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[image(180)]" options:kNilOptions metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing / 2 - 5]];
    
    
    
    
    
}



@end
