//
//  KHGraphsViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGraphsViewCell.h"

@implementation KHGraphsViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
    }
    return self;
}

@end
