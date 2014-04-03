//
//  KHSettingsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/1/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHSettingsViewController.h"
#import "KHSettingsViewCell.h"

static NSString *kSettingsCellIdentifier = @"kSettingsCell";

typedef NS_ENUM(NSUInteger, KHSettingsCells) {
    KHSettingCellNone = 1,
    KHSettingCellLogout = 2
};

@interface KHSettingsViewController ()

@property (nonatomic, strong) NSArray *settingItems;

@end

@implementation KHSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.settingItems = @[@(KHSettingCellLogout)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[KHSettingsViewCell class] forCellReuseIdentifier:kSettingsCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KHSettingsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingsCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [self customizeCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)customizeCell:(KHSettingsViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    KHSettingsCells cellType = KHSettingCellNone;
    
    if (indexPath.section == 0) {
        NSInteger row = indexPath.row;
        if (row < self.settingItems.count) {
            cellType = (KHSettingsCells) [self.settingItems[row] unsignedIntegerValue];
        }
    }
    
    switch (cellType) {
        case KHSettingCellLogout:
            cell.textLabel.text = @"Logout";
            cell.tag = KHSettingCellLogout;
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case KHSettingCellLogout:
            NSLog(@"Logout");
            break;
        default:
            break;
    }
}

@end
