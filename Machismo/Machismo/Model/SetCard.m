//
//  SetCard.m
//  Machismo
//
//  Created by Meng on 15/6/10.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@end

@implementation SetCard

- (NSString *)contents
{
    return nil;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
   
    if ([otherCards count] == 2)
    {
        SetCard *firstCard = [otherCards firstObject];
        SetCard *secondCard = [otherCards lastObject];
        if ([self.suit isEqualToString:firstCard.suit] && [firstCard.suit isEqualToString:secondCard.suit])
        {
            score += 1;
        }
        else if (![self.suit isEqualToString:firstCard.suit] && ![self.suit isEqualToString:secondCard.suit] && ![firstCard.suit isEqualToString:secondCard.suit])
        {
            score += 1;
        }
        else
        {
            score -= 1;
        }
        
        if ([self.color isEqualToString:firstCard.color] && [firstCard.color isEqualToString:secondCard.color])//全相等
        {
            score += 1;
        }
        else if (![self.color isEqualToString:firstCard.color] && ![self.color isEqualToString:secondCard.color] && ![firstCard.color isEqualToString:secondCard.color])//全不相等
        {
            score += 1;
        }
        else
        {
            score -= 1;
        }
        
        if ((self.shading == firstCard.shading) && (firstCard.shading == secondCard.shading))
        {
            score += 1;
        }
        else
        {
            score -= 1;
        }

    }
    
    if (score == 4)
    {
        score = 1;
    }
    else
    {
        score = 0;
    }
    
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"▲",@"▲▲",@"▲▲▲",@"●",@"●●",@"●●●",@"■",@"■ ■",@"■ ■ ■"];
}

+ (NSArray *)validColors
{
    return @[@"red",@"green",@"purple"];
}


+ (NSUInteger)shadingNumber
{
    return 2;
}

@end
