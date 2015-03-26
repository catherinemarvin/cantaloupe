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
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.title = [self.gameInfo titleString];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.alwaysBounceVertical = YES;
    
    KHDetailedGameView *view = [[KHDetailedGameView alloc] initWithFrame:scrollView.bounds data:self.gameInfo];
    
    [scrollView addSubview:view];
    scrollView.contentSize = view.frame.size;
    
    self.view = scrollView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Detailed Game View Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

@end
