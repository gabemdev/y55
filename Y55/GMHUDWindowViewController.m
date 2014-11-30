//
//  GMHUDWindowViewController.m
//  Hipster
//
//  Created by Rockstar. on 8/20/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "GMHUDWindowViewController.h"

@implementation GMHUDWindowViewController
@synthesize statusBarStyle = _statusBarStyle;

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

@end
