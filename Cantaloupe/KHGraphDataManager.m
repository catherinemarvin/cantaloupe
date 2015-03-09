//
//  KHGraphDataManager.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 2/3/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHGraphDataManager.h"

// Model
#import "KHGraphPoint.h"

// Networking
#import <AFNetworking/AFNetworking.h>

// Helper
#import "KHSessionController.h"

@interface KHGraphDataManager()

@property (nonatomic, assign) NSInteger numberOfDays;
@property (nonatomic, weak) id<KHGraphDataManagerDelegate> delegate;

@end

static const int ddLogLevel = LOG_LEVEL_ALL;

static const NSInteger KHkDefaultNumberOfDays = 30;

@implementation KHGraphDataManager

- (instancetype)initWithDelegate:(id<KHGraphDataManagerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _numberOfDays = KHkDefaultNumberOfDays;
    }
    return self;
}

- (void)requestGraphData {
    NSString *key = [KHSessionController sharedInstance].key;
                     
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://itch.io/api/1/%@/my-games/graphs?num_days=%ld", key, self.numberOfDays];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        [self _processGraphData:responseDict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Error: %@", error);
    }];
}

- (void)_processGraphData:(NSDictionary *)graphData {
    NSMutableDictionary *response = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < KHGraphTypeCount; i++) {
        KHGraphType graphType = (KHGraphType)i;
        NSString *key = [self graphTypeToResponseKey:graphType];
        NSArray *data = [graphData valueForKey:[self graphTypeToResponseKey:graphType]];
        NSMutableArray *newData = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            KHGraphPoint *graphPoint = [[KHGraphPoint alloc] initWithGraphDictionary:dict];
            [newData addObject:graphPoint];
        }
        [response setValue:newData forKey:key];
    }
    [self.delegate receivedGraphData:response];
}

- (NSString *)graphTypeToResponseKey:(KHGraphType)graphType {
    switch (graphType) {
        case KHGraphTypeDownloads: {
            return @"downloads";
            break;
        }
        case KHGraphTypeViews: {
            return @"views";
            break;
        }
        case KHGraphTypePurchases: {
            return @"purchases";
            break;
        }
        default: {
            return @"";
            break;
        }
    }
}

@end
