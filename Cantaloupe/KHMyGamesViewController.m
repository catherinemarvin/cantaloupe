//
//  KHMyGamesViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHMyGamesViewController.h"
#import "KHGameViewCell.h"

@interface KHMyGamesViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

static NSString *KHkGameCellIdentifier = @"gameCellIdentifier";

@implementation KHMyGamesViewController

- (instancetype)init {
    if (self = [super init]) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(_refresh) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

@end
