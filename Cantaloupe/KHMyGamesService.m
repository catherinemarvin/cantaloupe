//
//  KHMyGamesService.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHMyGamesService.h"

// Models
#import "KHGameInfo.h"

// Network Requests
#import <AFNetworking.h>
#import "KHSessionController.h"

@interface KHMyGamesService()

@property (nonatomic, weak)id<KHMyGamesServiceDelegate>delegate;

@end

static NSString *const KHkMyGamesUrl = @"http://itch.io/api/1/%@/my-games";
static NSString *const KhkApiErrorKey = @"errors";
static NSString *const KhkApiGamesKey = @"games";

@implementation KHMyGamesService

- (instancetype)initWithDelegate:(id<KHMyGamesServiceDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)requestGames {
    NSString *key = [KHSessionController sharedInstance].key;
    NSString *url = [NSString stringWithFormat:KHkMyGamesUrl, key];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NSArray *errors = [responseDict valueForKey:KhkApiErrorKey];
            if (errors) {
                [self.delegate gamesFetchErrors:errors];
                return;
            }
            NSArray *games = [responseDict valueForKey:KhkApiGamesKey];
            NSMutableArray *processedGames = [NSMutableArray array];
            for (NSDictionary *game in games) {
                KHGameInfo *gameInfo = [[KHGameInfo alloc] initWithGameDictionary:game];
                [processedGames addObject:gameInfo];
            }
            [self.delegate gamesFetched:processedGames];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate gamesFetchError:error];
    }];
}

@end
