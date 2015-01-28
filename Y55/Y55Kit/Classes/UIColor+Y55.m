//
//  UIColor+Y55.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "UIColor+Y55.h"

@implementation UIColor (Y55)

+ (instancetype)y55_blueColor {
    return [self colorWithRed:0.129 green:0.455 blue:0.627 alpha:1.0];
}

+ (instancetype)y55_purpleColor {
    return [self colorWithRed:0.369 green:0.173 blue:0.6 alpha:1.0];
}

+ (instancetype)y55_staticColor {
    return [self colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

+ (instancetype)y55_menuBar {
    return [self colorWithPatternImage:[UIImage imageNamed:@"Menubar"]];
}

+ (instancetype)y55_textColor {
    return [self colorWithWhite:0.267f alpha:1.0f];
}

+ (instancetype)y55_orangeColor {
    return [self colorWithRed:1.000f green:0.447f blue:0.263f alpha:1.0f];
}

+ (instancetype)y55_darkTextColor {
    return [self colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
}

+ (instancetype)y55_greenColor {
    return [self colorWithRed:0.20 green:0.80 blue:0.00 alpha:1.0f];
}

+ (instancetype)y55_redColor {
    return [self colorWithRed:0.80 green:0.00 blue:0.00 alpha:1.00];
}

+ (instancetype)y55_yellowColor {
    return [self colorWithRed:1.00f green:0.996f blue:0.792f alpha:1.0f];
}

+ (instancetype)y55_lightTextColor {
    return [self colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0f];
}

@end
