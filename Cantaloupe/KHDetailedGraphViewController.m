//
//  KHDetailedGraphViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGraphViewController.h"
#import "JBBarChartView.h"
#import "KHGraphDetailView.h"

@interface KHDetailedGraphViewController ()

@property (nonatomic, strong) NSArray *graphData;

@property (nonatomic, strong) JBBarChartView *graphView;
@property (nonatomic, strong) KHGraphDetailView *detailView;

@end

@implementation KHDetailedGraphViewController

- (id)initWithData:(NSArray *)graphData title:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.graphData = graphData;
        self.navigationItem.title = title;
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    self.graphView = [[JBBarChartView alloc] initWithFrame:CGRectMake(20, 120, view.bounds.size.width - 40, 100)];
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    self.graphView.mininumValue = 0.0f;
    [view addSubview:self.graphView];
    [self.graphView reloadData];
    
    self.detailView = [[KHGraphDetailView alloc] initWithFrame:CGRectMake(20, 220, view.bounds.size.width - 40, 40)];
    self.detailView.backgroundColor = [UIColor redColor];
    [view addSubview:self.detailView];
    self.view = view;
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

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint {
    NSNumber *valueNumber = [[self.graphData objectAtIndex:index] valueForKey:@"count"];
    
    [self.detailView updateDetail:[valueNumber stringValue]];
}


@end
