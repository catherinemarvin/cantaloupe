//
//  KHNewsViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/11/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewCell.h"

@interface KHNewsViewCell ()

@property (nonatomic, strong) NSDictionary *news;

@end

@implementation KHNewsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    }
    return self;
}

- (void)configureWithNews:(NSDictionary *)news {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.news = news;
    
    self.textLabel.text = [self.news objectForKey:@"title"];
    [self setNeedsLayout];
}

@end
