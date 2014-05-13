//
//  KHGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/28/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGameViewCell.h"

@interface KHGameViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation KHGameViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 100.0f)];
        self.imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setGameImage:(NSString *)url {
    
    UIImage *image;
    if (url) {
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    } else {
        image = [UIImage imageNamed:@"placeholder"];
    }
    self.imageView.image = image;
}

@end
