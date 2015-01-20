//
//  KHDetailedGameView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameView.h"
#import "KHGameInfo.h"

@interface KHDetailedGameView()

@property (nonatomic, strong) KHGameInfo *gameData;

@property (nonatomic, strong) UIImageView *coverView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *publishedLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIView *statsRow;
@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UILabel *purchasesLabel;
@property (nonatomic, strong) UILabel *downloadsLabel;

@property (nonatomic, strong) UILabel *earningsLabel;
@end

static CGFloat KHkSideMargin = 10.0f;

@implementation KHDetailedGameView

- (instancetype)initWithFrame:(CGRect)frame data:(KHGameInfo *)data {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _gameData = data;
        
        self.backgroundColor = [UIColor blackColor];
        
        self.coverView = [[UIImageView alloc] initWithImage:[_gameData coverImage]];
        self.coverView.contentMode = UIViewContentModeScaleAspectFill;
        [self.coverView setClipsToBounds:YES];
        [self addSubview:self.coverView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = [_gameData titleString];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        [self addSubview:self.titleLabel];
        
        _publishedLabel = [[UILabel alloc] init];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.text = [_gameData shortDescription];
        self.descriptionLabel.textColor = [UIColor whiteColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Lato-Italic" size:14.0f];
        [self addSubview:self.descriptionLabel];
        
        _statsRow = [[UIView alloc] init];
        [self addSubview:_statsRow];
        
        self.viewsLabel = [[UILabel alloc] init];
        self.viewsLabel.text = [NSString stringWithFormat:@"%@: %lu", NSLocalizedString(@"Views", nil), (unsigned long) [_gameData views]];
        self.viewsLabel.textColor = [UIColor whiteColor];
        self.viewsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [_statsRow addSubview:self.viewsLabel];
        
        self.purchasesLabel = [[UILabel alloc] init];
        self.purchasesLabel.text = [NSString stringWithFormat:@"%@: %lu", NSLocalizedString(@"Purchases", nil), (unsigned long)[_gameData purchases]];
        self.purchasesLabel.textColor = [UIColor whiteColor];
        self.purchasesLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [_statsRow addSubview:self.purchasesLabel];
        
        self.downloadsLabel = [[UILabel alloc] init];
        self.downloadsLabel.text = [NSString stringWithFormat:@"%@: %lu", NSLocalizedString(@"Downloads", nil), (unsigned long)[_gameData downloads]];
        self.downloadsLabel.textColor = [UIColor whiteColor];
        self.downloadsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [_statsRow addSubview:self.downloadsLabel];
        
        self.earningsLabel = [[UILabel alloc] init];
        self.earningsLabel.text =
        [NSString stringWithFormat: @"%@: %@",
         NSLocalizedString(@"Earnings", nil),
         [_gameData formattedEarnings]];
        self.earningsLabel.textColor = [UIColor whiteColor];
        self.earningsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [self addSubview:self.earningsLabel];
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
    
    [self.statsRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.descriptionLabel.mas_bottom);
        make.height.equalTo(self.purchasesLabel);
    }];
    
    [self.viewsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsRow);
        make.left.equalTo(self.statsRow);
    }];
    
    [self.purchasesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.statsRow);
    }];
    
    [self.downloadsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsRow);
        make.right.equalTo(self.statsRow);
    }];
    
    [self.earningsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(verticalOffset);
    }];
    
    
    [super updateConstraints];
}

@end
