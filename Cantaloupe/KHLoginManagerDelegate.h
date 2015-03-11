//
//  KHLoginManagerDelegate.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/10/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHLoginManagerDelegate <NSObject>

- (void)loginCompletedWithKey:(NSString *)key;
- (void)loginFailedWithError:(NSError *)error;
- (void)loginFailedWithErrors:(NSArray *)errors;

@end
