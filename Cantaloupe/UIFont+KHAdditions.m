//
//  UIFont+KHAdditions.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/9/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "UIFont+KHAdditions.h"

static NSString *const KHkRegularFontName = @"Lato-Regular";
static NSString *const KhkBoldFontName = @"Lato-Bold";

@implementation UIFont (KHAdditions)

+ (UIFont *)regularWithSize:(CGFloat)size {
    return [UIFont fontWithName:KHkRegularFontName size:size];
}

+ (UIFont *)boldWithSize:(CGFloat)size {
    return [UIFont fontWithName:KhkBoldFontName size:size];
}

@end
