//
//  KHDetailedGameViewCell.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/30/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameViewCell.h"

@interface KHDetailedGameViewCell()

@property (nonatomic, strong) UILabel *infoView;

@end

@implementation KHDetailedGameViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.infoView = [[UILabel alloc] initWithFrame:self.frame];
        [self.contentView addSubview:self.infoView];
    }
    return self;
}

- (void)configureWithData:(NSDictionary *)data {
    NSString *title = [[data allKeys] objectAtIndex:0];
    NSString *contents = [[data allValues] objectAtIndex:0];
    
    self.infoView.text = [NSString stringWithFormat:@"%@: %@", title, contents];
}

@end
