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
    if ([self _validateUsername:username password:password]) {
        [self.loginService loginWithUsername:username password:password];
    } else {
        [self _blankFields];
    }
}

- (BOOL)_validateUsername:(NSString *)username password:(NSString *)password {
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)_blankFields {
    NSString *title = NSLocalizedString(@"Sorry", nil);
    NSString *description = NSLocalizedString(@"Username and password cannot be blank.", nil);
    [self.delegate loginFailedWithErrorTitle:title errorDescription:description];
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
    DDLogError(@"Error: %@", error.debugDescription);
    if (error.code == NSURLErrorCannotConnectToHost) {
        [self.delegate loginFailedWithErrorTitle:NSLocalizedString(@"No Internet", nil) errorDescription:NSLocalizedString(@"Please connect to the Internet, then try again.", nil)];
    } else {
        [self _genericLoginFailed];
    }
}

- (void)loginFailedWithErrors:(NSArray *)errors {
    DDLogError(@"Errors: %@", errors);
    [self _genericLoginFailed];
}

- (void)_genericLoginFailed {
    [self.delegate loginFailedWithErrorTitle:NSLocalizedString(@"Sorry", nil) errorDescription:NSLocalizedString(@"Something went wrong", nil)];
    
}

@end
