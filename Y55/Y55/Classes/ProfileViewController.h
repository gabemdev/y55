//
//  ProfileViewController.h
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIScrollViewDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIImageView *profileImage;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UITextView *aboutLabel;
@property (nonatomic) UIButton *urlButton;
@property (nonatomic) UIButton *logoutButton;

@end
