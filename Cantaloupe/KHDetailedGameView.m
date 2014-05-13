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

@property (nonatomic, strong) UIView *dividerLabel;

@property (nonatomic, strong) UILabel *earningsLabel;
@property (nonatomic, strong) UILabel *viewsLabel;
@property (nonatomic, strong) UILabel *purchasesLabel;
@property (nonatomic, strong) UILabel *downloadsLabel;

@end

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
        self.coverView.frame = CGRectMake(0, 0, frame.size.width, 200.0f);
        self.coverView.contentMode = UIViewContentModeScaleAspectFit;
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
        
        self.dividerLabel = [[UIView alloc] init];
        self.dividerLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dividerLabel];
        
        self.earningsLabel = [[UILabel alloc] init];
        self.earningsLabel.text = [NSString stringWithFormat: @"%@: %@", NSLocalizedString(@"Earnings", nil), [[data valueForKey:@"earnings"] valueForKey:@"amount_formatted"] ?: NSLocalizedString(@"None", @"No earnings")];
        self.earningsLabel.textColor = [UIColor whiteColor];
        self.earningsLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
        [self addSubview:self.earningsLabel];
        
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = self.coverView.frame.origin.x;
    titleFrame.origin.y = self.coverView.frame.origin.y + self.coverView.frame.size.height + 10;
    self.titleLabel.frame = titleFrame;
    
    [self.descriptionLabel sizeToFit];
    CGRect descriptionFrame = self.descriptionLabel.frame;
    descriptionFrame.origin.x = self.coverView.frame.origin.x;
    descriptionFrame.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10;
    self.descriptionLabel.frame = descriptionFrame;
    
    CGRect dividerFrame = CGRectZero;
    dividerFrame.origin.x = self.coverView.frame.origin.x;
    dividerFrame.origin.y = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height + 5.0f;
    dividerFrame.size.height = 1.0f;
    dividerFrame.size.width = self.frame.size.width;
    self.dividerLabel.frame = dividerFrame;
    
    [self.earningsLabel sizeToFit];
    CGRect earningsFrame = self.earningsLabel.frame;
    earningsFrame.origin.x = self.coverView.frame.origin.x;
    earningsFrame.origin.y = self.dividerLabel.frame.origin.y + self.dividerLabel.frame.size.height + 5.0f;
    self.earningsLabel.frame = earningsFrame;
    
}

@end
