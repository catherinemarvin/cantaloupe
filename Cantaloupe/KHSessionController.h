//
//  KHSessionController.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/1/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHSessionController : NSObject

@property (atomic, readonly) BOOL loggedIn;
@property (nonatomic, strong) NSString *key;

+ (KHSessionController *)sharedInstance;
- (void)logout;
- (NSString *)username;

@end
