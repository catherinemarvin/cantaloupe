//
//  KHGameViewCell.h
//  Cantaloupe
//
//  Created by Kevin Hwang on 3/28/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KHGameInfo;

@interface KHGameViewCell : UICollectionViewCell

- (void)configureWithGameInfo:(KHGameInfo *)gameInfo;

@end
