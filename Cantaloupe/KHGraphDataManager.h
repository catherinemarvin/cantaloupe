//
//  KHGraphDataManager.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 2/3/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHGraphDataManagerDelegate.h"

typedef NS_ENUM(NSUInteger, KHGraphType) {
    KHGraphTypeViews,
    KHGraphTypePurchases,
    KHGraphTypeDownloads,
    KHGraphTypeCount
};

@interface KHGraphDataManager : NSObject

@property (nonatomic, assign, readonly) NSInteger numberOfDays;

- (instancetype)initWithDelegate:(id<KHGraphDataManagerDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)requestGraphData;

- (NSString *)graphTypeToResponseKey:(KHGraphType)graphType;

@end
