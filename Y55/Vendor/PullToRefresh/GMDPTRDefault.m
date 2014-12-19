//
//  GMDPTRDefault.m
//  GMDPTR
//
//  Created by Rockstar. on 10/24/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "GMDPTRDefault.h"

@implementation GMDPTRDefault

@synthesize statusLabel = _statusLabel;
@synthesize lastUpdatedAtLabel = _lastUpdatedAtLabel;
@synthesize activityIndicatorView = _activityIndicatorView;

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        CGFloat width = self.bounds.size.width;
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 14.0f, width, 20.0f)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
        
        _lastUpdatedAtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 34.0f, width, 20.0f)];
        _lastUpdatedAtLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _lastUpdatedAtLabel.font = [UIFont systemFontOfSize:12.0f];
        _lastUpdatedAtLabel.textColor = [UIColor lightGrayColor];
        _lastUpdatedAtLabel.backgroundColor = [UIColor clearColor];
        _lastUpdatedAtLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdatedAtLabel];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.frame = CGRectMake(30.0f, 25.0f, 20.0f, 20.0f);
        [self addSubview:_activityIndicatorView];
    }
    return self;
}

#pragma mark - GMDPTRContentView

- (void)setState:(GMDPTRViewState)state withPullToRefreshView:(GMDPTRView *)view {
    switch (state) {
        case GMDPTRViewStateReady:{
            self.statusLabel.text = NSLocalizedString(@"Release to refresh…", nil);
            [self.activityIndicatorView stopAnimating];
            break;
        }
    
        case GMDPTRViewStateNormal: {
            self.statusLabel.text = NSLocalizedString(@"Pull down to refresh…", nil);
            [self.activityIndicatorView stopAnimating];
            break;
        }
        case GMDPTRViewStateLoading:
        case GMDPTRViewStateClosing: {
            self.statusLabel.text = NSLocalizedString(@"Loading…", nil);
            [self.activityIndicatorView startAnimating];
            break;
        }
    }
}

- (void)setLastUpdatedAt:(NSDate *)date withPullToRefreshView:(GMDPTRView *)view {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.formatterBehavior = NSDateFormatterBehavior10_4;
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    });
    
    self.lastUpdatedAtLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Last Update: %@", nil), [dateFormatter stringForObjectValue:date]];
}

@end
