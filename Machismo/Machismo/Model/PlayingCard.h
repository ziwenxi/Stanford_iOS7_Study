//
//  PlayingCard.h
//  Machismo
//
//  Created by Meng on 15/5/18.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
