//
//  DropitBehavior.h
//  Dropit
//
//  Created by Meng on 15/6/29.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
