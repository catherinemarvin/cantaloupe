//
//  KHDetailedGameViewController.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/29/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  KHGameInfo;

@interface KHDetailedGameViewController : UIViewController

- (id)initWithGameInfo:(KHGameInfo *)info NS_DESIGNATED_INITIALIZER;

@end
