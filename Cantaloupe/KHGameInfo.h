//
//  KHGameInfo.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/17/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHGameInfo : NSObject

- (instancetype)initWithGameDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) UIImage *coverImage;
@property (nonatomic, strong, readonly) NSString *titleString;
@property (nonatomic, strong, readonly) NSString *shortDescription;
@property (nonatomic, strong, readonly) NSString *formattedEarnings;

@property (nonatomic, assign, readonly) NSUInteger views;
@property (nonatomic, assign, readonly) NSUInteger purchases;
@property (nonatomic, assign, readonly) NSUInteger downloads;


@end
