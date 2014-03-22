//
//  KHLoginViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/19/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHLoginViewController.h"
#import "KHLoginView.h"

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
}


@end
