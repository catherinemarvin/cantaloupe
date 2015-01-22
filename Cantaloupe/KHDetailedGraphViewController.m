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

@interface KHDetailedGraphViewController ()<BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (nonatomic, strong) NSArray *graphData;
@property (nonatomic, strong) NSArray *expectedDates;

@property (nonatomic, strong) BEMSimpleLineGraphView *graphView;

@end

static const NSInteger KHkNumberOfGraphDays = 30;

@implementation KHDetailedGraphViewController

- (id)initWithData:(NSArray *)graphData title:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.navigationItem.title = title;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _expectedDates = [self _expectedGraphDates];
        [self _setGraphData:graphData];
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
    
    [self _setupGraphView];
}

- (void)_setupGraphView {
    self.graphView = [[BEMSimpleLineGraphView alloc] init];
    self.graphView.labelFont = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.graphView.enableYAxisLabel = YES;
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

/**
 
 @brief Ensures that self.graphData is well-populated.
 
 The API doesn't return values for when dates have a value of 0 for anything, so it's up to us to manually insert them.
 
 **/

- (void)_setGraphData:(NSArray *)graphData {
    // First convert the NSDictionaries to KHGraphPoints for convenience
    
    NSMutableArray *newData = [NSMutableArray array];
    for (NSDictionary *dict in graphData) {
        KHGraphPoint *graphPoint = [[KHGraphPoint alloc] initWithGraphDictionary:dict];
        [newData addObject:graphPoint];
    }
    self.graphData = newData;
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


#pragma mark - BEMSimpleLineGraphViewDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return KHkNumberOfGraphDays;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    if (index < [self.graphData count]) {
        KHGraphPoint *data = [self.graphData objectAtIndex:index];
        return [data count];
    } else {
        return 0;
    }
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.expectedDates objectAtIndex:index];
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return KHkNumberOfGraphDays;
}

@end
