//
//  KHLoginManagerDelegate.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/10/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KHLoginManagerDelegate <NSObject>

- (void)loginCompleted;
- (void)loginFailedWithErrorTitle:(NSString *)title errorDescription:(NSString *)errorDescription;

@end
