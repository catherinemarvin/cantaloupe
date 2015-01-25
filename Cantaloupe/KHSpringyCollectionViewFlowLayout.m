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

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIAttachmentBehavior class]]) {
            UIAttachmentBehavior *springBehavior = (UIAttachmentBehavior *)obj;
            CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehavior.anchorPoint.y);
            CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehavior.anchorPoint.x);
            CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0f;
            
            UICollectionViewLayoutAttributes *item = springBehavior.items.firstObject;
            CGPoint center = item.center;
            if (delta < 0) {
                center.y += MAX(delta, delta * scrollResistance);
                
            } else {
                center.y += MIN(delta, delta*scrollResistance);
            }
            item.center = center;
            
            [self.dynamicAnimator updateItemUsingCurrentState:item];
        }
    }];
    return NO;
}

@end
