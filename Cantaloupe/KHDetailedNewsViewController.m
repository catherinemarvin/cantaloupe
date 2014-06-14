//
//  KHDetailedNewsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedNewsViewController.h"
#import "KHNewsView.h"

@interface KHDetailedNewsViewController ()

@property (nonatomic, strong) KHNewsView *newsView;
@property (nonatomic, strong) NSDictionary *news;

@end

@implementation KHDetailedNewsViewController

- (id)initWithNews:(NSDictionary *)news {
    if (self = [super init]) {
        self.news = news;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    KHNewsView *newsView = [[KHNewsView alloc] initWithFrame:[UIScreen mainScreen].bounds news:self.news];
    self.view = newsView;
    self.newsView = newsView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
