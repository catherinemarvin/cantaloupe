//
//  KHLoginService.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/10/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHLoginServiceDelegate.h"

@interface KHLoginService : NSObject

- (instancetype)initWithDelegate:(id<KHLoginServiceDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;

@end
