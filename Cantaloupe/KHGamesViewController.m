//
//  KHGamesViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/18/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHGamesViewController.h"
#import "AFNetworking.h"
#import "KHGameViewCell.h"
#import "KHDetailedGameViewController.h"

@interface KHGamesViewController ()

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSArray *games;

@end

static NSString *kGameCellIdentifier = @"gameCellIdentifier";
@implementation KHGamesViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout key:(NSString *)key {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.key = key;
        [self.collectionView registerClass:[KHGameViewCell class] forCellWithReuseIdentifier:kGameCellIdentifier];
        [self _requestGames];
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.title = NSLocalizedString(@"Games", nil);
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Lato-Regular" size:24.0f] forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code == -1009) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Please connect to the Internet and try again", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
            [alert show];
            return;
        }
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
    KHGameViewCell *cell = (KHGameViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kGameCellIdentifier forIndexPath:indexPath];
    [cell setTitleText:[[self.games objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KHDetailedGameViewController *detailedView = [[KHDetailedGameViewController alloc] initWithStyle:UITableViewStyleGrouped];
    NSDictionary *gameData = [self.games objectAtIndex:[indexPath row]];
    [detailedView configureWithData:gameData];
    
    [self.navigationController pushViewController:detailedView animated:YES];
}

@end
