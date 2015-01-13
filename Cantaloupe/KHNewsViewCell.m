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
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [self.titleLabel sizeToFit];
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = 0;
    titleFrame.origin.y = 0;
    self.titleLabel.frame = titleFrame;
}

- (void)configureWithNews:(NSDictionary *)news {
    self.news = news;
    
    self.titleLabel.text = [self.news objectForKey:@"title"];
    [self setNeedsLayout];
}

@end
