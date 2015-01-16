//
//  KHDetailedGraphViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGraphViewController.h"

@interface KHDetailedGraphViewController ()

@property (nonatomic, strong) NSArray *graphData;

@property (nonatomic, strong) JBLineChartView *graphView;

@end

@implementation KHDetailedGraphViewController

- (id)initWithData:(NSArray *)graphData title:(NSString *)title {
    self = [super init];
    
#warning Remove me after I get some working data
    
    graphData = @[
                  @{
                      @"date" : @"2014-04-08",
                      @"count" : @(1)
                      },
                  @{
                      @"date" : @"2014-04-15",
                      @"count" : @(4)
                      }
                  ];
    
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
    
    self.graphView = [[JBLineChartView alloc] initWithFrame:view.bounds];
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    [view addSubview:self.graphView];
    
    [self.graphView reloadData];
    
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.graphView setState:JBChartViewStateExpanded];
}

#pragma mark - JBBarChartView

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
    
    return [self.graphData count];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    NSDictionary *data = [self.graphData objectAtIndex:horizontalIndex];
    NSNumber *count = [data valueForKey:@"count"];
    return [count floatValue];
}

@end
