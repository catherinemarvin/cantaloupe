//
//  KHGamesViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/18/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGamesViewController.h"
#import "AFNetworking.h"
#import "KHDetailedGameViewController.h"
#import "MBProgressHUD.h"
#import "Cantaloupe-Swift.h"

@interface KHGamesViewController ()

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSArray *games;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

static NSString *kGameCellIdentifier = @"gameCellIdentifier";
@implementation KHGamesViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout key:(NSString *)key {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.key = key;
        [self.collectionView registerClass:[GameViewCell class] forCellWithReuseIdentifier:kGameCellIdentifier];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.collectionView addSubview:self.refreshControl];
        [self.refreshControl addTarget:self action:@selector(_requestGames) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Games", nil);
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Lato-Regular" size:24.0f] forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    
    [self.refreshControl beginRefreshing];
    [self _requestGames];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Games View Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)_requestGames {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://itch.io/api/1/%@/my-games", self.key];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        NSArray *errors = [responseDict valueForKey:@"errors"];
        
        if (errors) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Something went wrong.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
            [alert show];
            return;
        }
        NSArray *games = [responseDict valueForKey:@"games"];
        self.games = games;
        [self.collectionView reloadData];
        
        [self.refreshControl endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code == -1009) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Please connect to the Internet and try again", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
            [alert show];
            return;
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.games count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GameViewCell *cell = (GameViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kGameCellIdentifier forIndexPath:indexPath];
    [cell setGameImage:[[self.games objectAtIndex:indexPath.row] valueForKey:@"cover_url"]];
    [cell setTitle:[[self.games objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KHDetailedGameViewController *detailedView = [[KHDetailedGameViewController alloc] initWithData:[self.games objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:detailedView animated:YES];
}

#pragma mark - Collection View Delegate Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width, 200.0f);
}

@end
