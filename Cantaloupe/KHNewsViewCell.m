//
//  KHNewsViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/11/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewCell.h"

@interface KHNewsViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSDictionary *news;

@end

@implementation KHNewsViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self _initializeAutolayout];
    }
    return self;
}

- (void)_initializeAutolayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
}

- (void)configureWithNews:(NSDictionary *)news {
    self.news = news;
    
    self.titleLabel.text = [self.news objectForKey:@"title"];
    [self setNeedsLayout];
}

@end
