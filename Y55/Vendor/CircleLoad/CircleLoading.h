//
//  CircleLoading.h
//  Y55
//
//  Created by Rockstar. on 12/1/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#pragma mark - 
#pragma mark Color Definitions
//----------------------------------
// To change the color and frame size of the spinner, simply change the color and frame definition here.
//----------------------------------
#define GMD_SPINNER_COLOR       [UIColor colorWithRed:0.129 green:0.455 blue:0.627 alpha:1.0]
#define GMD_SPINNER_FRAME       CGRectMake(40.0f, 40.0f, 60.0f, 60.0f)
#define GMD_SPINNER_IMAGE       CGRectMake(15, 15,30,30)
#define GMD_IMAGE               [UIImage imageNamed:@"image"]
#define GMD_SPINNER_LINE_WIDTH  fmaxf(self.frame.size.width * 0.025, 1.f)

#pragma mark - 
#pragma mark Interface
@interface CircleLoading : UIView

@property (nonatomic, assign) CGFloat lineWidth;


@property (nonatomic, assign) UIColor *lineTintColor;


- (void)startSpinProgressBackgroundLayer;

- (void)stopSpinProgressBackgroundLayer;

+ (CircleLoading *)showHUDAddedTo:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;

+ (BOOL)hideHUDFromView:(UIView *)view animated:(BOOL)animated;


@end
