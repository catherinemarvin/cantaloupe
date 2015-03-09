//
//  KHAppDelegate.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/17/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHAppDelegate.h"
#import "KHLoginViewController.h"
#import "KHSessionController.h"
#import "KHTabBarController.h"

// Appearance
#import "UIFont+KHAdditions.h"

@implementation KHAppDelegate

- (void)dealloc {
    [[KHSessionController sharedInstance] removeObserver:self forKeyPath:@"loggedIn"];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Add analytics
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-50979066-1"];
    
#ifdef DEBUG
    
    [GAI sharedInstance].dryRun = YES;
    
#endif
    
    // Setup CocoaLumberjack
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    // Set appearances
    [self _setupUI];
    
    // Create and display view
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    KHSessionController *session = [KHSessionController sharedInstance];
    
    UIViewController *mainController;
    if (session.loggedIn) {
        mainController = [[KHTabBarController alloc] initWithKey:session.key];
    } else {
        mainController = [[KHLoginViewController alloc] init];
    }
    
    [session addObserver:self forKeyPath:@"loggedIn" options:0 context:nil];
    
    self.window.rootViewController = mainController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)_setupUI {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    UINavigationBar *navBarAppearance = [UINavigationBar appearance];
    
    NSMutableDictionary *titleBarDictionary = [NSMutableDictionary dictionaryWithDictionary:[navBarAppearance titleTextAttributes]];
    [titleBarDictionary setValue:[UIFont regularWithSize:24.0f] forKey:NSFontAttributeName];
    [titleBarDictionary setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [navBarAppearance setTitleTextAttributes:titleBarDictionary];
    [navBarAppearance setBarTintColor:[UIColor colorFromHexString:@"fa5c5c"]];
    [navBarAppearance setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
    NSMutableDictionary *barButtonDictionary = [NSMutableDictionary dictionaryWithDictionary:[barButtonAppearance titleTextAttributesForState:UIControlStateNormal]];
    [barButtonDictionary setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [barButtonAppearance setTitleTextAttributes:barButtonDictionary forState:UIControlStateNormal];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loggedIn"]) {
        if (![KHSessionController sharedInstance].loggedIn) {
            // If you logged out, quit everything and get dumped back to the login screen.
            self.window.rootViewController = [[KHLoginViewController alloc] init];
        }
    }
}

@end
