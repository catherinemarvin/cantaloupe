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

@property (nonatomic, strong) UIView *viewsContainer;
@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UILabel *viewsCountLabel;

@property (nonatomic, strong) UIView *purchasesContainer;
@property (nonatomic, strong) UILabel *purchasesLabel;
@property (nonatomic, strong) UILabel *purchasesCountLabel;

@property (nonatomic, strong) UIView *downloadsContainer;
@property (nonatomic, strong) UILabel *downloadsLabel;
@property (nonatomic, strong) UILabel *downloadsCountLabel;

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
        
        _viewsContainer = [[UIView alloc] init];
        [_statsRow addSubview:_viewsContainer];
        
        self.viewsLabel = [[UILabel alloc] init];
        self.viewsLabel.text = NSLocalizedString(@"Views", nil);
        self.viewsLabel.textColor = [UIColor whiteColor];
        self.viewsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        self.viewsLabel.textAlignment = NSTextAlignmentCenter;
        [_viewsContainer addSubview:self.viewsLabel];
        
        _viewsCountLabel = [[UILabel alloc] init];
        _viewsCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) [_gameData views]];
        _viewsCountLabel.textColor = [UIColor whiteColor];
        _viewsCountLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        _viewsCountLabel.textAlignment = NSTextAlignmentCenter;
        [_viewsContainer addSubview:_viewsCountLabel];
        
        _purchasesContainer = [[UIView alloc] init];
        [_statsRow addSubview:_purchasesContainer];
        
        self.purchasesLabel = [[UILabel alloc] init];
        self.purchasesLabel.text = NSLocalizedString(@"Purchases", nil);
        self.purchasesLabel.textColor = [UIColor whiteColor];
        self.purchasesLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        self.purchasesLabel.textAlignment = NSTextAlignmentCenter;
        [_purchasesContainer addSubview:self.purchasesLabel];
        
        _purchasesCountLabel = [[UILabel alloc] init];
        _purchasesCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) [_gameData purchases]];
        _purchasesCountLabel.textColor = [UIColor whiteColor];
        _purchasesCountLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        _purchasesCountLabel.textAlignment = NSTextAlignmentCenter;
        [_purchasesContainer addSubview:_purchasesCountLabel];
        
        _downloadsContainer = [[UIView alloc] init];
        [_statsRow addSubview:_downloadsContainer];
        
        self.downloadsLabel = [[UILabel alloc] init];
        self.downloadsLabel.text = NSLocalizedString(@"Downloads", nil);
        self.downloadsLabel.textColor = [UIColor whiteColor];
        self.downloadsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        self.downloadsLabel.textAlignment = NSTextAlignmentCenter;
        [_downloadsContainer addSubview:self.downloadsLabel];
        
        _downloadsCountLabel = [[UILabel alloc] init];
        _downloadsCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) [_gameData downloads]];
        _downloadsCountLabel.textColor = [UIColor whiteColor];
        _downloadsCountLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        _downloadsCountLabel.textAlignment = NSTextAlignmentCenter;
        [_downloadsContainer addSubview:_downloadsCountLabel];
        
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
        make.left.equalTo(self).with.offset(KHkSideMargin);
        make.right.equalTo(self).with.offset(-KHkSideMargin);
        make.top.equalTo(self.descriptionLabel.mas_bottom);
        make.height.equalTo(self.viewsContainer);
    }];
    
    [self.viewsContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsRow);
        make.left.equalTo(self.statsRow);
        make.bottom.equalTo(self.viewsCountLabel);
        make.width.equalTo(self.statsRow).multipliedBy(0.3);
    }];
    
    [self.viewsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.viewsContainer);
        make.top.equalTo(self.viewsContainer);
    }];
    
    [self.viewsCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.viewsContainer);
        make.top.equalTo(self.viewsLabel.mas_bottom);
    }];
    
    [self.purchasesContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.statsRow);
        make.width.equalTo(self.statsRow).multipliedBy(0.3);
        make.bottom.equalTo(self.purchasesCountLabel);
    }];
    
    [self.purchasesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.purchasesContainer);
        make.top.equalTo(self.purchasesContainer);
    }];
    
    [self.purchasesCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.purchasesContainer);
        make.top.equalTo(self.purchasesLabel.mas_bottom);
    }];
    
    [self.downloadsContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsRow);
        make.right.equalTo(self.statsRow);
        make.width.equalTo(self.statsRow).multipliedBy(0.3);
        make.bottom.equalTo(self.downloadsCountLabel);
    }];
    
    [self.downloadsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.downloadsContainer);
        make.top.equalTo(self.downloadsContainer);
    }];
    
    [self.downloadsCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.downloadsContainer);
        make.top.equalTo(self.downloadsLabel.mas_bottom);
    }];
    
    [self.earningsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.statsRow.mas_bottom).with.offset(verticalOffset);
    }];
    
    
    [super updateConstraints];
}

@end
