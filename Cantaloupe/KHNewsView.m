//
//  KHNewsView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsView.h"

@interface KHNewsView()

@property (nonatomic, strong) NSDictionary *news;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *text;

@end

@implementation KHNewsView

- (id)initWithFrame:(CGRect)frame news:(NSDictionary *)news {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.news = news;
        
        self.title = [[UILabel alloc] init];
        self.title.text = [self.news objectForKey:@"title"];
        [self addSubview:self.title];
        
        self.text = [[UILabel alloc] init];
        self.text.text = [self.news objectForKey:@"body"];
        [self addSubview:self.text];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.title sizeToFit];
    
    CGRect titleFrame = self.title.frame;
    titleFrame.origin.x = 0;
    titleFrame.origin.y = 50;
    self.title.frame = titleFrame;
    
    [self.text sizeToFit];
    CGRect textFrame = self.text.frame;
    textFrame.origin.x = 0;
    textFrame.origin.y = CGRectGetHeight(titleFrame) + 10.0f;
    self.text.frame = textFrame;
}
@end
