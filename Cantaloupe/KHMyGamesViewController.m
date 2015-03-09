//
//  KHMyGamesViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/6/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

// Views
#import "KHMyGamesViewController.h"
#import "KHGameViewCell.h"
#import "KHDetailedGameViewController.h"

// Data Source
#import "KHMyGamesDataSource.h"

@interface KHMyGamesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,  KHMyGamesDataSourceDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) KHMyGamesDataSource *dataSource;

@end

static NSString *KHkGameCellIdentifier = @"gameCellIdentifier";

@implementation KHMyGamesViewController

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [[KHMyGamesDataSource alloc] initWithDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupCollectionView];
    [self _setupRefreshControl];
    [self _setupNavigationBar];
    [self.dataSource requestGames];
}

- (void)_setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[KHGameViewCell class] forCellWithReuseIdentifier:KHkGameCellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorFromHexString:@"222222"];
    [self.view addSubview:self.collectionView];
}

- (void)_setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(_refresh) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

- (void)_setupNavigationBar {
    self.navigationItem.title = NSLocalizedString(@"My Games", nil);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KHkGameCellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[KHGameViewCell class]]) {
        KHGameViewCell *gameCell = (KHGameViewCell *)cell;
        KHGameInfo *info = [self.dataSource infoAtIndex:indexPath.row];
        [gameCell configureWithGameInfo:info];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KHGameInfo *gameInfo = [self.dataSource infoAtIndex:indexPath.row];
    KHDetailedGameViewController *vc = [[KHDetailedGameViewController alloc] initWithGameInfo:gameInfo];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat sideLength = 100;
    return CGSizeMake(sideLength, sideLength);
}


#pragma mark - UIRefreshControl

- (void)_refresh {
    [self.dataSource requestGames];
}

#pragma mark - KHMyGamesDataSourceDelegate

- (void)gamesFetched {
    [self.collectionView reloadData];
}

- (void)gameFetchError:(NSError *)error {
    
}

@end
