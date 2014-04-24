//
//  KHGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/28/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGameViewCell.h"

@implementation KHGameViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    }
    return self;
}

- (void)setTitleText:(NSString *)title {
    self.textLabel.text = title;
}

@end
