//
//  KHGraphFooterView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/2/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGraphFooterView.h"

@interface KHGraphFooterView()

@property (nonatomic, strong) UIView *topSeparatorView;

@end


@implementation KHGraphFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.footerSeparatorColor = nil;
        
    }
    return self;
}

@end
