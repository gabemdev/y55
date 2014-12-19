//
//  TwitterAdapter.h
//  Y55
//
//  Created by Rockstar. on 11/29/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#define AccountTwitterAccessGranted @"TwitterAccessGranted"
#define AccountTwitterSelectedIdentifier @"TwitterAccountSelectedIdentifier"

#import <Foundation/Foundation.h>

@interface TwitterAdapter : NSObject

//@property (nonatomic) TWTRSession *mainSession;
//@property (nonatomic) TWTRUser *mainUser;

@property (nonatomic, strong) ACAccount* account;

//- (void)getTwitterProfileWithCompletion:(void (^)(NSDictionary* jsonResponse))completion;
//- (void)accessTwitterAccountWithUser: (TWTRUser *)user;
- (void)accessTwitterAccountWithAccountStore:(ACAccountStore*)accountStore;

//-(void)showError:(NSString*)errorMessage;
//- (void)getTwitterAccountOnCompletion:(void(^)(ACAccount *))completionHandler;


//- (void)getTwitterAccountOnCompletion:(void (^)(ACAccount *))completionHandler;
@end
