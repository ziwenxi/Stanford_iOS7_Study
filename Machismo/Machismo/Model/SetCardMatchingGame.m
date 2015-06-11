//
//  SetCardMatchingGame.m
//  Machismo
//
//  Created by Meng on 15/6/11.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "SetCard.h"

@interface SetCardMatchingGame()

@property (nonatomic,readwrite) NSString *gameState;

@end

@implementation SetCardMatchingGame

- (void)chooseCardAtIndex:(NSUInteger)index
{
    int forwardScore = self.score;
    [super chooseCardAtIndex:index];
    [self updateGameState:forwardScore withIndexOfCard:index];
}

- (NSString *)validOfOtherCards:(NSArray *)otherCards
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (SetCard *card in otherCards)
    {
        [string appendString:card.suit];
    }
    return string;
}

- (void)updateGameState:(int)forwardScore withIndexOfCard:(int)index
{
    if (self.score == forwardScore)
    {
        _gameState = ((SetCard *)[self cardAtIndex:index]).suit;
    }
    else if (self.score < (forwardScore - self.gameModel * COST_TO_CHOOSE))
    {
        _gameState = [NSString stringWithFormat:@"%@ with %@ not matched. %d point penalty!",((SetCard *)[self cardAtIndex:index]).suit,self.validOfOtherCards,forwardScore - self.score];
    }
    else if (self.score > (forwardScore - self.gameModel * COST_TO_CHOOSE))
    {
        _gameState = [NSString stringWithFormat:@"%@ matched %@ . get %d score!",((SetCard *)[self cardAtIndex:index]).suit,self.validOfOtherCards,self.score - forwardScore];
    }
}

@end
