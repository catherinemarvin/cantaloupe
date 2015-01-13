//
//  KHSettingsViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/2/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHSettingsViewCell.h"

@implementation KHSettingsViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    }
    return self;
}

@end
