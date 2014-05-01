//
//  KHGraphDetailView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/30/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGraphDetailView.h"

@interface KHGraphDetailView ()

@property (nonatomic, strong) UILabel *yValue;

@end

@implementation KHGraphDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.yValue = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.yValue];
    }
    return self;
}

- (void)updateDetail:(NSString *)yValue {
    self.yValue.text = yValue;
    [self.yValue sizeToFit];
}

@end
