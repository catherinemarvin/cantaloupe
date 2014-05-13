//
//  KHDetailedGameViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameViewController.h"
#import "KHDetailedGameView.h"

@interface KHDetailedGameViewController ()

@property (nonatomic, strong) NSDictionary *gameData;

@end

@implementation KHDetailedGameViewController

#pragma mark - UIViewController

- (id)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.gameData = data;
    }
    return self;
}
- (void)loadView {
    [super loadView];
    self.navigationItem.title = [self.gameData objectForKey:@"title"];
    KHDetailedGameView *view = [[KHDetailedGameView alloc] initWithFrame:[UIScreen mainScreen].bounds data:self.gameData];
    self.view = view;
}

@end
