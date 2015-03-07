//
//  KHMyGamesServiceDelegate.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHMyGamesServiceDelegate <NSObject>

/// @brief API Errors
- (void)gamesFetchErrors:(NSArray *)errors;

/// @brief NSError
- (void)gamesFetchError:(NSError *)error;

/// @brief Array of KHGameInfo objects
- (void)gamesFetched:(NSArray *)games;

@end
