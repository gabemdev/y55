//
//  SimpleAuthGoogleWebLoginViewController.m
//  Pods
//
//  Created by Rockstar. on 12/10/14.
//
//

#import "SimpleAuthGoogleWebLoginViewController.h"

@interface SimpleAuthGoogleWebLoginViewController ()

@end

@implementation SimpleAuthGoogleWebLoginViewController

#pragma mark - SimpleAuthWebViewController

- (instancetype)initWithOptions:(NSDictionary *)options requestToken:(NSDictionary *)requestToken {
    if ((self = [super initWithOptions:options requestToken:requestToken])) {
        self.title = @"Google+";
    }
    return self;
}


- (NSURLRequest *)initialRequest {
    NSDictionary *parameters = @{
                                 @"client_id" : self.options[@"client_id"],
                                 @"redirect_uri" : self.options[SimpleAuthRedirectURIKey],
                                 @"response_type" : @"code",
                                 @"state" : [[NSProcessInfo processInfo] globallyUniqueString]
                                 };
    
    NSString *URLString = [NSString stringWithFormat:
                           @"https://accounts.google.com/o/oauth2/auth?%@",
                           [CMDQueryStringSerialization queryStringWithDictionary:parameters]];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    return [NSURLRequest requestWithURL:URL];
}

@end
