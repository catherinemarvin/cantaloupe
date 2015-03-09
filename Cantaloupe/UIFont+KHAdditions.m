//
//  UIFont+KHAdditions.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/9/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "UIFont+KHAdditions.h"

static NSString *const KHkRegularFontName = @"Lato-Regular";

@implementation UIFont (KHAdditions)

+ (UIFont *)regularWithSize:(CGFloat)size {
    return [UIFont fontWithName:KHkRegularFontName size:size];
}

@end
