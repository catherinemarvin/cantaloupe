//
//  KHDetailedGameViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHDetailedGameViewController.h"
#import "KHDetailedGameViewCell.h"

@interface KHDetailedGameViewController ()

@property (nonatomic, strong) NSDictionary *gameData;
@property (nonatomic, strong) NSArray *backingKeys;

@end

static NSString *kCellIdentifier = @"kDetailedGameViewCellIdentifier";

@implementation KHDetailedGameViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView registerClass:[KHDetailedGameViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return self;
}

#pragma mark - Configuring data

- (void)configureWithData:(NSDictionary *)gameData {
    self.gameData = gameData;
    self.backingKeys = [[self.gameData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.backingKeys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KHDetailedGameViewCell *cell = (KHDetailedGameViewCell *) [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[KHDetailedGameViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    
    NSString *key = [self.backingKeys objectAtIndex:[indexPath row]];
    id data = [self.gameData objectForKey:key];
    
    [cell configureWithData:@{key: data}];
    return cell;
}

@end
