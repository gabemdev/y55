//
//  GMDPTRView.m
//  GMDPTR
//
//  Created by Rockstar. on 10/23/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "GMDPTRView.h"
#import "GMDPTRSimple.h"

@interface GMDPTRView ()
@property (nonatomic, readwrite) GMDPTRViewState state;
@property (nonatomic, readwrite) UIScrollView *scrollView;
@property (nonatomic, readwrite, getter=isExpanded) BOOL expanded;
@property (nonatomic) CGFloat topInset;
@property (nonatomic) dispatch_semaphore_t animationSemaphore;
@end

@implementation GMDPTRView

@synthesize delegate = _delegate;
@synthesize scrollView = _scrollView;
@synthesize expandedHeight = _expandedHeight;
@synthesize contentView = _contentView;
@synthesize state = _state;
@synthesize expanded = _expanded;
@synthesize defaultContentInset = _defaultContentInset;
@synthesize topInset = _topInset;
@synthesize animationSemaphore = _animationSemaphore;

#pragma mark - Accessors

- (void)setState:(GMDPTRViewState)state {
    BOOL wasLoading = _state == GMDPTRViewStateLoading;
    _state = state;
    
    [self.contentView setState:_state withPullToRefreshView:self];
    
    id<GMDPTRViewDelegate> delegate = self.delegate;
    if (wasLoading && _state != GMDPTRViewStateLoading) {
        if ([delegate respondsToSelector:@selector(pullTorefreshViewDidFinishLoading:)]) {
            [delegate pullTorefreshViewDidFinishLoading:self];
        }
    } else if (!wasLoading && _state == GMDPTRViewStateLoading) {
        [self _setPullProgress: 1.0f];
        if ([delegate respondsToSelector:@selector(pullToRefreshViewDidStartLoading:)]) {
            [delegate pullToRefreshViewDidStartLoading:self];
        }
    }
}

- (void)setExpanded:(BOOL)expanded {
    _expanded = expanded;
    [self _setContentInsetTop:expanded ? self.expandedHeight : 0.0f];
}

- (void)setScrollView:(UIScrollView *)scrollView {
    void *context = (__bridge void *)self;
    if ([_scrollView respondsToSelector:@selector(removeObserver:forKeyPath:context:)]) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:context];
    } else if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    _scrollView = scrollView;
    self.defaultContentInset = _scrollView.contentInset;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
}

- (UIView<GMDPTRContentView> *)contentView {
    if (!_contentView) {
        self.contentView = [[GMDPTRSimple alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

- (void)setContentView:(UIView<GMDPTRContentView> *)contentView {
    [_contentView removeFromSuperview];
    _contentView = contentView;
    
    [_contentView setState:self.state withPullToRefreshView:self];
    [self refreshLastUpdatedAt];
    [self addSubview:_contentView];
}

- (void)setDefaultContentInset:(UIEdgeInsets)defaultContentInset {
    _defaultContentInset = defaultContentInset;
    [self _setContentInsetTop:self.topInset];
}

#pragma mark - NSObject

- (void)dealloc {
    self.scrollView = nil;
    self.delegate = nil;
#if !OS_OBJECT_USE_OBJC
    dispatch_release(_animationSemaphore);
#endif
}

#pragma mark - UIView

- (void)removeFromSuperview {
    self.scrollView = nil;
    [super removeFromSuperview];
}

- (void)layoutSubviews {
    CGSize size = self.bounds.size;
    CGSize contentSize = [self.contentView sizeThatFits:size];
    
    if (contentSize.width < size.width) {
        contentSize.width = size.width;
    }
    
    if (contentSize.height < self.expandedHeight) {
        contentSize.height = self.expandedHeight;
    }
    
    self.contentView.frame = CGRectMake(roundf((size.width - contentSize.width) / 2.0f), size.height - contentSize.height, contentSize.width, contentSize.height);
}

#pragma mark - Initializer

- (instancetype)initWithScrollView:(UIScrollView *)scrollView delegate:(id<GMDPTRViewDelegate>)delegate {
    CGRect frame = CGRectMake(0.0f, 0.0f - scrollView.bounds.size.height, scrollView.bounds.size.width, scrollView.bounds.size.height);
    
    if ((self = [self initWithFrame:frame])) {
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[GMDPTRView class]]) {
                [[NSException exceptionWithName:@"GMDPTRViewAlreadyAdded" reason:@"There is already a GMDPTRView added to this scroll view. Unexpected things will happen. Don't do this." userInfo:nil] raise];
            }
        }
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.scrollView = scrollView;
        self.delegate = delegate;
        self.state = GMDPTRViewStateNormal;
        self.expandedHeight = 70.0f;
        self.defaultContentInset = scrollView.contentInset;
        
        //Add to scroll view
        [self.scrollView addSubview:self];
        
        //Semaphore is used to ensure only one animation plays at a time
        _animationSemaphore = dispatch_semaphore_create(0);
        dispatch_semaphore_signal(_animationSemaphore);
    }
    return self;
}

#pragma mark - Loading

- (void)startLoading {
    [self startLoadingAndExpand:NO animated:NO];
}

- (void)startLoadingAndExpand:(BOOL)shouldExpand animated:(BOOL)animated {
    [self startLoadingAndExpand:shouldExpand animated:animated completion:nil];
}

- (void)startLoadingAndExpand:(BOOL)shouldExpand animated:(BOOL)animated completion:(void (^)())block {
    if (self.state == GMDPTRViewStateLoading) {
        return;
    }
    [self _setState:GMDPTRViewStateLoading animated:animated expanded:shouldExpand completion:block];
}

- (void)finishLoading {
    [self finishLoadingAnimated:YES completion:nil];
}

- (void)finishLoadingAnimated:(BOOL)animated completion:(void (^)())block {
    if (self.state != GMDPTRViewStateLoading) {
        return;
    }
    
    __weak GMDPTRView *blockSelf = self;
    [self _setState:GMDPTRViewStateClosing animated:animated expanded:NO completion:^{
        blockSelf.state = GMDPTRViewStateNormal;
        
        if (block) {
            block();
        }
    }];
    [self refreshLastUpdatedAt];
}

- (void)refreshLastUpdatedAt {
    NSDate *date = nil;
    id<GMDPTRViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(pullToRefreshViewLastUpdatedAt:)]) {
        date = [delegate pullToRefreshViewLastUpdatedAt:self];
    } else {
        date = [NSDate date];
    }
    
    if ([self.contentView respondsToSelector:@selector(setLastUpdatedAt:withPullToRefreshView:)]) {
        [self.contentView setLastUpdatedAt:date withPullToRefreshView:self];
    }
}

#pragma mark - Private

- (void)_setContentInsetTop:(CGFloat)topInset {
    self.topInset = topInset;
    
    UIEdgeInsets inset = self.defaultContentInset;
    
    inset.top += self.topInset;
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.scrollView.contentInset, inset)) {
        return;
    }
    
    self.scrollView.contentInset = inset;
    
    if (self.scrollView.contentOffset.y <= 0.0f) {
        [self.scrollView scrollRectToVisible:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f) animated:NO];
    }
    
    id<GMDPTRViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(pullToRefreshView:disUpdateContentInset:)]) {
        [delegate pullToRefreshView:self disUpdateContentInset:self.scrollView.contentInset];
    }
}

- (void)_setState:(GMDPTRViewState)state animated:(BOOL)animated expanded:(BOOL)expanded completion:(void (^)(void)) completion {
    GMDPTRViewState fromState = self.state;
    
    id delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(pullToRefreshView:willTransitionToState:fromState:animated:)]) {
        [delegate pullToRefreshView:self willTransitionToState:state fromState:fromState animated:animated];
    }
    
    if (!animated) {
        self.state = state;
        self.expanded = expanded;
        
        if (completion) {
            completion();
        }
        
        if ([delegate respondsToSelector:@selector(pullToRefreshView:didTransitionToStte:fromState:animated:)]) {
            [delegate pullToRefreshView:self didTransitionToStte:state fromState:fromState animated:animated];
        }
        return;
    }
    
    __weak GMDPTRView *weakSelf = self;
    dispatch_semaphore_t semaphore = self.animationSemaphore;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 delay: 0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                self.state = state;
                self.expanded = expanded;
            } completion:^(BOOL finished) {
                dispatch_semaphore_signal(semaphore);
                if (completion) {
                    completion();
                }
                if ([delegate respondsToSelector:@selector(pullToRefreshView:didTransitionToStte:fromState:animated:)]) {
                    [delegate pullToRefreshView:weakSelf didTransitionToStte:state fromState:fromState animated:animated];
                }
            }];
        });
    });
}

- (void)_setPullProgress:(CGFloat)pullProgress {
    if (![self.contentView respondsToSelector:@selector(setPullProgress:)]) {
        return;
    }
    
    pullProgress = fmax(0.0f, fminf(pullProgress, 1.0f));
    
    [self.contentView setPullProgress:pullProgress];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context != (__bridge void *)self) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if (object != self.scrollView || ![keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
    
    CGFloat y = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue].y + self.defaultContentInset.top;
    
    if (self.scrollView.isDragging) {
        if (self.state == GMDPTRViewStateReady) {
            if (y > -self.expandedHeight && y < 0.0f) {
                self.state = GMDPTRViewStateNormal;
            }
        } else if (self.state == GMDPTRViewStateNormal)  {
            [self _setPullProgress:-y / self.expandedHeight];
            
            if (y < -self.expandedHeight) {
                self.state = GMDPTRViewStateReady;
            }
        } else if (self.state == GMDPTRViewStateLoading) {
            CGFloat insetAdjustment = y < 0 ? fmaxf(0, self.expandedHeight + y) : self.expandedHeight;
            [self _setContentInsetTop:self.expandedHeight - insetAdjustment];
        }
        return;
    } else if (self.scrollView.isDecelerating) {
        [self _setPullProgress:-y / self.expandedHeight];
    }
    
    if (self.state != GMDPTRViewStateReady) {
        return;
    }
    
    GMDPTRViewState newState = GMDPTRViewStateLoading;
    
    BOOL expand = YES;
    id<GMDPTRViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(pullToRefreshViewShouldStartLoading:)]) {
        if (![delegate pullToRefreshViewShouldStartLoading:self]) {
            newState = GMDPTRViewStateNormal;
            expand = NO;
        }
    }
    
    [self _setState:newState animated:YES expanded:expand completion:nil];
}

@end
