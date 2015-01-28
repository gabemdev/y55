//
//  FeedModel.h
//  Y55
//
//  Created by Rockstar. on 1/26/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedModel : NSObject

+ (FeedModel *)sharedInstance;

@property (nonatomic) NSString *fromTitle;
@property (nonatomic) NSString *notificationTitle;
@property (nonatomic) NSString *cellImage;
@property (nonatomic) NSString *notificationColor;
@property (nonatomic) NSString *userImage;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *notificationIcon;

@property (nonatomic, assign) NSInteger titleCount;
@property (nonatomic, strong) NSMutableArray *tableArray;

- (instancetype) initWithDetailView:(NSString *)plistName NS_DESIGNATED_INITIALIZER;

- (void)initWithDictionary:(NSDictionary *)dictionary;

- (void)initWithTitle:(NSString *)fromTitle
            cellImage:(NSString *)cellImage
     notificationIcon:(NSString *)notificationIcon
    notificationTitle:(NSString *)notificationTitle
    notificationColor:(NSString *)notificationColor
              andTime:(NSString *)time;


@end
