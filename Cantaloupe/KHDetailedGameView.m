//
//  KHDetailedGameView.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameView.h"

// Models
#import "KHGameInfo.h"

// Font
#import "UIFont+KHAdditions.h"

@interface KHDetailedGameView()

@property (nonatomic, strong) KHGameInfo *gameData;

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (nonatomic, strong) UIImageView *coverCircle;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *publishedLabel;

@property (nonatomic, strong) UIView *statsRow;

@property (nonatomic, strong) UIView *viewsContainer;
@property (nonatomic, strong) UIImageView *viewsIcon;
@property (nonatomic, strong) UILabel *viewsCountLabel;

@property (nonatomic, strong) UIView *purchasesContainer;
@property (nonatomic, strong) UIImageView *purchasesIcon;
@property (nonatomic, strong) UILabel *purchasesCountLabel;

@property (nonatomic, strong) UIView *downloadsContainer;
@property (nonatomic, strong) UIImageView *downloadsIcon;
@property (nonatomic, strong) UILabel *downloadsCountLabel;

@property (nonatomic, strong) UILabel *earningsLabel;
@end

static CGFloat KHkSideMargin = 10.0f;

@implementation KHDetailedGameView

- (instancetype)initWithFrame:(CGRect)frame data:(KHGameInfo *)data {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _gameData = data;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.coverView = [[UIImageView alloc] initWithImage:[_gameData coverImage]];
        self.coverView.contentMode = UIViewContentModeScaleAspectFill;
        [self.coverView setClipsToBounds:YES];
        [self addSubview:self.coverView];
        
        _blurEffectView = ({
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurEffectView;
        });
        [self.coverView addSubview:_blurEffectView];
        
        _coverCircle = [[UIImageView alloc] initWithImage:[_gameData coverImage]];
        _coverCircle.contentMode = UIViewContentModeScaleAspectFill;
        _coverCircle.layer.borderColor = [UIColor whiteColor].CGColor;
        _coverCircle.layer.borderWidth = 1.0f;
        _coverCircle.layer.masksToBounds = YES;
        [_coverView addSubview:_coverCircle];
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = [_gameData titleString];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont regularWithSize:16.0f];
            label.textAlignment = NSTextAlignmentCenter;
            [label setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
            
            label;
        });
        [_coverView addSubview:_titleLabel];
        
        _publishedLabel = [[UILabel alloc] init];
        
        _descriptionLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = [_gameData shortDescription];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont italicWithSize:14.0f];
            label.textAlignment = NSTextAlignmentCenter;
            [label setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
            label;
        });
        [_coverView addSubview:_descriptionLabel];
        
        _statsRow = [[UIView alloc] init];
        [self addSubview:_statsRow];
        
        _viewsContainer = [[UIView alloc] init];
        [_statsRow addSubview:_viewsContainer];
        
        _viewsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"views_icon"]];
        _viewsIcon.contentMode = UIViewContentModeScaleAspectFit;
        [_viewsContainer addSubview:_viewsIcon];
        
        _viewsCountLabel = [[UILabel alloc] init];
        _viewsCountLabel.text = [NSString stringWithFormat:@"%lu views", (unsigned long)[_gameData views]];
        _viewsCountLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        _viewsCountLabel.textAlignment = NSTextAlignmentCenter;
        [_viewsContainer addSubview:_viewsCountLabel];
        
        _purchasesContainer = [[UIView alloc] init];
        [_statsRow addSubview:_purchasesContainer];
        
        _purchasesIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"purchases_icon"]];
        _purchasesIcon.contentMode = UIViewContentModeScaleAspectFit;
        [_purchasesContainer addSubview:_purchasesIcon];
        
        _purchasesCountLabel = [[UILabel alloc] init];
        _purchasesCountLabel.text = [NSString stringWithFormat:@"%lu purchases", (unsigned long) [_gameData purchases]];
        _purchasesCountLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        _purchasesCountLabel.textAlignment = NSTextAlignmentCenter;
        [_purchasesContainer addSubview:_purchasesCountLabel];
        
        _downloadsContainer = [[UIView alloc] init];
        [_statsRow addSubview:_downloadsContainer];
        
        _downloadsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downloads_icon"]];
        _downloadsIcon.contentMode = UIViewContentModeScaleAspectFit;
        [_downloadsContainer addSubview:_downloadsIcon];
        
        _downloadsCountLabel = [[UILabel alloc] init];
        _downloadsCountLabel.text = [NSString stringWithFormat:@"%lu downloads", (unsigned long) [_gameData downloads]];
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
    CGFloat coverPadding = 20.0f;
    
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.descriptionLabel).with.offset(coverPadding);
    }];
    
    [self.blurEffectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.coverView);
    }];
    
    
    CGFloat sideLength = 100.0f;
    [self.coverCircle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(sideLength);
        make.top.equalTo(self.coverView).with.offset(coverPadding);
        make.centerX.equalTo(self.coverView);
    }];
    
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.coverView);
        make.top.equalTo(self.coverCircle.mas_bottom).with.offset(coverPadding);
        make.left.and.right.equalTo(self.coverView);
    }];
    
    [self.descriptionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.statsRow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(KHkSideMargin);
        make.right.equalTo(self).with.offset(-KHkSideMargin);
        make.top.equalTo(self.coverView.mas_bottom).with.offset(10);
        make.height.equalTo(self.viewsContainer);
    }];
    
    [self.viewsContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsRow);
        make.left.equalTo(self.statsRow);
        make.bottom.equalTo(self.viewsCountLabel);
        make.width.equalTo(self.statsRow).multipliedBy(0.3);
    }];
    
    [self.viewsIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.viewsContainer);
        make.top.equalTo(self.viewsContainer);
    }];
    
    [self.viewsCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.viewsContainer);
        make.top.equalTo(self.viewsIcon.mas_bottom);
    }];
    
    [self.purchasesContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.statsRow);
        make.width.equalTo(self.statsRow).multipliedBy(0.3);
        make.bottom.equalTo(self.purchasesCountLabel);
    }];
    
    [self.purchasesIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.purchasesContainer);
        make.top.equalTo(self.purchasesContainer);
    }];
    
    [self.purchasesCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.purchasesContainer);
        make.top.equalTo(self.purchasesIcon.mas_bottom);
    }];
    
    [self.downloadsContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statsRow);
        make.right.equalTo(self.statsRow);
        make.width.equalTo(self.statsRow).multipliedBy(0.3);
        make.bottom.equalTo(self.downloadsCountLabel);
    }];
    
    [self.downloadsIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.downloadsContainer);
        make.top.equalTo(self.downloadsContainer);
    }];
    
    [self.downloadsCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.downloadsContainer);
        make.top.equalTo(self.downloadsIcon.mas_bottom);
    }];
    
    [self.earningsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.top.equalTo(self.statsRow.mas_bottom).with.offset(20);
    }];
    
    
    [super updateConstraints];
}

@end
