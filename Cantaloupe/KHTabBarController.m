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

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) KHGamesViewController *gamesViewController;
@property (nonatomic, strong) KHPurchasesViewController *purchasesViewController;

@end

@implementation KHTabBarController

- (id)initWithKey:(NSString *)key;
{
    self = [super init];
    if (self) {
        self.key = key;
        self.gamesViewController = [[KHGamesViewController alloc] initWithStyle:UITableViewStylePlain];
        self.gamesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Games" image:[UIImage imageNamed:@"gamesIcon"] tag:KHGamesViewControllerTag];
        
        self.purchasesViewController = [[KHPurchasesViewController alloc] init];
        self.purchasesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Purchases" image:[UIImage imageNamed:@"purchasesIcon"] tag:KHPurchasesViewControllerTag];
        
        NSArray *viewControllers = @[self.gamesViewController, self.purchasesViewController];
        [self setViewControllers:viewControllers];
    }
    return self;
}


@end
