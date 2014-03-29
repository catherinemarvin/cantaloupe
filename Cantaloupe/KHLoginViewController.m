//
//  KHLoginViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/19/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHLoginViewController.h"
#import "AFNetworking.h"
#import "KHTabBarController.h"
#import <QuartzCore/QuartzCore.h>

@interface KHLoginViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *kCellIdentifier = @"loginCell";

@implementation KHLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.usernameField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.usernameField.placeholder = NSLocalizedString(@"Username", nil);
        self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.usernameField.returnKeyType = UIReturnKeyNext;
        self.usernameField.delegate = self;
        
        self.passwordField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.passwordField.placeholder = NSLocalizedString(@"Password", nil);
        self.passwordField.secureTextEntry = YES;
        self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.passwordField.returnKeyType = UIReturnKeyGo;
        self.passwordField.delegate = self;
        
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat xMargin = 20.0f;
    CGFloat yMargin = 20.0f;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(xMargin, yMargin, floorf(view.bounds.size.width - 2 * xMargin), 132.0f) style:UITableViewStyleGrouped];
    tableView.layer.cornerRadius = 10.0f;
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.layer.borderWidth = 1.0f;
    tableView.layer.borderColor = tableView.separatorColor.CGColor;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollEnabled = NO;
    [view addSubview:tableView];
    
    self.loginButton.frame = CGRectZero;
    [view addSubview:self.loginButton];
    
    self.view = view;
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    // Configure cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat xOffset = 20.0f;
    switch (indexPath.row) {
        case 0:
            self.usernameField.frame = CGRectMake(xOffset, cell.frame.origin.y, tableView.frame.size.width - 2 * xOffset, cell.frame.size.height);
            [cell.contentView addSubview:self.usernameField];
            break;
        case 1:
            self.passwordField.frame = CGRectMake(xOffset, cell.frame.origin.y, tableView.frame.size.width - 2 * xOffset, cell.frame.size.height);
            [cell.contentView addSubview:self.passwordField];
            break;
        case 2:
            self.loginButton.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
            [cell.contentView addSubview:self.loginButton];
            break;
        default:
            break;
    }
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
    cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, tableView.frame.size.width, cell.contentView.frame.size.height);
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
        return NO;
    } else {
        [textField resignFirstResponder];
        [self loginTapped:nil];
        return YES;
    }
}

#pragma mark - Button press

- (void)loginTapped:(id)sender {
    if ([self _validateFields]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"username": [self.usernameField text], @"password": [self.passwordField text], @"source": @"android"};
        [manager POST:@"http://itch.io/api/1/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSDictionary *responseDict = (NSDictionary *) responseObject;
            
            NSArray *errors = [responseDict valueForKey:@"errors"];
            
            if (errors) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Something went wrong.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
                [alert show];
                return;
            }
            NSString *key = [[responseDict valueForKey:@"key"] valueForKey:@"key"];
            
            KHTabBarController *controller = [[KHTabBarController alloc] initWithKey:key];
            [self presentViewController:controller animated:YES completion:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (BOOL)_validateFields {
    NSString *error;
    
    if (!self.usernameField.text || !self.passwordField.text || [self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        error = NSLocalizedString(@"Username and password cannot be blank.", nil);
    }
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:error delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
        [alert show];
    }
    
    return error == nil;
}


@end
