//
//  KHSpringyCollectionViewFlowLayout.m
//  Cantaloupe
//
//  Created by Kevin Hwang on 1/24/15.
//  Copyright (c) 2015 Kevin Hwang. All rights reserved.
//

#import "KHSpringyCollectionViewFlowLayout.h"

@implementation KHSpringyCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    CGSize contentSize = self.collectionView.contentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height)];
    
    if (self.dynamicAnimator.behaviors.count == 0) {
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj conformsToProtocol:@protocol(UIDynamicItem)]) {
                id<UIDynamicItem> item = (id<UIDynamicItem>) obj;
                UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
                
                behavior.length = 0.0f;
                behavior.damping = 0.8f;
                behavior.frequency = 1.0f;
                
                [self.dynamicAnimator addBehavior:behavior];
                
            }
        }];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

@end
