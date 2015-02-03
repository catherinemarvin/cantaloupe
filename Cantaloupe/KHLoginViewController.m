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
#import <SSKeychain/SSKeychain.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "KHLoginView.h"

@interface KHLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *usernameField;
@property (nonatomic, weak) UITextField *passwordField;

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
    KHLoginView *view = [[KHLoginView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.usernameField.delegate = self;
    view.passwordField.delegate = self;
    [view.loginButton addTarget:self action:@selector(_loginTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.usernameField = view.usernameField;
    self.passwordField = view.passwordField;
    
    self.loginView = view;
    self.view = view;
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
                DDLogError(@"Failed to set key: %@", error.debugDescription);
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DDLogError(@"Error: %@", error);
            
            if (error.code == -1004) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No internet", nil) message:NSLocalizedString(@"Please connect to the Internet, then try again.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
                [alert show];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
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
