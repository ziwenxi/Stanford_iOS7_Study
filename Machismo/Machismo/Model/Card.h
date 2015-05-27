//
//  Card.h
//  Machismo
//
//  Created by Meng on 15/5/17.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString *contents;
@property (nonatomic,getter=isChosen) BOOL chosen;
@property (nonatomic,getter=isMacthed) BOOL matched;

- (int)match:(NSArray *)otherCards;
@end
