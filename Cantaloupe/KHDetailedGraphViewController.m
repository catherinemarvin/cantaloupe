//
//  KHDetailedGraphViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGraphViewController.h"
#import "JBBarChartView.h"

@interface KHDetailedGraphViewController ()

@property (nonatomic, strong) NSDictionary *graphData;
@property (nonatomic, strong) JBBarChartView *graphView;

@end

@implementation KHDetailedGraphViewController

- (id)initWithData:(NSDictionary *)graphData {
    self = [super init];
    
    if (self) {
        self.graphData = graphData;
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    self.graphView = [[JBBarChartView alloc] initWithFrame:view.frame];
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    [view addSubview:self.graphView];
    self.view = view;
    [self.graphView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.graphView setState:JBChartViewStateExpanded];
}

#pragma mark - JBBarChartView

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView {
    return [self.graphData count];
}

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index {
    if (index % 2 == 0) {
        return 50;
    } else {
        return 100;
    }
}


@end
