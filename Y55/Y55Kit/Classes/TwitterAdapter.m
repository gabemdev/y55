//
//  TwitterAdapter.m
//  Y55
//
//  Created by Rockstar. on 11/29/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "TwitterAdapter.h"

@implementation TwitterAdapter

- (void)accessTwitterAccountWithUser:(TWTRUser *)user {
    
    [[[Twitter sharedInstance] APIClient] loadUserWithID:[_mainSession userID] completion:^(TWTRUser *user, NSError *error) {
        if (user) {
            NSString *userString = @"https://api.twitter.com/1.1/users/show.json";
            NSDictionary* params = @{@"screen_name" : [user screenName]};
            NSError *error;
            NSURLRequest *request = [[[Twitter sharedInstance] APIClient] URLRequestWithMethod:@"GET"
                                                                                           URL:userString
                                                                                    parameters:params
                                                                                         error:&error];
            
            if (request) {
                [[[Twitter sharedInstance] APIClient] sendTwitterRequest:request
                                                              completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                                                  if (data) {
                                                                      NSError *jsonError;
                                                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                           options:0
                                                                                                                             error:&jsonError];
                                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                                          NSLog(@"%@", json);
                                                                          
                                                                      });
                                                                  } else {
                                                                      NSLog(@"Error: %@", connectionError);
                                                                  }
                                                              }];
            } else {
                NSLog(@"Error: %@", error);
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    
}

- (void)getTwitterProfileWithCompletion:(void (^)(NSDictionary* jsonResponse))completion
{
   _mainSession = [AppDelegate sharedAppDelegate].mainSession;
    _mainUser = [AppDelegate sharedAppDelegate].mainUser;
    if (!_mainSession) {
        [self accessTwitterAccountWithUser:_mainUser];
    }
    
    
}

@end
