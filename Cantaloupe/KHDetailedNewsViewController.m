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
    
    NSString *postUrl = [self.news objectForKey:@"post_url"];
    KHNewsView *newsView = [[KHNewsView alloc] initWithFrame:[UIScreen mainScreen].bounds news:postUrl];
    self.view = newsView;
    self.newsView = newsView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [self.news objectForKey:@"title"];
}

@end
