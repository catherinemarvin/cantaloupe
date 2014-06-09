//
//  KHNewsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/5/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewController.h"
#import "TMAPIClient.h"

@interface KHNewsViewController ()

@end

@implementation KHNewsViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self _requestNews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)_requestNews {
    
}

@end
