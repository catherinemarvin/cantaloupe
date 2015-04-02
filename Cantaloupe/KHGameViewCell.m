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
@property (nonatomic, strong) UIView *priceLabelContainer;

@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UIView *viewsLabelContainer;

@property (nonatomic, strong) UILabel *downloadsLabel;
@property (nonatomic, strong) UIView *downloadslabelContainer;

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
        [_textContainer addSubview:_titleLabel];
        
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont regularWithSize:14.0f];
        _descriptionLabel.textColor = [UIColor colorFromHexString:@"aaaaaa"];
        [_textContainer addSubview:_descriptionLabel];
        
        CGFloat cornerRadius = 5.0f;
        _priceLabelContainer = [[UIView alloc] init];
        _priceLabelContainer.backgroundColor = [UIColor colorFromHexString:@"24C091"];
        _priceLabelContainer.layer.cornerRadius = cornerRadius;
        _priceLabelContainer.layer.masksToBounds = YES;
        [_textContainer addSubview:_priceLabelContainer];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.font = [UIFont regularWithSize:10.0f];
        [_priceLabelContainer addSubview:_priceLabel];
        
        _viewsLabelContainer = [[UIView alloc] init];
        _viewsLabelContainer.backgroundColor = [UIColor colorFromHexString:@"DADADA"];
        _viewsLabelContainer.layer.cornerRadius = cornerRadius;
        _viewsLabelContainer.layer.masksToBounds = YES;
        [_textContainer addSubview:_viewsLabelContainer];
        
        _viewsLabel = [[UILabel alloc] init];
        _viewsLabel.textColor = [UIColor grayColor];
        _viewsLabel.font = [UIFont regularWithSize:10.0f];
        [_viewsLabelContainer addSubview:_viewsLabel];
        
        _downloadslabelContainer = [[UIView alloc] init];
        _downloadslabelContainer.backgroundColor = [UIColor colorFromHexString:@"DADADA"];
        _downloadslabelContainer.layer.cornerRadius = cornerRadius;
        _downloadslabelContainer.layer.masksToBounds = YES;
        [_textContainer addSubview:_downloadslabelContainer];
        
        _downloadsLabel = [[UILabel alloc] init];
        _downloadsLabel.textColor = [UIColor grayColor];
        _downloadsLabel.font = [UIFont regularWithSize:10.0f];
        [_downloadslabelContainer addSubview:_downloadsLabel];
        
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
        make.height.equalTo(self.textContainer).with.offset(10);
    }];
    
    CGFloat sideMargin = 20.0f;
    
    [_textContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footer).with.offset(sideMargin);
        make.right.equalTo(self.footer).with.offset(-sideMargin);
        make.top.equalTo(self.footer).with.offset(10);
        make.bottom.equalTo(self.priceLabelContainer).with.offset(sideMargin);
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
    
    CGFloat sidePadding = 5;
    CGFloat topPadding = 2;
    [self.priceLabelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(sidePadding);
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.priceLabel).with.offset(-topPadding);
        make.bottom.equalTo(self.priceLabel).with.offset(topPadding);
        make.left.equalTo(self.priceLabel).with.offset(-sidePadding);
        make.right.equalTo(self.priceLabel).with.offset(sidePadding);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.priceLabelContainer);
    }];
    
    CGFloat smallSpacing = 10.0f;
    [self.viewsLabelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabelContainer);
        make.left.equalTo(self.priceLabelContainer.mas_right).with.offset(smallSpacing);
        
        make.top.equalTo(self.viewsLabel).with.offset(-topPadding);
        make.bottom.equalTo(self.viewsLabel).with.offset(topPadding);
        make.left.equalTo(self.viewsLabel).with.offset(-sidePadding);
        make.right.equalTo(self.viewsLabel).with.offset(sidePadding);
    }];
    
    [self.viewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.viewsLabelContainer);
    }];
    
    [self.downloadslabelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabelContainer);
        make.left.equalTo(self.viewsLabelContainer.mas_right).with.offset(smallSpacing);
        
        make.top.equalTo(self.downloadsLabel).with.offset(-topPadding);
        make.bottom.equalTo(self.downloadsLabel).with.offset(topPadding);
        make.left.equalTo(self.downloadsLabel).with.offset(-sidePadding);
        make.right.equalTo(self.downloadsLabel).with.offset(sidePadding);
    }];
    
    [self.downloadsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.downloadslabelContainer);
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
