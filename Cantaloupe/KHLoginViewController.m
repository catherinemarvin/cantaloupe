//
//  KHLoginViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/19/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHLoginViewController.h"
// Views
#import "KHLoginView.h"
#import "KHTabBarController.h"
#import <MBProgressHUD/MBProgressHUD.h>

// Data Manager
#import "KHLoginManager.h"

@interface KHLoginViewController ()<UITextFieldDelegate, KHLoginManagerDelegate>

@property (nonatomic, weak) UITextField *usernameField;
@property (nonatomic, weak) UITextField *passwordField;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) KHLoginView *loginView;

@end

static NSString *kKeychainServiceKey = @"com.khwang.Cantaloupe";
static NSString *kUserKey = @"kCantaloupeCurrentUser";

static const int ddLogLevel = LOG_LEVEL_ALL;

@implementation KHLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    scrollView.backgroundColor = [UIColor darkBackgroundColor];
    KHLoginView *view = [[KHLoginView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.usernameField.delegate = self;
    view.passwordField.delegate = self;
    [view.loginButton addTarget:self action:@selector(_loginTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.usernameField = view.usernameField;
    self.passwordField = view.passwordField;
    
    
    [scrollView addSubview:view];
    
    self.loginView = view;
    self.scrollView = scrollView;
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Login Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    [self.loginView animate];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
        return NO;
    } else {
        [textField resignFirstResponder];
        [self _loginTapped:nil];
        return YES;
    }
}

#pragma mark - UIKeyboardNotifications

- (void)_keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    CGPoint bottomPoint = CGPointMake(0, CGRectGetMaxY(self.loginView.formContainer.frame));
    if (!CGRectContainsPoint(aRect, bottomPoint)) {
        CGPoint contentOffset = CGPointMake(0, CGRectGetMinY(self.loginView.formContainer.frame) / 2);
        [self.scrollView setContentOffset:contentOffset];
    }
}

- (void)_keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    [self.scrollView setContentOffset:CGPointZero];
}

#pragma mark - Button press

- (void)_loginTapped:(id)sender {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"button_press" label:@"login" value:nil] build]];
    
    if ([self _validateFields]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *username = [self.usernameField text];
        NSDictionary *parameters = @{@"username": username, @"password": [self.passwordField text], @"source": @"android"};
        [manager POST:@"http://itch.io/api/1/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *responseDict = (NSDictionary *) responseObject;
            
            NSArray *errors = [responseDict valueForKey:@"errors"];
            
            if (errors) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Something went wrong.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
                [alert show];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                return;
            }
            NSString *key = [[responseDict valueForKey:@"key"] valueForKey:@"key"];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DDLogError(@"Error: %@", error);
            
            if (error.code == -1004) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No internet", nil) message:NSLocalizedString(@"Please connect to the Internet, then try again.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
                [alert show];
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

#pragma mark - KHLoginManagerDelegate

- (void)loginCompleted {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    KHTabBarController *controller = [[KHTabBarController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)loginFailedWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)loginFailedWithErrors:(NSArray *)errors {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
