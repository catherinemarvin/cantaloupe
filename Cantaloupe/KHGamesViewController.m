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

- (id)initWithStyle:(UITableViewStyle)style key:(NSString *)key
{
    self = [super initWithStyle:style];
    if (self) {
        self.key = key;
        [self.tableView registerClass:[KHGameViewCell class] forCellReuseIdentifier:kGameCellIdentifier];
        self.tableView.separatorInset = UIEdgeInsetsZero;
        [self _requestGames];
    }
    return self;
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
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGameCellIdentifier forIndexPath:indexPath];
    
    UILabel *gameTitle = [[UILabel alloc] initWithFrame:cell.frame];
    gameTitle.text = [[self.games objectAtIndex:[indexPath row]] valueForKey:@"title"];
    [cell.contentView addSubview:gameTitle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KHDetailedGameViewController *detailedView = [[KHDetailedGameViewController alloc] initWithStyle:UITableViewStyleGrouped];
    NSDictionary *gameData = [self.games objectAtIndex:[indexPath row]];
    [detailedView configureWithData:gameData];
    
    [self.navigationController pushViewController:detailedView animated:YES];
}

@end
