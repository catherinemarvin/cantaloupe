//
//  KHDetailedGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/30/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameViewCell.h"

@implementation KHDetailedGameViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    // Override the style argument with our own.
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)configureWithData:(NSDictionary *)data {
    NSString *title = [[data allKeys] objectAtIndex:0];
    NSString *contents = [[data allValues] objectAtIndex:0];
    
    self.textLabel.text = title;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@", contents];
}

@end
