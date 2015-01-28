//
//  FeedCell.h
//  Y55
//
//  Created by Rockstar. on 1/27/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (nonatomic) UILabel *fromTitle;
@property (nonatomic) UILabel *notificationTitle;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UIImageView *cellImage;
@property (nonatomic) UIImageView *notificationIcon;
//@property (nonatomic) UIView *notification;

@end
