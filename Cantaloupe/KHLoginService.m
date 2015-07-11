//
//  KHLoginService.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/10/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHLoginService.h"

// Networking
#import <AFNetworking.h>

@interface KHLoginService()

@property (nonatomic, weak) id<KHLoginServiceDelegate>delegate;

@end

static NSString *const KHkLoginApiEndpoint = @"https://itch.io/api/1/login";
static NSString *const KhkUsernameKey = @"username";
static NSString *const KhkPasswordKey = @"password";

// Itch API requires the source be android
static NSString *const KhkSourceKey = @"source";
static NSString *const KhkSourceValue = @"android";

static NSString *const KhkResponseErrorsKey = @"errors";
static NSString *const KhkResponseKeyKey = @"key";

@implementation KHLoginService

- (instancetype)initWithDelegate:(id<KHLoginServiceDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:username forKey:KhkUsernameKey];
    [params setValue:password forKey:KhkPasswordKey];
    [params setValue:KhkSourceValue forKey:KhkSourceKey];
    [manager POST:KHkLoginApiEndpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NSArray *errors = [responseDict valueForKey:KhkResponseErrorsKey];
            
            if (errors) {
                [self.delegate loginFailedWithErrors:errors];
                return;
            }
            NSString *key = [[responseDict valueForKey:KhkResponseKeyKey] valueForKey:KhkResponseKeyKey];
            [self.delegate loginSucceededWithKey:key];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate loginFailedWithError:error];
    }];
}

@end
