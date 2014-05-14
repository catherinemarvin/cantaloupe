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
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.imageView.layer setBackgroundColor:[UIColor blackColor].CGColor];
        [self.imageView.layer setOpacity:0.9];
        [self.imageView setClipsToBounds:YES];
        
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.origin.y / 2, self.bounds.size.width, 20)];
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        self.titleLabel.textColor = [UIColor whiteColor];
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
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
