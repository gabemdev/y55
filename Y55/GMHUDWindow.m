//
//  GMHUDWindow.m
//  Hipster
//
//  Created by Rockstar. on 8/20/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "GMHUDWindow.h"
#import "GMHUDWindowViewController.h"

static GMHUDWindow *kHUDWindow = nil;

@implementation GMHUDWindow
@synthesize hidesVignette = _hidesVignette;

#pragma mark - Accessors

- (void)setHidesVignette:(BOOL)hide {
    _hidesVignette = hide;
    self.userInteractionEnabled = !hide;
    [self setNeedsDisplay];
}

#pragma mark - Class Methods

+(GMHUDWindow *)defaultWindow {
    if (!kHUDWindow) {
        kHUDWindow = [[GMHUDWindow alloc] init];
    }
    return kHUDWindow;
}

#pragma mark - NSObject

- (id)init {
    if ((self = [super initWithFrame:[[UIScreen mainScreen] bounds]])) {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.rootViewController = [[GMHUDWindowViewController alloc] init];
    }
    return self;
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
        if (self.hidesVignette) {
            return;
        }
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSArray *colors = @[(id)[UIColor colorWithWhite:0.0f alpha:0.1f].CGColor,
                           (id)[UIColor colorWithWhite:0.0f alpha:0.5f].CGColor];
    
        CGGradientRef gradient = CGGradientCreateWithColors(CGColorGetColorSpace((__bridge CGColorRef)colors[0]), (__bridge  CFArrayRef)colors, NULL);
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGContextDrawRadialGradient(context, gradient, centerPoint, 0.0f, centerPoint, fmaxf(self.bounds.size.width, self.bounds.size.height) / 2.0f, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

@end
