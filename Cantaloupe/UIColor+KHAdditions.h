//
//  UIColor+KHAdditions.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/22/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KHAdditions)

#pragma mark - Helper

+ (UIColor *)colorFromHexString:(NSString *)colorString;

#pragma mark - Styling
+ (UIColor *)textColor;
+ (UIColor *)subtextColor;
+ (UIColor *)borderColor;
+ (UIColor *)darkBackgroundTextColor;
+ (UIColor *)linkColor;
+ (UIColor *)buyColor;

@end
