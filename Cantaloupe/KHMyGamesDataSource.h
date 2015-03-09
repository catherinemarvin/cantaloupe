//
//  KHMyGamesDataSource.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KHMyGamesDataSourceDelegate.h"

@class KHGameInfo;

@interface KHMyGamesDataSource : NSObject

- (instancetype)initWithDelegate:(id<KHMyGamesDataSourceDelegate>)delegate;

- (void)requestGames;

- (NSInteger)count;
- (KHGameInfo *)infoAtIndex:(NSInteger)index;

@end
