//
//  KHCollectionViewLayout.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 5/12/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHCollectionViewLayout.h"

@implementation KHCollectionViewLayout

- (id)init {
    if (self = [super init]) {
        self.itemSize = CGSizeMake(315.0f, 250.0f);
        self.minimumInteritemSpacing = 20.0f;
        self.minimumLineSpacing = 20.0f;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(32, 32, 32, 32);
    }
    return self;
}

@end
