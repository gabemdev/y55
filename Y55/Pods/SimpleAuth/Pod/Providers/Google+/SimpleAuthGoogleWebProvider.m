//
//  SimpleAuthGoogleWebProvider.m
//  Pods
//
//  Created by Rockstar. on 12/10/14.
//
//

#import "SimpleAuthGoogleWebProvider.h"
#import "SimpleAuthGoogleWebLoginViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIViewController+SimpleAuthAdditions.h"

@implementation SimpleAuthGoogleWebProvider
#pragma mark - SimpleAuthProvider

+ (NSString *)type {
    return @"google-web";
}


+ (NSDictionary *)defaultOptions {
    
    // Default present block
    SimpleAuthInterfaceHandler presentBlock = ^(UIViewController *controller) {
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
        navigation.modalPresentationStyle = UIModalPresentationFormSheet;
        UIViewController *presented = [UIViewController SimpleAuth_presentedViewController];
        [presented presentViewController:navigation animated:YES completion:nil];
    };
    
    // Default dismiss block
    SimpleAuthInterfaceHandler dismissBlock = ^(id controller) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:[super defaultOptions]];
    options[SimpleAuthPresentInterfaceBlockKey] = presentBlock;
    options[SimpleAuthDismissInterfaceBlockKey] = dismissBlock;
    return options;
}


- (void)authorizeWithCompletion:(SimpleAuthRequestHandler)completion {
    [[[self accessToken]
      flattenMap:^(id responseObject) {
          NSArray *signals = @[
                               [self accountWithAccessToken:responseObject],
                               [RACSignal return:responseObject]
                               ];
          return [self rac_liftSelector:@selector(dictionaryWithAccount:accessToken:) withSignalsFromArray:signals];
      }]
     subscribeNext:^(id responseObject) {
         completion(responseObject, nil);
     }
     error:^(NSError *error) {
         completion(nil, error);
     }];
}

#pragma mark - Private

- (RACSignal *)authorizationCode {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_async(dispatch_get_main_queue(), ^{
            SimpleAuthGoogleWebLoginViewController *login = [[SimpleAuthGoogleWebLoginViewController alloc] initWithOptions:self.options];
            login.completion = ^(UIViewController *login, NSURL *URL, NSError *error) {
                SimpleAuthInterfaceHandler dismissBlock = self.options[SimpleAuthDismissInterfaceBlockKey];
                dismissBlock(login);
                
                // Parse URL
                NSString *fragment = [URL query];
                NSDictionary *dictionary = [CMDQueryStringSerialization dictionaryWithQueryString:fragment];
                NSString *code = dictionary[@"code"];
                
                // Check for error
                if (![code length]) {
                    [subscriber sendError:error];
                    return;
                }
                
                // Send completion
                [subscriber sendNext:code];
                [subscriber sendCompleted];
            };
            
            SimpleAuthInterfaceHandler block = self.options[SimpleAuthPresentInterfaceBlockKey];
            block(login);
        });
        return nil;
    }];
}


- (RACSignal *)accessTokenWithAuthorizationCode:(NSString *)code {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // Build request
        NSDictionary *parameters = @{
                                     @"code" : code,
                                     @"client_id" : self.options[@"client_id"],
                                     @"client_secret" : self.options[@"client_secret"],
                                     @"redirect_uri" : self.options[@"redirect_uri"],
                                     @"grant_type" : @"authorization_code"
                                     };
        NSString *query = [CMDQueryStringSerialization queryStringWithDictionary:parameters];
        NSURL *URL = [NSURL URLWithString:@"https://api.linkedin.com/uas/oauth2/accessToken"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
        
        // Run request
        [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)];
                                   NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                   if ([indexSet containsIndex:statusCode] && data) {
                                       NSError *parseError = nil;
                                       NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                       if (dictionary) {
                                           [subscriber sendNext:dictionary];
                                           [subscriber sendCompleted];
                                       }
                                       else {
                                           [subscriber sendError:parseError];
                                       }
                                   }
                                   else {
                                       [subscriber sendError:connectionError];
                                   }
                               }];
        
        return nil;
    }];
}


- (RACSignal *)accessToken {
    return [[self authorizationCode] flattenMap:^(id responseObject) {
        return [self accessTokenWithAuthorizationCode:responseObject];
    }];
}


- (RACSignal *)accountWithAccessToken:(NSDictionary *)accessToken {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *parameters = @{
                                     @"oauth2_access_token" : accessToken[@"access_token"],
                                     @"format" : @"json"
                                     };
        // field_selectors control the fields that LinkedIn returns for the user object. If none specified, LinkedIn returns a minimal set.
        NSString *URLString;
        if (self.options[@"field_selectors"])
        {
            URLString =  [NSString stringWithFormat:
                          @"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,headline,picture-urls::(original),picture-url,formatted-name,current-share,network,phone-numbers,date-of-birth)?%@",
                          [CMDQueryStringSerialization queryStringWithDictionary:parameters]];
        }
        else
        {
            URLString =  [NSString stringWithFormat:
                          @"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,headline,picture-urls::(original),picture-url,formatted-name,current-share,network,date-of-birth)?%@",
                          [CMDQueryStringSerialization queryStringWithDictionary:parameters]];
        }
        NSURL *URL = [NSURL URLWithString:URLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)];
                                   NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                   if ([indexSet containsIndex:statusCode] && data) {
                                       NSError *parseError = nil;
                                       NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                       if (dictionary) {
                                           [subscriber sendNext:dictionary];
                                           [subscriber sendCompleted];
                                       }
                                       else {
                                           [subscriber sendError:parseError];
                                       }
                                   }
                                   else {
                                       [subscriber sendError:connectionError];
                                   }
                               }];
        return nil;
    }];
}


- (NSDictionary *)dictionaryWithAccount:(NSDictionary *)account accessToken:(NSDictionary *)accessToken {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    // Provider
    dictionary[@"provider"] = [[self class] type];
    
    // Credentials
    NSTimeInterval expiresAtInterval = [accessToken[@"expires_in"] doubleValue];
    NSDate *expiresAtDate = [NSDate dateWithTimeIntervalSinceNow:expiresAtInterval];
    dictionary[@"credentials"] = @{
                                   @"token" : accessToken[@"access_token"],
                                   @"expires_at" : expiresAtDate
                                   };
    
    // User ID
    //dictionary[@"uid"] = account[@"id"];
    
    
    // Raw response
    dictionary[@"raw_info"] = account;
    NSLog(@"%@",account[@"pictureUrls"][@"values"]);
    NSLog(@"2: %@", account[@"pictureUrls"]);
    NSLog(@"3: %@", account[@"values"]);
    
    // User info
    NSMutableDictionary *user = [NSMutableDictionary new];
    user[@"nickname"] = account[@"firstName"];
    user[@"last_name"] = account[@"lastName"];
    user[@"description"] = account[@"headline"];
    user[@"name"] = account[@"formattedName"];
    user[@"image"] = account[@"pictureUrl"];
    dictionary[@"info"] = user;
    
    return dictionary;
    
}

@end