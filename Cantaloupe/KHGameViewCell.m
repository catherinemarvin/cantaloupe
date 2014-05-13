//
//  KHGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/28/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGameViewCell.h"

@interface KHGameViewCell()

@property (nonatomic, strong) UILabel *titleView;

@end

@implementation KHGameViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleView = [[UILabel alloc] init];
        self.titleView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.titleView];
    }
    return self;
}
- (void)setTitleText:(NSString *)title {
    self.titleView.text = title;
    [self.titleView sizeToFit];
}

@end
