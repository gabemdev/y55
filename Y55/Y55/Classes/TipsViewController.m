//
//  TipsViewController.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "TipsViewController.h"

@interface TipsViewController ()

@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"Tips";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _checkUser];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _checkUser];
}


#pragma mark - Private

- (void)_checkUser {
    TWTRSession *session = [[Twitter sharedInstance] session];
    if (!session) {
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        appDelegate.window.rootViewController = nav;
    }
    return;
}


@end
