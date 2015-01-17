//
//  KHDetailedGraphViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGraphViewController.h"
#import <BEMSimpleLineGraph/BEMSimpleLineGraphView.h>

@interface KHDetailedGraphViewController ()<BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (nonatomic, strong) NSArray *graphData;

@property (nonatomic, strong) BEMSimpleLineGraphView *graphView;

@end

@implementation KHDetailedGraphViewController

- (id)initWithData:(NSArray *)graphData title:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.graphData = graphData;
        self.navigationItem.title = title;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:self.analyticsTitle];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

#pragma mark - UIViewController

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    self.view = view;
    
    if ([self.graphData count] > 0) {
        [self _setupGraphView];
    } else {
        [self _setupEmptyView];
    }
}

- (void)_setupGraphView {
    self.graphView = [[BEMSimpleLineGraphView alloc] init];
    self.graphView.labelFont = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.graphView.enableYAxisLabel = YES;
    self.graphView.enablePopUpReport = YES;
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    [self.view addSubview:self.graphView];
    
    CGFloat padding = 20.0f;
    UIEdgeInsets insets = UIEdgeInsetsMake(padding, padding, padding, padding);
    [self.graphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(insets);
    }];
}

- (void)_setupEmptyView {
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont fontWithName:@"Lato-Regular" size:20.0f];
    title.text = NSLocalizedString(@"Sorry, you don't have any graph data.", nil);
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
}


#pragma mark - BEMSimpleLineGraphViewDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return [self.graphData count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    NSDictionary *data = [self.graphData objectAtIndex:index];
    NSNumber *count = [data valueForKey:@"count"];
    return [count floatValue];
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSDictionary *data = [self.graphData objectAtIndex:index];
    NSString *date = [data valueForKey:@"date"];
    return date;
}

@end
