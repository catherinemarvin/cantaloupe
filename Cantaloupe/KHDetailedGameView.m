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
@property (nonatomic, strong) UILabel *publishedLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *earningsLabel;
@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UILabel *purchasesLabel;
@property (nonatomic, strong) UILabel *downloadsLabel;

@end

static CGFloat KHkSideMargin = 10.0f;

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
        self.coverView.contentMode = UIViewContentModeScaleAspectFill;
        [self.coverView setClipsToBounds:YES];
        [self addSubview:self.coverView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = [data valueForKey:@"title"];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        [self addSubview:self.titleLabel];
        
        _publishedLabel = [[UILabel alloc] init];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.text = [data valueForKey:@"short_text"];
        self.descriptionLabel.textColor = [UIColor whiteColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Lato-Italic" size:14.0f];
        [self addSubview:self.descriptionLabel];
        
        self.earningsLabel = [[UILabel alloc] init];
        self.earningsLabel.text = [NSString stringWithFormat: @"%@: %@", NSLocalizedString(@"Earnings", nil), [[data valueForKey:@"earnings"] valueForKey:@"amount_formatted"] ?: NSLocalizedString(@"None", @"Earnings: None")];
        self.earningsLabel.textColor = [UIColor whiteColor];
        self.earningsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [self addSubview:self.earningsLabel];
        
        self.viewsLabel = [[UILabel alloc] init];
        self.viewsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Views", nil), [data valueForKey:@"views_count"]];
        self.viewsLabel.textColor = [UIColor whiteColor];
        self.viewsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [self addSubview:self.viewsLabel];
        
        self.purchasesLabel = [[UILabel alloc] init];
        self.purchasesLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Purchases", nil), [data valueForKey:@"purchases_count"]];
        self.purchasesLabel.textColor = [UIColor whiteColor];
        self.purchasesLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [self addSubview:self.purchasesLabel];
        
        self.downloadsLabel = [[UILabel alloc] init];
        self.downloadsLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Downloads", nil), [data valueForKey:@"downloads_count"]];
        self.downloadsLabel.textColor = [UIColor whiteColor];
        self.downloadsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [self addSubview:self.downloadsLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    CGFloat coverHeight = 200.0f;
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(coverHeight));
        make.top.equalTo(self);
        make.left.and.right.equalTo(self);
    }];
    
    CGFloat verticalOffset = 20.0f;
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(KHkSideMargin);
        make.right.equalTo(self);
        make.top.equalTo(self.coverView.mas_bottom).with.offset(verticalOffset);
    }];
    
    [self.descriptionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(verticalOffset);
    }];
    
    [self.earningsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(verticalOffset);
    }];
    
    [self.viewsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.earningsLabel.mas_bottom);
    }];
    
    [self.purchasesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.viewsLabel.mas_bottom);
    }];
    
    [self.downloadsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.purchasesLabel.mas_bottom);
    }];
    
    [super updateConstraints];
}

@end
