//
//  KHTabBarController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/18/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHTabBarController.h"
#import "KHGamesViewController.h"
#import "KHPurchasesViewController.h"

typedef NS_ENUM(NSInteger, KHTabViewControllerTag) {
    KHGamesViewControllerTag,
    KHPurchasesViewControllerTag
};

@interface KHTabBarController ()

@property (nonatomic, strong) KHGamesViewController *gamesViewController;
@property (nonatomic, strong) KHPurchasesViewController *purchasesViewController;

@end

@implementation KHTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        self.gamesViewController = [[KHGamesViewController alloc] initWithStyle:UITableViewStylePlain];
        self.gamesViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:KHGamesViewControllerTag];
        
        self.purchasesViewController = [[KHPurchasesViewController alloc] init];
        self.purchasesViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:KHPurchasesViewControllerTag];
        
        
        NSArray *viewControllers = @[self.gamesViewController, self.purchasesViewController];
        [self setViewControllers:viewControllers];
    }
    return self;
}


@end
