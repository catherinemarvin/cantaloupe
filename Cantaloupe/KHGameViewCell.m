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
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KHGameViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.origin.y / 2, frame.size.width, 20)];
        [self.contentView addSubview:self.titleLabel];
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
    [self.imageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
