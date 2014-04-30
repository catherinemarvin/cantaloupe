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

@property (nonatomic, strong) NSArray *graphData;

@property (nonatomic, strong) JBBarChartView *graphView;

@end

@implementation KHDetailedGraphViewController

- (id)initWithData:(NSArray *)graphData {
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
    
    self.graphView = [[JBBarChartView alloc] initWithFrame:CGRectMake(30, 30, 100, 200)];
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    self.graphView.mininumValue = 0.0f;
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
    NSDictionary *data = [self.graphData objectAtIndex:index];
    NSNumber *count = [data valueForKey:@"count"];
    return [count floatValue];
}


@end
