//
//  Card.m
//  Machismo
//
//  Created by Meng on 15/5/17.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

@end
