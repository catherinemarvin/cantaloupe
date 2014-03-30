//
//  KHDetailedGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/30/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameViewCell.h"

@implementation KHDetailedGameViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(NSDictionary *)data {
    NSString *title = [[data allKeys] objectAtIndex:0];
    NSString *contents = [[data allValues] objectAtIndex:0];
    
    UILabel *info = [[UILabel alloc] initWithFrame:self.frame];
    info.text = [NSString stringWithFormat:@"%@: %@", title, contents];
    [self.contentView addSubview:info];
}

@end
