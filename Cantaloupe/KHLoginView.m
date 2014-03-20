//
//  KHLoginView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/19/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHLoginView.h"

@interface KHLoginView()

@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation KHLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loginButton = [[UIButton alloc] init];
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self addSubview:self.loginButton];
    }
    return self;
}

- (void)layoutSubviews {
    [self.loginButton sizeToFit];
}

@end
