//
//  ProfileView.m
//  Y55
//
//  Created by Rockstar. on 11/30/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "ProfileView.h"

@interface ProfileView () 
@end

@implementation ProfileView

#pragma mark - UIView

- (instancetype)init {
    if ((self = [super init])) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 2.0f);
        
        CGContextMoveToPoint(context, 0.0f, 0.0f); //start at this point
        
        CGContextAddLineToPoint(context, 20.0f, 20.0f); //draw to this point
        
        // and now draw the Path!
        CGContextStrokePath(context);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0f);
    
    CGContextMoveToPoint(context, 0.0f, 0.0f); //start at this point
    
    CGContextAddLineToPoint(context, 20.0f, 20.0f); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}



@end
