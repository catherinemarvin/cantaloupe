//
//  KHMyGamesDataSourceDelegate.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHMyGamesDataSourceDelegate <NSObject>

/// @brief Called when the data source updates itself
- (void)gamesFetched;

/// @brief Called to indicate some kind of error
- (void)gameFetchError:(NSError *)error;

@end
