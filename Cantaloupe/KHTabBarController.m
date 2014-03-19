//
//  KHTabBarController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/18/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHTabBarController.h"
#import "KHGamesViewController.h"

@interface KHTabBarController ()

@property (nonatomic, strong) KHGamesViewController *gamesViewController;

@end

@implementation KHTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        self.gamesViewController = [[KHGamesViewController alloc] initWithStyle:UITableViewStylePlain];
        
        NSArray *viewControllers = @[self.gamesViewController];
        
        [self setViewControllers:viewControllers];
    }
    return self;
}


@end
