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
#import "SSKeychain.h"

@interface KHLoginViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *kCellIdentifier = @"loginCell";
static NSString *kKeychainServiceKey = @"com.khwang.Cantaloupe";
static NSString *kUserKey = @"kCantaloupeCurrentUser";


@implementation KHLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.usernameField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.usernameField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        self.usernameField.placeholder = NSLocalizedString(@"Username", nil);
        self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.usernameField.returnKeyType = UIReturnKeyNext;
        self.usernameField.delegate = self;
        
        self.passwordField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.passwordField.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
        self.passwordField.placeholder = NSLocalizedString(@"Password", nil);
        self.passwordField.secureTextEntry = YES;
        self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.passwordField.returnKeyType = UIReturnKeyGo;
        self.passwordField.delegate = self;
        
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.loginButton.titleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:16.0f];
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGRect frame = self.tableView.frame;
    frame.size.width = floorf(self.view.bounds.size.width - 2 * 20.0f);
    self.tableView.frame = frame;
    
    CGRect loginFrame = self.loginButton.frame;
    loginFrame.size.width = frame.size.width;
    self.loginButton.frame = loginFrame;
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
        NSString *username = [self.usernameField text];
        NSDictionary *parameters = @{@"username": username, @"password": [self.passwordField text], @"source": @"android"};
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
            
            // Save in defaults
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:username forKey:kUserKey];
            [defaults synchronize];
            // Save key in keychain so we don't have to relogin.
            
            NSError *error = nil;
            if ([SSKeychain setPassword:key forService:kKeychainServiceKey account:username error:&error] && !error) {
                // No error, save Core data perhaps?
                
            } else {
                NSLog(@"Failed to set key: %@", error.debugDescription);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
            if (error.code == -1004) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No internet", nil) message:NSLocalizedString(@"Please connect to the Internet, then try again.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
                [alert show];
                return;
            }
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
