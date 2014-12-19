//
//  GMDPTRSimple.h
//  GMDPTR
//
//  Created by Rockstar. on 10/24/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "GMDPTRView.h"

@interface GMDPTRSimple : UIView <GMDPTRContentView>

@property (nonatomic, readonly) UILabel *statusLabel;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicatorView;

@end
