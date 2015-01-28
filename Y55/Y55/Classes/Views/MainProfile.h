//
//  MainProfile.h
//  Y55
//
//  Created by Rockstar. on 12/13/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainProfile : UIView
@property (nonatomic, copy) UIImageView *profileImage;
@property (nonatomic, copy) UILabel *nameLabel;
@property (nonatomic, copy) UILabel *status;
@property (nonatomic, copy) UILabel *location;
@property (nonatomic) UIView *lineView;

- (CGFloat)verticalSpacing;
- (void)setupViews;
- (void)setupConstraints;

@end
