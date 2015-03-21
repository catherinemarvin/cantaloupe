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

@property (nonatomic, strong) UIView *textContainer;
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
        
        _textContainer = [[UIView alloc] init];
        [_footer addSubview:_textContainer];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont regularWithSize:20.0f];
        _titleLabel.textColor = [UIColor colorFromHexString:@"aaaaaa"];
        [_textContainer addSubview:_titleLabel];
        
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont regularWithSize:16.0f];
        [_textContainer addSubview:_descriptionLabel];
        
        CGFloat cornerRadius = 5.0f;
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.backgroundColor = [UIColor colorFromHexString:@"24C091"];
        _priceLabel.layer.cornerRadius = cornerRadius;
        _priceLabel.layer.masksToBounds = YES;
        _priceLabel.font = [UIFont regularWithSize:10.0f];
        [_textContainer addSubview:_priceLabel];
        
        _viewsLabel = [[UILabel alloc] init];
        _viewsLabel.backgroundColor = [UIColor colorFromHexString:@"DADADA"];
        _viewsLabel.textColor = [UIColor grayColor];
        _viewsLabel.layer.cornerRadius = cornerRadius;
        _viewsLabel.layer.masksToBounds = YES;
        _viewsLabel.font = [UIFont regularWithSize:10.0f];
        [_textContainer addSubview:_viewsLabel];
        
        _downloadsLabel = [[UILabel alloc] init];
        _downloadsLabel.backgroundColor = [UIColor colorFromHexString:@"DADADA"];
        _downloadsLabel.textColor = [UIColor grayColor];
        _downloadsLabel.layer.cornerRadius = cornerRadius;
        _downloadsLabel.layer.masksToBounds = YES;
        _downloadsLabel.font = [UIFont regularWithSize:10.0f];
        [_textContainer addSubview:_downloadsLabel];
        
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
        make.left.and.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom);
        make.height.equalTo(self.textContainer);
    }];
    
    CGFloat sideMargin = 20.0f;
    
    [_textContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footer).with.offset(sideMargin);
        make.right.equalTo(self.footer).with.offset(-sideMargin);
        make.top.equalTo(self.footer);
        make.bottom.equalTo(self.priceLabel).with.offset(sideMargin);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textContainer);
        make.top.equalTo(self.textContainer);
        make.right.equalTo(self.textContainer);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.and.right.equalTo(self.titleLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom);
        make.left.equalTo(self.titleLabel);
    }];
    
    CGFloat smallSpacing = 10.0f;
    [self.viewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel);
        make.left.equalTo(self.priceLabel.mas_right).with.offset(smallSpacing);
    }];
    
    [self.downloadsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel);
        make.left.equalTo(self.viewsLabel.mas_right).with.offset(smallSpacing);
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
