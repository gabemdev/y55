//
//  GMHudView.h
//  Hipster
//
//  Created by Rockstar. on 8/20/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GMHudView : UIView

@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) CGSize hudSize;
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, getter=isSuccessful) BOOL successful;
@property (nonatomic) BOOL hidesVignette;
@property (nonatomic, strong) UIImage *completeImage;
@property (nonatomic, strong) UIImage *failImage;

- (id)initWithTitle:(NSString *)aTitle;
- (id)initWithTitle:(NSString *)aTitle loading:(BOOL)isLoading;

- (void)show;
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

- (void)completeWithTitle:(NSString *)aTitle;
- (void)completeAndDismissWithTitle:(NSString *)aTitle;
- (void)completeQuicklyWithTitle:(NSString *)aTitle;

- (void)failWithTitle:(NSString *)aTitle;
- (void)failAndDismissWithTitle:(NSString *)aTitle;
- (void)failQuicklyWithTitle:(NSString *)aTitle;



@end
