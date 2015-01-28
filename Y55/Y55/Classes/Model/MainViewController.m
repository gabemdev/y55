//
//  MainViewController.m
//  Y55
//
//  Created by Rockstar. on 12/14/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "MainViewController.h"
#import <SAMGradientView/SAMGradientView.h>

@interface MainViewController ()


@end

@implementation MainViewController
@synthesize scrollView = _scrollView;
@synthesize backgroundView = _backgroundView;

- (SAMGradientView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[SAMGradientView alloc] init];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.gradientColors = @[
                                           [UIColor whiteColor],
                                           [UIColor whiteColor]
                                           ];
        _backgroundView.dimmedGradientColors = _backgroundView.gradientColors;
    }
    return _backgroundView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor y55_blueColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [self.navigationController.navigationBar setTranslucent:YES];
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    SAMGradientView *gradient = [[SAMGradientView alloc] initWithFrame:self.view.bounds];
    gradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gradient.gradientColors = @[
                                [UIColor whiteColor],
                                [UIColor whiteColor]
                                ];
    gradient.gradientLocations = @[@0.5f, @0.51f];
    gradient.dimmedGradientColors = gradient.gradientColors;
    [self.view addSubview:gradient];
    
    [self.view addSubview:self.scrollView];
    
    gradient = [[SAMGradientView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 30.0)];
    gradient.backgroundColor = [UIColor clearColor];
    gradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    gradient.gradientColors = @[
                                [UIColor whiteColor],
                                [[UIColor whiteColor] colorWithAlphaComponent:0.0]
                                ];
    gradient.gradientLocations = @[@0.6f, @1];
    gradient.dimmedGradientColors = gradient.gradientColors;
    [self.view addSubview:gradient];
    
    [self.scrollView addSubview:self.backgroundView];
    
    [self setupViewConstraints];
}

#pragma mark - Private
- (void)setupViewConstraints {
    NSDictionary *views = @{
                            @"scrollView" : self.scrollView,
                            @"backgroundView": self.backgroundView
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

@end
