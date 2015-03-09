//
//  KHMyGamesDataSource.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHMyGamesDataSource.h"

// Games Service
#import "KHMyGamesService.h"

@interface KHMyGamesDataSource()<KHMyGamesServiceDelegate>

@property (nonatomic, strong) KHMyGamesService *service;
@property (nonatomic, strong) NSArray *games;
@property (nonatomic, weak) id<KHMyGamesDataSourceDelegate>delegate;

@end

@implementation KHMyGamesDataSource

- (instancetype)initWithDelegate:(id<KHMyGamesDataSourceDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _service = [[KHMyGamesService alloc] initWithDelegate:self];
        _games = [NSArray array];
    }
    return self;
}

- (void)requestGames {
    [self.service requestGames];
}

- (NSInteger)count {
    return [self.games count];
}

- (KHGameInfo *)infoAtIndex:(NSInteger)index {
    return self.games[index];
}

#pragma mark - KHMYGamesServiceDelegate

- (void)gamesFetched:(NSArray *)games {
    self.games = games;
    [self.delegate gamesFetched];
}

- (void)gamesFetchError:(NSError *)error {
    [self.delegate gameFetchError:error];
}

- (void)gamesFetchErrors:(NSArray *)errors {
    NSLog(@"ItchIO API error");
}

@end
