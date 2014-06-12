//
//  KHNewsViewController.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 6/5/14.
//  Copyright (c) 2014 Kevin Hwang. All rights reserved.
//

#import "KHNewsViewController.h"
#import "AFNetworking.h"
#import "KHNewsViewCell.h"

@interface KHNewsViewController ()

@property (nonatomic, strong) NSArray *posts;

@end

static NSString *kNewsCellIdentifier = @"newsCellIdentifier";

@implementation KHNewsViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self.collectionView registerClass:[KHNewsViewCell class] forCellWithReuseIdentifier:kNewsCellIdentifier];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _requestNews];
}

- (void)_requestNews {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *key = @"nadyVe3mHbqHOtDnYU3H5lI44MDWS2k8rPJdLakyVKh8k1fgmc";
    NSString *url = [NSString stringWithFormat:@"http://api.tumblr.com/v2/blog/itchio.tumblr.com/posts?api_key=%@", key];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        self.posts = [responseDict valueForKeyPath:@"response.posts"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code == -1009) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Please connect to the Internet and try again", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [alert show];
        }
    }];
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KHNewsViewCell *cell = (KHNewsViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kNewsCellIdentifier forIndexPath:indexPath];
    [cell configureWithNews:[self.posts objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Collection View Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width, 200.0f);
}

@end
