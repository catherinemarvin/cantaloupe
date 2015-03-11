//
//  KHLoginManager.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/10/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHLoginManager.h"

// Service
#import "KHLoginService.h"

// SessionManager
#import "KHSessionController.h"

@interface KHLoginManager()<KHLoginServiceDelegate>

@property (nonatomic, weak) id<KHLoginManagerDelegate>delegate;
@property (nonatomic, strong) KHLoginService *loginService;

@end

@implementation KHLoginManager

- (instancetype)initWithDelegate:(id<KHLoginManagerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _loginService = [[KHLoginService alloc] initWithDelegate:self];
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    [self.loginService loginWithUsername:username password:password];
}

#pragma mark - KHLoginServiceDelegate

- (void)loginSucceededWithKey:(NSString *)key {
    [KHSessionController sharedInstance].key = key;
    [self.delegate loginCompletedWithKey:key];
}

- (void)loginFailedWithError:(NSError *)error {
    [self.delegate loginFailedWithError:error];
}

- (void)loginFailedWithErrors:(NSArray *)errors {
    [self.delegate loginFailedWithErrors:errors];
}

@end
