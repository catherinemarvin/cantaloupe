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
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *earningsLabel;
@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UILabel *purchasesLabel;
@property (nonatomic, strong) UILabel *downloadsLabel;

@end

static CGFloat kSideMargin = 10.0f;

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
        self.coverView.frame = CGRectMake(0, 0, frame.size.width, 200.0f);
        [self.coverView setClipsToBounds:YES];
        [self addSubview:self.coverView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = [data valueForKey:@"title"];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        [self addSubview:self.titleLabel];
        
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
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect coverViewFrame = self.coverView.frame;
    coverViewFrame.origin.y = 10.0f;
    self.coverView.frame = coverViewFrame;
    
    [self.titleLabel sizeToFit];
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = self.coverView.frame.origin.x + kSideMargin;
    titleFrame.origin.y = self.coverView.frame.origin.y + self.coverView.frame.size.height + 10;
    self.titleLabel.frame = titleFrame;
    
    [self.descriptionLabel sizeToFit];
    CGRect descriptionFrame = self.descriptionLabel.frame;
    descriptionFrame.origin.x = self.titleLabel.frame.origin.x;
    descriptionFrame.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10;
    self.descriptionLabel.frame = descriptionFrame;
    
    [self.earningsLabel sizeToFit];
    CGRect earningsFrame = self.earningsLabel.frame;
    earningsFrame.origin.x = self.titleLabel.frame.origin.x;
    earningsFrame.origin.y = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height + 20.0f;
    self.earningsLabel.frame = earningsFrame;
    
    [self.viewsLabel sizeToFit];
    CGRect viewsFrame = self.viewsLabel.frame;
    viewsFrame.origin.x = CGRectGetMinX(earningsFrame);
    viewsFrame.origin.y = earningsFrame.origin.y + earningsFrame.size.height + 5.0f;
    self.viewsLabel.frame = viewsFrame;
    
    [self.purchasesLabel sizeToFit];
    CGRect purchasesFrame = self.purchasesLabel.frame;
    purchasesFrame.origin.x = CGRectGetMinX(earningsFrame);
    purchasesFrame.origin.y = viewsFrame.origin.y + viewsFrame.size.height + 5.0f;
    self.purchasesLabel.frame = purchasesFrame;
    
    [self.downloadsLabel sizeToFit];
    CGRect downloadsFrame = self.downloadsLabel.frame;
    downloadsFrame.origin.x = CGRectGetMinX(earningsFrame);
    downloadsFrame.origin.y = purchasesFrame.origin.y + purchasesFrame.size.height + 5.0f;
    self.downloadsLabel.frame = downloadsFrame;
    
}

@end
