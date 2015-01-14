//
//  KHNewsView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsView.h"

@interface KHNewsView()

@property (nonatomic, strong) UIWebView *newsView;

@end

@implementation KHNewsView

- (id)initWithFrame:(CGRect)frame news:(NSString *)newsUrlString {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _newsView = [[UIWebView alloc] init];
        
        NSURL *url = [NSURL URLWithString:newsUrlString];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        [_newsView loadRequest:requestObj];
        [self addSubview:_newsView];
        
        [_newsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
