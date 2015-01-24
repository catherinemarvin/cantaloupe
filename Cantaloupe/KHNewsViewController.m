//
//  KHNewsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/5/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewController.h"
#import "AFNetworking.h"
#import "KHNewsViewCell.h"
#import "KHDetailedNewsViewController.h"

@interface KHNewsViewController ()

@property (nonatomic, strong) NSArray *posts;

@end

static NSString *KHkNewsCellIdentifier = @"newsCellIdentifier";

static const int ddLogLevel = LOG_LEVEL_ALL;

@implementation KHNewsViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        [self.tableView registerClass:[KHNewsViewCell class] forCellReuseIdentifier:KHkNewsCellIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"News", nil);
    [self _requestNews];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(_requestNews) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)_requestNews {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *key = @"nadyVe3mHbqHOtDnYU3H5lI44MDWS2k8rPJdLakyVKh8k1fgmc";
    NSString *url = [NSString stringWithFormat:@"http://api.tumblr.com/v2/blog/itchio.tumblr.com/posts?api_key=%@", key];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        self.posts = [responseDict valueForKeyPath:@"response.posts"];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Error: %@", error);
        if (error.code == -1009) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Please connect to the Internet and try again", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [alert show];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"News View Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KHkNewsCellIdentifier forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[KHNewsViewCell class]]) {
        KHNewsViewCell *newsCell = (KHNewsViewCell *)cell;
        [newsCell configureWithNews:[self.posts objectAtIndex:indexPath.row]];
        [newsCell layoutIfNeeded];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *news = [self.posts objectAtIndex:indexPath.row];
    KHDetailedNewsViewController *detailed = [[KHDetailedNewsViewController alloc] initWithNews:news];
    
    [self.navigationController pushViewController:detailed animated:YES];
}

@end
