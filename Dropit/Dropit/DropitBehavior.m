//
//  DropitBehavior.m
//  Dropit
//
//  Created by Meng on 15/6/29.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior()
@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic) UICollisionBehavior *collider;
@property (strong,nonatomic) UIDynamicItemBehavior *itemBehavior;
@end

@implementation DropitBehavior

- (UIGravityBehavior *)gravity
{
    if(!_gravity)
    {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 1.0;
    }
    return _gravity;
}

- (UICollisionBehavior *)collider
{
    if (!_collider)
    {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;//将参考视图设置为自己的bounds
    }
    return _collider;
}

- (UIDynamicItemBehavior *)itemBehavior
{
    if (!_itemBehavior)
    {
        _itemBehavior = [[UIDynamicItemBehavior alloc] init];
        _itemBehavior.allowsRotation = NO;
    }
    
    return _itemBehavior;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collider];
        [self addChildBehavior:self.itemBehavior];
    }
    
    return self;
}

- (void)addItem:(id <UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.itemBehavior addItem:item];
}

- (void)removeItem:(id <UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.itemBehavior removeItem:item];
}

@end
