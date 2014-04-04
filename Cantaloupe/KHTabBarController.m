//
//  KHTabBarController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/18/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHTabBarController.h"
#import "KHGamesViewController.h"
#import "KHSettingsViewController.h"

typedef NS_ENUM(NSInteger, KHTabViewControllerTag) {
    KHGamesViewControllerTag,
    KHSettingsViewControllerTag
};

@interface KHTabBarController ()

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) KHGamesViewController *gamesViewController;
@property (nonatomic, strong) KHSettingsViewController *settingsViewController;

@end

@implementation KHTabBarController

- (id)initWithKey:(NSString *)key;
{
    self = [super init];
    if (self) {
        self.key = key;
        
        self.gamesViewController = [[KHGamesViewController alloc] initWithStyle:UITableViewStylePlain key:key];
        self.gamesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Games" image:[UIImage imageNamed:@"gamesIcon"] tag:KHGamesViewControllerTag];
        UINavigationController *gamesNav = [[UINavigationController alloc] initWithRootViewController:self.gamesViewController];
        
        self.settingsViewController = [[KHSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        self.settingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settingsIcon"] tag:KHSettingsViewControllerTag];
        UINavigationController *settingsNav = [[UINavigationController alloc] initWithRootViewController:self.settingsViewController];
        
        NSArray *viewControllers = @[gamesNav, settingsNav];
        [self setViewControllers:viewControllers];
    }
    return self;
}


@end
