//
//  KHSessionController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/1/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHSessionController.h"
#import "SSKeychain.h"

@interface KHSessionController()

@property (atomic, assign) BOOL loggedIn;
@property (nonatomic, strong) NSString *key;

@end

static NSString *kKeychainServiceKey = @"com.khwang.Cantaloupe";
static NSString *kUserKey = @"kCantaloupeCurrentUser";

@implementation KHSessionController

#pragma mark - Singleton
+ (KHSessionController *)sharedInstance {
    static KHSessionController *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

#pragma mark - NSObject
- (id) init {
    if (self = [super init]) {
        self.loggedIn = [self _restoreSession];
    }
    return self;
}

#pragma mark - Session control

- (NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserKey];
}

- (BOOL)_restoreSession {
    BOOL success = NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:kUserKey];
    
    if (username) {
        NSError *error = nil;
        NSString *key = [SSKeychain passwordForService:kKeychainServiceKey account:username error:&error];
        if (key && !error) {
            success = YES;
            self.key = key;
        } else {
            NSLog(@"Failed to query session key: %@", error.debugDescription);
        }
    }
    return success;
}

- (void)logout {
    NSError *error;
    if (![SSKeychain deletePasswordForService:kKeychainServiceKey account:self.key error:&error] || error) {
        NSLog(@"Failed to logout: %@", error.debugDescription);
    }
    self.key = nil;
    self.loggedIn = NO;
    
}


@end
