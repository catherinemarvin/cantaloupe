//
//  KHGraphPoint.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/20/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHGraphPoint : NSObject

- (instancetype)initWithGraphDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) NSDate *date;

- (NSString *)dateString;

@end
