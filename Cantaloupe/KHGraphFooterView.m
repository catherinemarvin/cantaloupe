//
//  KHGraphFooterView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/2/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGraphFooterView.h"

@interface KHGraphFooterView()

@property (nonatomic, strong) UIView *topSeparatorView;

@end


@implementation KHGraphFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.footerSeparatorColor = nil;
        
        self.topSeparatorView = [[UIView alloc] init];
        self.topSeparatorView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.topSeparatorView];
        
        self.leftLabel = [[UILabel alloc] init];
        self.leftLabel.adjustsFontSizeToFitWidth = YES;
        self.leftLabel.font = [UIFont fontWithName:@"Lato-Regular" size:10.0f];
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        self.leftLabel.textColor = [UIColor whiteColor];
        self.leftLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.adjustsFontSizeToFitWidth = YES;
        self.rightLabel.font = [UIFont fontWithName:@"Lato-Regular" size:10.0f];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.textColor = [UIColor whiteColor];
        self.rightLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.rightLabel];
    }
    return self;
}

@end
