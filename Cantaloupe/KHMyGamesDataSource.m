//
//  KHMyGamesDataSource.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHMyGamesDataSource.h"

// Networking

static NSString *const KHkMyGamesUrl = @"http://itch.io/api/1/%@/my-games";

@interface KHMyGamesDataSource()

@property (nonatomic, strong) NSString *key;

@end

@implementation KHMyGamesDataSource

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
