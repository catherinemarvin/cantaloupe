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

@property (nonatomic, strong) KHLoginManager *loginManager;

@end

static NSString *kKeychainServiceKey = @"com.khwang.Cantaloupe";
static NSString *kUserKey = @"kCantaloupeCurrentUser";

static const int ddLogLevel = LOG_LEVEL_ALL;

@implementation KHLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        _loginManager = [[KHLoginManager alloc] initWithDelegate:self];
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
    [self.loginManager loginWithUsername:self.usernameField.text password:self.passwordField.text];
}

#pragma mark - KHLoginManagerDelegate

- (void)loginCompleted {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    KHTabBarController *controller = [[KHTabBarController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)loginFailedWithErrorTitle:(NSString *)title errorDescription:(NSString *)errorDescription {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:errorDescription preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
