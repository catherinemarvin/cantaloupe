//
//  KHGraphFooterView.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/2/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHGraphFooterView : UIView

@property (nonatomic, strong) UIColor *footerSeparatorColor;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end
