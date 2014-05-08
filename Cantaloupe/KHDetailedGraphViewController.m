//
//  KHDetailedGraphViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGraphViewController.h"
#import "JBLineChartView.h"
#import "KHGraphDetailView.h"
#import "KHGraphFooterView.h"

@interface KHDetailedGraphViewController ()

@property (nonatomic, strong) NSArray *graphData;

@property (nonatomic, strong) JBLineChartView *graphView;
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
    
    self.graphView = [[JBLineChartView alloc] initWithFrame:CGRectMake(20, 120, view.bounds.size.width - 40, 100)];
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    self.graphView.mininumValue = 0.0f;
    [view addSubview:self.graphView];
    [self.graphView reloadData];
    
    self.detailView = [[KHGraphDetailView alloc] initWithFrame:CGRectMake(20, 220, view.bounds.size.width - 40, 40)];
    self.detailView.backgroundColor = [UIColor redColor];
    [view addSubview:self.detailView];
    
    if (!self.graphData || [self.graphData count] == 0) {
        UILabel *sorryLabel = [[UILabel alloc] initWithFrame:self.detailView.bounds];
        sorryLabel.text = NSLocalizedString(@"Sorry, graph data is unavailable at this time.", nil);
        sorryLabel.font = [UIFont fontWithName:@"Lato-Regular" size:20.0f];
        [self.detailView addSubview:sorryLabel];
    }
    
    KHGraphFooterView *footerView = [[KHGraphFooterView alloc] initWithFrame:CGRectMake(10.0f, ceil(self.view.bounds.size.height * 0.5) - ceil(20.0f * 0.5), self.view.bounds.size.width - (10.0f * 2), 75.0f)];
    
    footerView.backgroundColor = [UIColor blueColor];
    footerView.leftLabel.text = @"Foo";
    footerView.rightLabel.text = @"Bar";
    footerView.sectionCount = [self.graphData count];
    self.graphView.footerView = footerView;
    
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
    return 1;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    NSDictionary *data = [self.graphData objectAtIndex:horizontalIndex];
    NSNumber *count = [data valueForKey:@"count"];
    return [count floatValue];
}

- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint {
    NSNumber *valueNumber = [[self.graphData objectAtIndex:horizontalIndex] valueForKey:@"count"];
    [self.detailView updateDetail:[valueNumber stringValue]];
}

@end
