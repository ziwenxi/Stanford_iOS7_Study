//
//  PlayingCardMatchingGame.m
//  Machismo
//
//  Created by Meng on 15/6/11.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

@interface PlayingCardMatchingGame()

@property (nonatomic,readwrite) NSString *gameState;

@end

@implementation PlayingCardMatchingGame

- (void)chooseCardAtIndex:(NSUInteger)index
{
    int forwardScore = self.score;
    [super chooseCardAtIndex:index];
    [self updateGameState:forwardScore withIndexOfCard:index];
}

- (void)updateGameState:(int)forwardScore withIndexOfCard:(int)index
{
    if (self.score == forwardScore)
    {
        _gameState = [self cardAtIndex:index].contents;
    }
    else if (self.score < (forwardScore - self.gameModel * COST_TO_CHOOSE))
    {
        _gameState = [NSString stringWithFormat:@"%@ with %@ not matched. %d point penalty!",[self cardAtIndex:index].contents,self.validOfOtherCards,forwardScore - self.score];
    }
    else if (self.score > (forwardScore - self.gameModel * COST_TO_CHOOSE))
    {
        _gameState = [NSString stringWithFormat:@"%@ matched %@ . get %d score!",[self cardAtIndex:index].contents,self.validOfOtherCards,self.score - forwardScore];
    }
}

@end
