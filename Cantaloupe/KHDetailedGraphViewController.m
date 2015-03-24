//
//  KHDetailedGraphViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGraphViewController.h"
#import <BEMSimpleLineGraph/BEMSimpleLineGraphView.h>
#import "KHGraphPoint.h"
#import "KHGraphDataManager.h"
#import "KHGraphDataManagerDelegate.h"

@interface KHDetailedGraphViewController ()<BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate, KHGraphDataManagerDelegate>

@property (nonatomic, strong) NSArray *graphData;
@property (nonatomic, strong) NSArray *expectedDates;

@property (nonatomic, strong) BEMSimpleLineGraphView *graphView;
@property (nonatomic, assign) KHGraphType graphType;
@property (nonatomic, strong) KHGraphDataManager *dataManager;

@end

@implementation KHDetailedGraphViewController

- (instancetype)initWithGraphType:(KHGraphType)graphType {
    self = [super init];
    
    if (self) {
        _graphType = graphType;
        _dataManager = [[KHGraphDataManager alloc] initWithDelegate:self];
        _expectedDates = [self _expectedGraphDates];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setupBar];
    
    [self.dataManager requestGraphData];
}

- (void)_setupBar {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(_refresh:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:[self _graphTypeToAnalyticsTitle:self.graphType]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

/// @brief Returns an array of dates as strings corresponding to the expected dates in this graph.
- (NSArray *)_expectedGraphDates {
    NSMutableArray *expected = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    
    NSDate *today = [calendar dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; // today now refers to the start of today.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:today];
    
    [expected addObject:dateString];
    
    components = [[NSDateComponents alloc] init];
    for (int i = 1; i < self.dataManager.numberOfDays; i++) {
        [components setDay:-i];
        NSDate *date = [calendar dateByAddingComponents:components toDate:today options:0];
        NSString *string = [formatter stringFromDate:date];
        [expected insertObject:string atIndex:0];
    }
    return expected;
}

#pragma mark - Lazy Instantiation

- (BEMSimpleLineGraphView *)graphView {
    if (!_graphView) {
        _graphView = [[BEMSimpleLineGraphView alloc] init];
        _graphView.labelFont = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
        _graphView.colorLine = [UIColor colorFromHexString:@"DD4A4A"];
        _graphView.colorBottom = [UIColor whiteColor];
        _graphView.colorTop = [UIColor whiteColor];
        _graphView.colorXaxisLabel = [UIColor colorFromHexString:@"222"];
        _graphView.colorYaxisLabel = [UIColor colorFromHexString:@"222"];
        _graphView.widthLine = 3.0f;
        _graphView.enableYAxisLabel = YES;
        _graphView.autoScaleYAxis = YES;
        _graphView.enablePopUpReport = YES;
        _graphView.enableReferenceAxisFrame = YES;
        _graphView.enableReferenceXAxisLines = YES;
        _graphView.enableReferenceYAxisLines = YES;
        _graphView.delegate = self;
        _graphView.dataSource = self;
        [self.view addSubview:_graphView];
        
        CGFloat padding = 20.0f;
        [_graphView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(padding);
            make.right.equalTo(self.view).with.offset(-padding);
            make.width.equalTo(self.graphView.mas_height).multipliedBy(2);
            make.center.equalTo(self.view);
        }];
    }
    return _graphView;
}

#pragma mark - Button Presses

- (void)_refresh:(id)sender {
    [self.dataManager requestGraphData];
}

#pragma mark - KHGraphDataManagerDelegate

- (void)receivedGraphData:(NSDictionary *)graphData {
    NSString *key = [self.dataManager graphTypeToResponseKey:self.graphType];
    self.graphData = [graphData objectForKey:key];
    [self.graphView reloadGraph];
}


#pragma mark - BEMSimpleLineGraphViewDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.dataManager.numberOfDays;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    if (index < [self.expectedDates count]) {
        NSString *expectedDate = [self.expectedDates objectAtIndex:index];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateString == %@", expectedDate];
        NSArray *matchingItems = [self.graphData filteredArrayUsingPredicate:predicate];
        if ([matchingItems count] == 1) {
            KHGraphPoint *data = [matchingItems firstObject];
            return [data count];
        }
    }
    return 0;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.expectedDates objectAtIndex:index];
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

#pragma mark - Analytics

- (NSString *)_graphTypeToAnalyticsTitle:(KHGraphType)graphType {
    switch (graphType) {
        case KHGraphTypeDownloads: {
            return @"Downloads Graph Screen";
            break;
        }
        case KHGraphTypePurchases: {
            return @"Purchases Graph Screen";
            break;
        }
        case KHGraphTypeViews: {
            return @"Views Graph Screen";
            break;
        }
            
        default: {
            return @"Unknown Graph Screen";
            break;
        }
    }
}

@end
