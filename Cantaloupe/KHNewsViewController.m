//
//  KHNewsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/5/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewController.h"
#import "AFNetworking.h"

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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *key = @"nadyVe3mHbqHOtDnYU3H5lI44MDWS2k8rPJdLakyVKh8k1fgmc";
    NSString *url = [NSString stringWithFormat:@"http://api.tumblr.com/v2/blog/itchio.tumblr.com/posts?api_key=%@", key];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code == -1009) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Please connect to the Internet and try again", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [alert show];
        }
    }];
}

@end
