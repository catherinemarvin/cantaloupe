//
//  KHDetailedGameViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameViewController.h"
#import "KHDetailedGameView.h"
#import "KHGameInfo.h"

@interface KHDetailedGameViewController ()

@property (nonatomic, strong) KHGameInfo *gameInfo;

@end

@implementation KHDetailedGameViewController

#pragma mark - UIViewController

- (instancetype)initWithGameInfo:(KHGameInfo *)info {
    if (self = [super init]) {
        _gameInfo = info;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.gameInfo titleString];
    KHDetailedGameView *view = [[KHDetailedGameView alloc] initWithGameInfo:self.gameInfo];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Detailed Game View Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

@end
