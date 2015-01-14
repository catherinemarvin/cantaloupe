//
//  KHNewsViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/11/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewCell.h"

@interface KHNewsViewCell ()

@property (nonatomic, strong) NSDictionary *news;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIWebView *previewView;

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
        
        _previewView = [[UIWebView alloc] init];
        _previewView.userInteractionEnabled = NO;
        _previewView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_previewView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self _initializeAutolayout];
    }
    return self;
}

- (void)_initializeAutolayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.and.right.equalTo(self.contentView);
    }];
    
    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self);
    }];
}

- (void)configureWithNews:(NSDictionary *)news {
    self.news = news;
    
    self.titleLabel.text = [self.news objectForKey:@"title"];
    
    NSString *previewHtml = [self.news objectForKey:@"body"];
    [self.previewView loadHTMLString:previewHtml baseURL:nil];
    [self setNeedsLayout];
}

@end
