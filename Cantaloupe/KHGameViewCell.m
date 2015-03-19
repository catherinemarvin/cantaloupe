//
//  KHGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/28/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

// Views
#import "KHGameViewCell.h"

// Models
#import "KHGameInfo.h"

// Helpers
#import <Masonry.h>
#import "UIFont+KHAdditions.h"

@interface KHGameViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UILabel *downloadsLabel;

@end

@implementation KHGameViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
        
        _footer = [[UIView alloc] init];
        _footer.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_footer];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont regularWithSize:12.0f];
        _titleLabel.textColor = [UIColor colorFromHexString:@"aaaaaa"];
        [_footer addSubview:_titleLabel];
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont regularWithSize:12.0f];
        [_footer addSubview:_descriptionLabel];
        
        _priceLabel = [[UILabel alloc] init];
        [_footer addSubview:_priceLabel];
        
        _viewsLabel = [[UILabel alloc] init];
        [_footer addSubview:_viewsLabel];
        
        _downloadsLabel = [[UILabel alloc] init];
        [_footer addSubview:_downloadsLabel];
        
        [self _initializeAutolayout];
    }
    return self;
}

- (void)_initializeAutolayout {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.footer.mas_top);
    }];
    
    [self.footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.and.right.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.footer);
        make.left.and.right.equalTo(self.footer);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.and.right.equalTo(self.titleLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.viewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel);
        make.left.equalTo(self.priceLabel.mas_right);
    }];
    
    [self.downloadsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel);
        make.left.equalTo(self.viewsLabel.mas_right);
    }];
}

- (void)configureWithGameInfo:(KHGameInfo *)gameInfo {
    self.imageView.image = gameInfo.coverImage;
    self.titleLabel.text = gameInfo.titleString;
    self.descriptionLabel.text = gameInfo.shortDescription;
    self.priceLabel.text = gameInfo.priceString;
    self.viewsLabel.text = [NSString stringWithFormat:@"%ld views", gameInfo.views];
    self.downloadsLabel.text = [NSString stringWithFormat:@"%ld downloads", gameInfo.downloads];
}

@end
