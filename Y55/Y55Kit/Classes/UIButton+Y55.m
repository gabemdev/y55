//
//  UIButton+Y55.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "UIButton+Y55.h"
#import "UIColor+Y55.h"

@implementation UIButton (Y55)

+ (instancetype)y55_blueButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setBackgroundColor:[UIColor y55_blueColor]];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.layer.cornerRadius = 3;
    [button setTitleColor:[UIColor y55_textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor y55_darkTextColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
    return button;
}

+ (instancetype)y55_orangeButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setBackgroundColor:[UIColor y55_orangeColor]];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.layer.cornerRadius = 3;
    [button setTitleColor:[UIColor y55_textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor y55_darkTextColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
    return button;
}

+ (instancetype)y55_grayButtton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button setBackgroundColor:[UIColor y55_lightTextColor]];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.layer.cornerRadius = 3;
    [button setTitleColor:[UIColor y55_textColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor y55_darkTextColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
    return button;
}

+ (instancetype)y55_outlineButton{
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0f];
    [button setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    
    button.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.5f].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 5.0f;
    return button;
}

+ (instancetype)y55_redButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:15.0f];
    [button setBackgroundColor:[UIColor y55_redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor y55_textColor] forState:UIControlStateHighlighted];
    button.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    button.layer.cornerRadius = 3.0f;
    return button;
}


@end
