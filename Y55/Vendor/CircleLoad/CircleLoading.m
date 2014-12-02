//
//  CircleLoading.m
//  Y55
//
//  Created by Rockstar. on 12/1/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "CircleLoading.h"

#pragma mark - Interface
@interface CircleLoading ()
@property (nonatomic) CAShapeLayer *progressBackgroundLayer;
@property (nonatomic) BOOL isSpinning;
@end

#pragma mark - Implementation

@implementation CircleLoading

//-----------------------------------
// Add the loader to view
//-----------------------------------
+ (CircleLoading *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    CircleLoading *hud = [[CircleLoading alloc] initWithFrame:GMD_SPINNER_FRAME];
    
    //You can add an image to the center of the spinner view
//    UIImageView *img = [[UIImageView alloc] initWithFrame:GMD_SPINNER_IMAGE];
//    img.image = GMD_IMAGE;
//    hud.center = img.center;
//    [hud addSubview:img];
    
    [hud startSpinProgressBackgroundLayer];
    [view addSubview:hud];
    float height = [[UIScreen mainScreen] bounds].size.height;
    float width = [[UIScreen mainScreen] bounds].size.width;
    CGPoint center = CGPointMake(width/2, height/2);
    hud.center = center;
    return hud;
}

//------------------------------------
// Hide the leader in view
//------------------------------------
+ (BOOL)hideHUDFromView:(UIView *)view animated:(BOOL)animated {
    CircleLoading *hud = [CircleLoading HUDForView:view];
    [hud stopSpinProgressBackgroundLayer];
    if (hud) {
        [hud removeFromSuperview];
        return YES;
    }
    return NO;
}

//------------------------------------
// Perform search for loader and hide it
//------------------------------------
+ (CircleLoading *)HUDForView: (UIView *)view {
    CircleLoading *hud = nil;
    NSArray *subViewsArray = view.subviews;
    Class hudClass = [CircleLoading class];
    for (UIView *aView in subViewsArray) {
        if ([aView isKindOfClass:hudClass]) {
            hud = (CircleLoading *)aView;
        }
    }
    return hud;
}

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    //---------------------------
    // Set line width
    //---------------------------
    _lineWidth = GMD_SPINNER_LINE_WIDTH;
    
    //---------------------------
    // Round Progress View
    //---------------------------
    self.progressBackgroundLayer = [CAShapeLayer layer];
    _progressBackgroundLayer.strokeColor = GMD_SPINNER_COLOR.CGColor;
    _progressBackgroundLayer.fillColor = self.backgroundColor.CGColor;
    _progressBackgroundLayer.lineCap = kCALineCapRound;
    _progressBackgroundLayer.lineWidth = _lineWidth;
    [self.layer addSublayer:_progressBackgroundLayer];
}

- (void)drawRect:(CGRect)rect {
    //-------------------------
    // Make sure layers cover the whole view
    //-------------------------
    _progressBackgroundLayer.frame = self.bounds;
}

#pragma mark - Drawing

- (void)drawBackgroundCircle:(BOOL) partial {
    CGFloat startAngle = - ((float)M_PI / 2); // 90 Degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - _lineWidth)/2;
    
    //Begin draw background
    
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = _lineWidth;
    
    //Make end angle to 90% of the progress
    if (partial) {
        endAngle = (1.8f * (float)M_PI) + startAngle;
    }
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _progressBackgroundLayer.path = processBackgroundPath.CGPath;
}

- (void)startSpinProgressBackgroundLayer {
    self.isSpinning = YES;
    [self drawBackgroundCircle:YES];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [_progressBackgroundLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopSpinProgressBackgroundLayer {
    [self drawBackgroundCircle:NO];
    [_progressBackgroundLayer removeAllAnimations];
    self.isSpinning = NO;
}

@end
