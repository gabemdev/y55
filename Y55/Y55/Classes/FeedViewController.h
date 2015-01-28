//
//  FeedViewController.h
//  Y55
//
//  Created by Rockstar. on 12/10/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface FeedViewController : MainViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *table;
@property (nonatomic) NSArray *items;


@end
