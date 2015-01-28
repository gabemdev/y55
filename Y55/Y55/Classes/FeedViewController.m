//
//  FeedViewController.m
//  Y55
//
//  Created by Rockstar. on 12/10/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "FeedViewController.h"
#import "ProfileTest.h"
#import "FeedModel.h"
#import "FeedCell.h"


@interface FeedViewController ()



@end

@implementation FeedViewController
@synthesize table = _table;

#pragma mark - Accessors
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _table.translatesAutoresizingMaskIntoConstraints = NO;
        _table.backgroundColor = [UIColor y55_blueColor];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[FeedCell class] forCellReuseIdentifier:@"Cell"];
        _table.scrollEnabled = YES;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.separatorColor = [UIColor y55_blueColor];
        [_table reloadData];
    }
    return _table;
}


#pragma mark - NSObject
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feed";
    [self.view addSubview:self.table];
    [self layoutConstraints];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCells];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - Configuration
- (CGFloat)verticalSpacing {
    return 16.0;
}



- (void)layoutConstraints {
    CGFloat verticalSpacing = self.verticalSpacing;
    
    NSDictionary *viewDict = @{@"table": _table};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[table]|"
                                                                      options:kNilOptions metrics:nil
                                                                        views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[table]|"
                                                                      options:kNilOptions metrics:nil
                                                                        views:viewDict]];

}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    FeedCell *cell = (FeedCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor lightTextColor];
    }
    
    FeedModel *model = (self.items)[indexPath.row];
    
    [cell.fromTitle setText:model.fromTitle];
    [cell.notificationTitle setText:model.notificationTitle];
    cell.cellImage.image = [UIImage imageNamed:model.cellImage];
    [cell.timeLabel setText:model.time];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)getCells {
    FeedModel *one = [[FeedModel alloc] init];
    FeedModel *two = [[FeedModel alloc] init];
    FeedModel *three = [[FeedModel alloc] init];
    FeedModel *four = [[FeedModel alloc] init];
    
    [one initWithTitle:@"Richard"
             cellImage:@"no-user"
      notificationIcon:@"email"
     notificationTitle:@"has sent you a private message!"
     notificationColor:@"green"
               andTime:@"@11:41am Today"];
    
    [two initWithTitle:@"Gabriel"
             cellImage:@"no-user"
      notificationIcon:@"email"
     notificationTitle:@"has sent you a private message!"
     notificationColor:@"green"
               andTime:@"@11:38am Today"];
    
    [three initWithTitle:@"Jessica"
               cellImage:@"no-user"
        notificationIcon:@"exclamation"
       notificationTitle:@"needs your help"
       notificationColor:@"red"
                 andTime:@"@ 1:56pm Sunday"];
    
    [four initWithTitle:@"Melinda"
              cellImage:@"no-user"
       notificationIcon:@"check"
      notificationTitle:@"Accepted your gift!"
      notificationColor:@"orange"
                andTime:@"@5:41pm Monday"];
    
    self.items = @[one, two, three, four];
}

@end
