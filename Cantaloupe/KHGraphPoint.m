//
//  KHGraphPoint.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/20/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHGraphPoint.h"

@interface KHGraphPoint ()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, assign, readwrite) NSUInteger count;
@property (nonatomic, strong, readwrite) NSDate *date;

@end

static NSString *const KHkCountKey = @"count";
static NSString *const KHkDateKey = @"date";

@implementation KHGraphPoint

- (instancetype)initWithGraphDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _dictionary = dictionary;
    }
    return self;
}

#pragma mark - Public helpers

- (NSString *)dateString {
    return [self.dictionary objectForKey:KHkDateKey];
}

#pragma mark - Lazy Instantiation

- (NSUInteger)count {
    if (!_count) {
        _count = [[self.dictionary objectForKey:KHkCountKey] unsignedIntegerValue];
    }
    return _count;
}

- (NSDate *)date {
    if (!_date) {
        NSString *dateString = [self dateString];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        _date = [formatter dateFromString:dateString];
    }
    return _date;
}


@end
