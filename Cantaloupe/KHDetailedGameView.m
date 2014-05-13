//
//  KHDetailedGameView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameView.h"

@interface KHDetailedGameView()

@property (nonatomic, strong) NSDictionary *gameData;

@property (nonatomic, strong) UIImageView *coverView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation KHDetailedGameView

- (id)initWithFrame:(CGRect)frame data:(NSDictionary *)data {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.gameData = data;
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data valueForKey:@"cover_url"]]]];
        
        if (!image) {
            image = [UIImage imageNamed:@"placeholder"];
        }
        
        self.coverView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.coverView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = [data valueForKey:@"title"];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.text = [data valueForKey:@"short_text"];
        self.descriptionLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = self.coverView.frame.origin.x;
    titleFrame.origin.y = self.coverView.frame.origin.y + self.coverView.frame.size.height + 10;
    self.titleLabel.frame = titleFrame;
    
    [self.descriptionLabel sizeToFit];
    CGRect descriptionFrame = self.descriptionLabel.frame;
    descriptionFrame.origin.x = self.coverView.frame.origin.x;
    descriptionFrame.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10;
    self.descriptionLabel.frame = descriptionFrame;
    
}

@end
