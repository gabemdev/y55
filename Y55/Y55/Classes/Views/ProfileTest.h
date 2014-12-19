//
//  ProfileTest.h
//  Y55
//
//  Created by Rockstar. on 12/15/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTest : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (CGFloat)verticalSpacing;
- (void)setupViews;
- (void)setupConstraints;

@end
