//
//  KHLoginViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/19/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHLoginViewController.h"
#import "KHLoginView.h"
#import "AFNetworking.h"
#import "KHTabBarController.h"

@interface KHLoginViewController ()

@property (nonatomic, strong) KHLoginView *loginView;

@end

@implementation KHLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    self.loginView = [[KHLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.loginView;
    [self.loginView.loginButton addTarget:self action:@selector(loginTapped:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button press

- (void)loginTapped:(id)sender {
    NSLog(@"Hello");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username": [self.loginView.usernameField text], @"password": [self.loginView.passwordField text], @"source": @"android"};
    [manager POST:@"http://itch.io/api/1/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *responseDict = (NSDictionary *) responseObject;
        NSString *key = [[responseDict valueForKey:@"key"] valueForKey:@"key"];
        
        KHTabBarController *controller = [[KHTabBarController alloc] initWithKey:key];
        [self presentViewController:controller animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
