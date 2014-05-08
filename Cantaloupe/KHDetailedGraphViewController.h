//
//  KHDetailedGraphViewController.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBLineChartView.h"

@interface KHDetailedGraphViewController : UIViewController<JBLineChartViewDataSource, JBLineChartViewDelegate>

- (id)initWithData:(NSArray *)graphData title:(NSString *)title;

@end
