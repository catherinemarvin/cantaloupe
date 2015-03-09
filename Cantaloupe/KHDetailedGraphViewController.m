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

@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) KHGraphType graphType;
@property (nonatomic, strong) KHGraphDataManager *dataManager;

@end

static const NSInteger KHkNumberOfGraphDays = 30;

@implementation KHDetailedGraphViewController

- (instancetype)initWithGraphType:(KHGraphType)graphType key:(NSString *)key {
    self = [super init];
    
    if (self) {
        _graphType = graphType;
        _key = key;
        _expectedDates = [self _expectedGraphDates];
        _dataManager = [[KHGraphDataManager alloc] initWithKey:key delegate:self];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [self.dataManager requestGraphData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:[self _graphTypeToAnalyticsTitle:self.graphType]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

#pragma mark - UIViewController

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    self.view = view;
    
    [self _setupGraphView];
}

- (void)_setupGraphView {
    self.graphView = [[BEMSimpleLineGraphView alloc] init];
    self.graphView.labelFont = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.graphView.colorLine = [UIColor redColor];
    self.graphView.colorBottom = [UIColor whiteColor];
    self.graphView.colorTop = [UIColor whiteColor];
    self.graphView.colorXaxisLabel = [UIColor colorFromHexString:@"222"];
    self.graphView.colorYaxisLabel = [UIColor colorFromHexString:@"222"];
    self.graphView.widthLine = 3.0f;
    self.graphView.enableYAxisLabel = YES;
    self.graphView.autoScaleYAxis = YES;
    self.graphView.enablePopUpReport = YES;
    self.graphView.enableReferenceAxisFrame = YES;
    self.graphView.enableReferenceXAxisLines = YES;
    self.graphView.enableReferenceYAxisLines = YES;
    self.graphView.delegate = self;
    self.graphView.dataSource = self;
    [self.view addSubview:self.graphView];
    
    CGFloat padding = 20.0f;
    UIEdgeInsets insets = UIEdgeInsetsMake(padding, padding, padding, padding);
    [self.graphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(insets);
    }];
}

/// @brief Returns an array of NSDates corresponding to the expected dates in this graph. There should be KhkNumberOfGraphDays entries
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
    for (int i = 1; i < KHkNumberOfGraphDays; i++) {
        [components setDay:-i];
        NSDate *date = [calendar dateByAddingComponents:components toDate:today options:0];
        NSString *string = [formatter stringFromDate:date];
        [expected insertObject:string atIndex:0];
    }
    return expected;
}

#pragma mark - KHGraphDataManagerDelegate

- (void)receivedGraphData:(NSDictionary *)graphData {
    NSString *key = [self.dataManager graphTypeToResponseKey:self.graphType];
    self.graphData = [graphData objectForKey:key];
    [self.graphView reloadGraph];
}


#pragma mark - BEMSimpleLineGraphViewDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return KHkNumberOfGraphDays;
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
    return KHkNumberOfGraphDays;
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
