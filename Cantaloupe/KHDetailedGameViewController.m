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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.alwaysBounceVertical = YES;
    
    KHDetailedGameView *view = [[KHDetailedGameView alloc] initWithFrame:scrollView.bounds data:self.gameData];
    
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
