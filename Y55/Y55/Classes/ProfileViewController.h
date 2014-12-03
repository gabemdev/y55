//
//  ProfileViewController.h
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIScrollViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) UIImageView *profileImage;
@property (nonatomic, copy) UIImageView *bannerImage;
@property (nonatomic, copy) UILabel *followers;
@property (nonatomic, copy) UILabel *followersCount;
@property (nonatomic, copy) UILabel *following;
@property (nonatomic, copy) UILabel *followingCount;
@property (nonatomic, copy) UILabel *userNameLabel;
@property (nonatomic) UITextView *aboutLabel;
@property (nonatomic) UIButton *logoutButton;
@property (nonatomic, copy) UILabel *nameLabel;

@end
