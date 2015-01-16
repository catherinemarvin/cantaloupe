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
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    self.graphView = [[BEMSimpleLineGraphView alloc] init];
    self.graphView.enableYAxisLabel = YES;
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    [view addSubview:self.graphView];
    
    [self.graphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    self.view = view;
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
