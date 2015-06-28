//
//  PlayingCard.m
//  Machismo
//
//  Created by Meng on 15/5/18.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    // two card match
//    if ([otherCards count] == 1)
//    {
//        PlayingCard *otherCard = [otherCards firstObject];
//        if ([self.suit isEqualToString:otherCard.suit])
//        {
//            score = 1;
//        }
//        else if (self.rank == otherCard.rank)
//        {
//            score = 4;
//        }
//    }
    
    // n card match ( at least two card have same element,we think they are matched ）
    for (PlayingCard *otherCard in otherCards)
    {
        if ([self.suit isEqualToString:otherCard.suit])
        {
            score += 1;
        }
        else if (self.rank == otherCard.rank)
        {
            score += 4;
        }
    }
    
    return score;
}

- (NSString *) contents
{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;//because we provide setter AND getter

+ (NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank
{   return [[self rankStrings] count] - 1;  }

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
