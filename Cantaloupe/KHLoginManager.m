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

// Keychain
#import <SSKeychain.h>

// Logging

static const int ddLogLevel = LOG_LEVEL_ALL;

@interface KHLoginManager()<KHLoginServiceDelegate>

@property (nonatomic, weak) id<KHLoginManagerDelegate>delegate;
@property (nonatomic, strong) KHLoginService *loginService;

@property (nonatomic, strong) NSString *username;

@end

static NSString *const KHkKeychainServiceKey = @"com.khwang.Cantaloupe";
static NSString *const KhkUserKey = @"kCantaloupeCurrentUser";

@implementation KHLoginManager

- (instancetype)initWithDelegate:(id<KHLoginManagerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _loginService = [[KHLoginService alloc] initWithDelegate:self];
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    self.username = username;
    [self.loginService loginWithUsername:username password:password];
}

#pragma mark - KHLoginServiceDelegate

- (void)loginSucceededWithKey:(NSString *)key {
    // Save to session controller
    [KHSessionController sharedInstance].key = key;
    
    // Save username in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.username forKey:KhkUserKey];
    [defaults synchronize];
    
    // Save key in keychain
    NSError *error = nil;
    if ([SSKeychain setPassword:key forService:KHkKeychainServiceKey account:self.username error:&error]) {
    } else {
        DDLogError(@"Failed to set key: %@", error.debugDescription);
    }
    
    
    [self.delegate loginCompleted];
}

- (void)loginFailedWithError:(NSError *)error {
}

- (void)loginFailedWithErrors:(NSArray *)errors {
}

@end
