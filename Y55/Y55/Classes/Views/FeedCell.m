//
//  FeedCell.m
//  Y55
//
//  Created by Rockstar. on 1/27/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

#pragma mark - Accessors
@synthesize fromTitle = _fromTitle;
@synthesize notificationTitle = _notificationTitle;
@synthesize timeLabel = _timeLabel;
@synthesize cellImage = _cellImage;
@synthesize notificationIcon = _notificationIcon;


- (UILabel *)fromTitle {
    if (!_fromTitle) {
        _fromTitle = [[UILabel alloc] init];
        _fromTitle.frame = CGRectMake(0, 0, 200.0, 40);
        _fromTitle.textColor = [UIColor y55_blueColor];
        _fromTitle.font = [UIFont fontWithName:@"Avenir-Medium" size:30.0];
        _fromTitle.textAlignment = NSTextAlignmentLeft;
        _fromTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _fromTitle;
}

- (UILabel *)notificationTitle {
    if (!_notificationTitle) {
        _notificationTitle = [[UILabel alloc] init];
        _notificationTitle.frame = CGRectMake(0, 0, 200, 32);
        _notificationTitle.numberOfLines = 0;
        _notificationTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _notificationTitle.textColor = [UIColor y55_blueColor];
        _notificationTitle.font = [UIFont fontWithName:@"Avenir-Light" size:14.0];
        _notificationTitle.textAlignment = NSTextAlignmentLeft;
        _notificationTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _notificationTitle;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(0, 0, 100, 25);
        _timeLabel.textColor = [UIColor y55_blueColor];
        _timeLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timeLabel;
}

- (UIImageView *)cellImage {
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc] init];
        _cellImage.frame = CGRectMake(0, 0, 80, 80);
        _cellImage.contentMode = UIViewContentModeScaleAspectFit;
        _cellImage.translatesAutoresizingMaskIntoConstraints = NO;
        _cellImage.clipsToBounds = YES;
        _cellImage.layer.cornerRadius = 40;
        _cellImage.layer.borderColor = [UIColor y55_blueColor].CGColor;
        _cellImage.layer.borderWidth = 2;
    }
    return _cellImage;
}

- (UIImageView *)notificationIcon {
    if (!_notificationIcon) {
        _notificationIcon = [[UIImageView alloc] init];
        _notificationIcon.frame = CGRectMake(0, 0, 40, 40);
        _notificationIcon.contentMode = UIViewContentModeScaleToFill;
        _notificationIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _notificationIcon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        [self loadViews];
        [self loadConstraints];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Views
- (void)loadViews {
    
    [self addSubview:self.fromTitle];
    [self addSubview:self.notificationTitle];
    [self addSubview:self.timeLabel];
    [self addSubview:self.cellImage];
    [self addSubview:self.notificationIcon];
    
}

- (void)loadConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cellImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cellImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:80.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cellImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:80.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cellImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationIcon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:30]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fromTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:120]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fromTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fromTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:40.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fromTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:200]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:120]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fromTitle attribute:NSLayoutAttributeTop multiplier:1.0 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:50]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.notificationTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:200]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:25]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.0 constant:100]];
    
    
    
    
    
    
    
}
@end
