//
//  KHAppDelegate.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/17/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHAppDelegate.h"
#import "KHLoginViewController.h"

@implementation KHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    KHLoginViewController *mainController = [[KHLoginViewController alloc] init];
    
    self.window.rootViewController = mainController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
