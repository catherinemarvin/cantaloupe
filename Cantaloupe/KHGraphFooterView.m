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

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.footerSeparatorColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetShouldAntialias(context, YES);
    
    CGFloat xOffset = 0;
    CGFloat yOffset = 0.5;
    CGFloat stepLength = ceil((self.bounds.size.width) / (self.sectionCount - 1));
    
    for (int i=0; i<self.sectionCount; i++)
    {
        CGContextSaveGState(context);
        {
            CGContextMoveToPoint(context, xOffset + (0.5 * 0.5), yOffset);
            CGContextAddLineToPoint(context, xOffset + (0.5 * 0.5), yOffset + 3.0);
            CGContextStrokePath(context);
            xOffset += stepLength;
        }
        CGContextRestoreGState(context);
    }
    
    if (self.sectionCount > 1)
    {
        CGContextSaveGState(context);
        {
            CGContextMoveToPoint(context, self.bounds.size.width - (0.5 * 0.5), yOffset);
            CGContextAddLineToPoint(context, self.bounds.size.width - (0.5 * 0.5), yOffset + 3.0);
            CGContextStrokePath(context);
        }
        CGContextRestoreGState(context);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topSeparatorView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width
                                             , 0.5f);
    CGFloat xOffset = 0;
    CGFloat yOffset = 1.0f;
    CGFloat width = ceil(self.bounds.size.width * 0.5);
    
    self.leftLabel.frame = CGRectMake(xOffset, yOffset, width, self.bounds.size.height);
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame), yOffset, width, self.bounds.size.height);
}

#pragma mark - Setters

- (void)setSectionCount:(NSInteger)sectionCount {
    _sectionCount = sectionCount;
    [self setNeedsDisplay];
}

- (void)setFooterSeparatorColor:(UIColor *)footerSeparatorColor {
    _footerSeparatorColor = footerSeparatorColor;
    [self setNeedsDisplay];
}
@end
