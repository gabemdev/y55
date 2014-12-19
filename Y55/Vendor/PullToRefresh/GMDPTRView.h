//
//  GMDPTRView.h
//  GMDPTR
//
//  Created by Rockstar. on 10/23/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

typedef enum {
    GMDPTRViewStateNormal,
    
    GMDPTRViewStateReady,
    
    GMDPTRViewStateLoading,
    
    GMDPTRViewStateClosing
    
} GMDPTRViewState;

@protocol GMDPTRViewDelegate;
@protocol GMDPTRContentView;

@interface GMDPTRView : UIView

@property (nonatomic, strong) UIView<GMDPTRContentView> *contentView;

@property (nonatomic, assign) UIEdgeInsets defaultContentInset;

@property (nonatomic, assign) CGFloat expandedHeight;

@property (nonatomic, assign, readonly, getter=isExpanded) BOOL expanded;

@property (nonatomic, assign, readonly) UIScrollView *scrollView;

@property (nonatomic, weak) id<GMDPTRViewDelegate> delegate;

@property (nonatomic, assign, readonly) GMDPTRViewState state;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView delegate:(id<GMDPTRViewDelegate>)delegate;

- (void)startLoading;

- (void)startLoadingAndExpand:(BOOL)shouldExpand animated:(BOOL)animated;
- (void)startLoadingAndExpand:(BOOL)shouldExpand animated:(BOOL)animated completion:(void(^)())block;

- (void)finishLoading;
- (void)finishLoadingAnimated:(BOOL)animated completion: (void(^)())block;

- (void)refreshLastUpdatedAt;

@end

@protocol GMDPTRViewDelegate <NSObject>

@optional

- (BOOL)pullToRefreshViewShouldStartLoading:(GMDPTRView *)view;
- (void)pullToRefreshViewDidStartLoading:(GMDPTRView *)view;
- (BOOL)pullTorefreshViewDidFinishLoading:(GMDPTRView *)view;
- (NSDate *)pullToRefreshViewLastUpdatedAt:(GMDPTRView *)view;

- (void)pullToRefreshView:(GMDPTRView *)view disUpdateContentInset:(UIEdgeInsets)contentInset;

- (void)pullToRefreshView:(GMDPTRView *)view willTransitionToState:(GMDPTRViewState)toState fromState:(GMDPTRViewState)fromState animated:(BOOL)animated;

- (void)pullToRefreshView:(GMDPTRView *)view didTransitionToStte:(GMDPTRViewState)toState fromState:(GMDPTRViewState)fromState animated:(BOOL)animated;

@end

@protocol GMDPTRContentView <NSObject>

@required

- (void)setState:(GMDPTRViewState)state withPullToRefreshView:(GMDPTRView *)view;

@optional

- (void)setPullProgress:(CGFloat)pullProgress;

- (void)setLastUpdatedAt:(NSDate *)date withPullToRefreshView:(GMDPTRView *)view;



@end
