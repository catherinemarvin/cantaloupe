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
    
    self.navigationItem.title = [self.gameData objectForKey:@"title"];
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
        cell = [[KHDetailedGameViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    
    NSString *key = [self.backingKeys objectAtIndex:[indexPath row]];
    id data = [self.gameData objectForKey:key];
    
    [cell configureWithData:@{[[self keyToLabel] objectForKey:key]: data}];
    return cell;
}

- (NSDictionary *)keyToLabel {
    return @{@"cover_url": NSLocalizedString(@"Cover image", nil),
             @"created_at": NSLocalizedString(@"Created at", nil),
             @"downloads_count": NSLocalizedString(@"Number of downloads", nil),
             @"id": NSLocalizedString(@"Game ID", nil),
             @"min_price": NSLocalizedString(@"Minimum price", nil),
             @"p_android": NSLocalizedString(@"Android availibility", nil),
             @"p_linux": NSLocalizedString(@"Linux availability", nil),
             @"p_osx": NSLocalizedString(@"OSX availability", nil),
             @"p_windows": NSLocalizedString(@"Windows availability", nil),
             @"published": NSLocalizedString(@"Published", nil),
             @"published_at": NSLocalizedString(@"Publish date", nil),
             @"purchases_count": NSLocalizedString(@"Number of purchases", nil),
             @"short_text": NSLocalizedString(@"Short description", nil),
             @"title": NSLocalizedString(@"Title", nil),
             @"type": NSLocalizedString(@"Type", nil),
             @"url": NSLocalizedString(@"URL", nil),
             @"views_count": NSLocalizedString(@"Number of views", nil),
             @"earnings": NSLocalizedString(@"Earnings", nil)};
}

@end
