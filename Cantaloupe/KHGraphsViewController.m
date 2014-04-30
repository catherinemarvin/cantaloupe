//
//  KHGraphsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGraphsViewController.h"
#import "KHGraphsViewCell.h"
#import "AFNetworking.h"
#import "KHDetailedGraphViewController.h"

static NSString *kGraphsCellIdentifier = @"kGraphsCell";

typedef NS_ENUM(NSUInteger, KHGraphsCells) {
    KHGraphsCellNone,
    KHGraphsCellPurchases,
    KHGraphsCellViews,
    KHGraphsCellDownloads
};

@interface KHGraphsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSDictionary *graphData;

@end

@implementation KHGraphsViewController

#pragma mark - NSObject

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (id)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.key = key;
        [self _requestGraphs];
    }
    return self;
}

#pragma mark - UIViewController
- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Graphs", nil);
    [self.tableView registerClass:[KHGraphsViewCell class] forCellReuseIdentifier:kGraphsCellIdentifier];
}

#pragma mark - UITableView protocols

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHGraphsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGraphsCellIdentifier forIndexPath:indexPath];
    
    [self customizeCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)customizeCell:(KHGraphsViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        cell.textLabel.text = NSLocalizedString(@"Purchases", nil);
        cell.tag = KHGraphsCellPurchases;
        
    } else if (row == 1) {
        cell.textLabel.text = NSLocalizedString(@"Views", nil);
        cell.tag = KHGraphsCellViews;
        
    } else if (row == 2) {
        cell.textLabel.text = NSLocalizedString(@"Downloads", nil);
        cell.tag = KHGraphsCellDownloads;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *key;
    switch (cell.tag) {
        case KHGraphsCellPurchases:
            key = @"purchases";
            break;
        case KHGraphsCellViews:
            key = @"views";
            break;
        case KHGraphsCellDownloads:
            key = @"downloads";
            break;
        default:
            break;
    }
    
    if (key) {
        NSArray *data = [self.graphData valueForKey:key];
        
        KHDetailedGraphViewController *detailedGraphController = [[KHDetailedGraphViewController alloc] initWithData:data];
        [self.navigationController pushViewController:detailedGraphController animated:YES];
    }
}

- (void)_requestGraphs {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://itch.io/api/1/%@/my-games/graphs?num_days=30", self.key];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        self.graphData = responseDict;
        
    } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}


@end
