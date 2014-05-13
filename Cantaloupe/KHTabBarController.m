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
#import "KHGraphsViewController.h"

typedef NS_ENUM(NSInteger, KHTabViewControllerTag) {
    KHGamesViewControllerTag,
    KHSettingsViewControllerTag,
    KHGraphsViewControllerTag
};

@interface KHTabBarController ()

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) KHGamesViewController *gamesViewController;
@property (nonatomic, strong) KHSettingsViewController *settingsViewController;
@property (nonatomic, strong) KHGraphsViewController *graphsViewController;

@end

@implementation KHTabBarController

- (id)initWithKey:(NSString *)key;
{
    self = [super init];
    if (self) {
        self.key = key;
        
//        self.gamesViewController = [[KHGamesViewController alloc] initWithStyle:UITableViewStylePlain key:key];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.gamesViewController = [[KHGamesViewController alloc] initWithCollectionViewLayout:layout key:key];
        self.gamesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Games",nil) image:[UIImage imageNamed:@"gamesIcon"] tag:KHGamesViewControllerTag];
        UINavigationController *gamesNav = [[UINavigationController alloc] initWithRootViewController:self.gamesViewController];
        
        self.settingsViewController = [[KHSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        self.settingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) image:[UIImage imageNamed:@"settingsIcon"] tag:KHSettingsViewControllerTag];
        UINavigationController *settingsNav = [[UINavigationController alloc] initWithRootViewController:self.settingsViewController];
        
        self.graphsViewController = [[KHGraphsViewController alloc] initWithKey:self.key];
        self.graphsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Graphs", nil) image:[UIImage imageNamed:@"graphsIcon"] tag:KHGraphsViewControllerTag];
        UINavigationController *graphsNav = [[UINavigationController alloc] initWithRootViewController:self.graphsViewController];
        
        //NSArray *viewControllers = @[gamesNav, graphsNav, settingsNav];
        NSArray *viewControllers = @[gamesNav, settingsNav];
        [self setViewControllers:viewControllers];
    }
    return self;
}


@end
