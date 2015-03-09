//
//  KHGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/28/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGameViewCell.h"
#import "KHGameInfo.h"

@interface KHGameViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KHGameViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.imageView setClipsToBounds:YES];
        UIView *shadow = [[UIView alloc] initWithFrame:self.imageView.bounds];
        shadow.backgroundColor = [UIColor blackColor];
        [shadow.layer setOpacity:0.5];
        [self.imageView addSubview:shadow];
        
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, floorf(self.bounds.origin.y / 2), self.bounds.size.width - 10.0f, 20)];
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configureWithGameInfo:(KHGameInfo *)gameInfo {
    self.imageView.image = gameInfo.coverImage;
    self.titleLabel.text = gameInfo.titleString;
}

@end
