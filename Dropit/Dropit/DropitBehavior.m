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
@end

@implementation DropitBehavior

- (UIGravityBehavior *)gravity
{
    if(!_gravity)
    {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
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

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collider];
    }
    
    return self;
}

- (void)addItem:(id <UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
}

- (void)removeItem:(id <UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}

@end
