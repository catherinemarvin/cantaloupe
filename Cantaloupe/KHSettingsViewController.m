//
//  KHSettingsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 4/1/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHSettingsViewController.h"
#import "KHSettingsViewCell.h"
#import "KHSessionController.h"
#import <MessageUI/MessageUI.h>

static NSString *kSettingsCellIdentifier = @"kSettingsCell";
static CGFloat kSectionHeaderHeight = 30.0f;

typedef NS_ENUM(NSUInteger, KHSettingsCells) {
    KHSettingCellNone,
    KHSettingCellLogout,
    KHSettingCellUsername,
    KHSettingCellContact
};

@interface KHSettingsViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSArray *settingItems;
@property (nonatomic, strong)NSArray *userItems;
@property (nonatomic, strong) NSArray *helpItems;

@end

@implementation KHSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.settingItems = @[@(KHSettingCellLogout)];
        self.userItems = @[@(KHSettingCellUsername)];
        self.helpItems = @[@(KHSettingCellContact)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Settings", nil);
    [self.tableView registerClass:[KHSettingsViewCell class] forCellReuseIdentifier:kSettingsCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Settings Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.settingItems.count;
    } else if (section == 1) {
        return self.userItems.count;
    } else if (section == 2) {
        return self.helpItems.count;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, kSectionHeaderHeight)];
    CGFloat leftPadding = 15.0f;
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 0.0f, tableView.frame.size.width - leftPadding, kSectionHeaderHeight)];
    NSString *text;
    if (section == 0) {
        text = NSLocalizedString(@"MANAGEMENT", nil);
    } else if (section == 1) {
        text = NSLocalizedString(@"INFORMATION", nil);
    } else if (section == 2) {
        text = NSLocalizedString(@"HELP", nil);
    }
    header.text = text;
    header.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    header.textColor = [UIColor grayColor];
    [headerView addSubview:header];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
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
    
    NSArray *backingData;
    if (indexPath.section == 0) {
        backingData = self.settingItems;
    } else if (indexPath.section == 1) {
        backingData = self.userItems;
    } else if (indexPath.section == 2) {
        backingData = self.helpItems;
    } else {
        return;
    }
    
    NSInteger row = indexPath.row;
    if (row < backingData.count) {
        cellType = (KHSettingsCells) [backingData[row] unsignedIntegerValue];
    }
    
    switch (cellType) {
        case KHSettingCellLogout:
            cell.textLabel.text = NSLocalizedString(@"Logout", nil);
            cell.tag = KHSettingCellLogout;
            break;
        case KHSettingCellUsername:
            cell.textLabel.text = NSLocalizedString(@"Username", nil);
            cell.detailTextLabel.text = [[KHSessionController sharedInstance] username];
            cell.tag = KHSettingCellUsername;
            break;
        case KHSettingCellContact:
            cell.textLabel.text = NSLocalizedString(@"Contact", nil);
            cell.tag = KHSettingCellContact;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case KHSettingCellLogout:
            [[KHSessionController sharedInstance] logout];
            break;
        case KHSettingCellContact:
            [self _composeMail];
            break;
        default:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            break;
    }
}

#pragma mark - Help methods

- (void)_composeMail {
    if (![MFMailComposeViewController canSendMail]) {
        return;
    }
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    [mailController setToRecipients:@[@"k3vinhwang@gmail.com"]];
    [mailController setSubject:NSLocalizedString(@"Itch.io App Feedback", nil)];
    
    [self presentViewController:mailController animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    void (^completionBlock)(void) = nil;
    
    if (result == MFMailComposeResultSent) {
        completionBlock = ^() {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Thank you", nil) message:NSLocalizedString(@"Thanks for the feedback.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil] show];
        };
        
    }
    
    [self dismissViewControllerAnimated:YES completion:completionBlock];
}

@end
