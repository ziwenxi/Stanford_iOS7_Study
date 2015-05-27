//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Meng on 15/5/22.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards;//of card
@property (nonatomic,readwrite) NSString *gameState;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BOUNDS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMacthed)
    {
        if (card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            // match against other chosen cards
            NSMutableArray *otherCards = [NSMutableArray arrayWithCapacity:self.gameModel];
            
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMacthed)
                {
                    [otherCards addObject:otherCard];
                }
            }
            
            //不能放于for循环之前，否则会将本次被选择的牌加入cards，不能放于下面的if之后，否则当if成立时返回，没有将本次翻牌的cost记录，且不能翻牌
            self.score -= COST_TO_CHOOSE * self.gameModel;
            card.chosen = YES;
            
            if ([otherCards count] < self.gameModel - 1)
            {
                self.gameState = [NSString stringWithFormat:@"State:%@",card.contents];
                return;
            }
            else
            {
                int matchScore = [card match:otherCards];
                
                if (matchScore)
                {
                    NSMutableString *state = [NSMutableString stringWithFormat:@"State:%@ matched",card.contents];
                    self.score += matchScore * MATCH_BOUNDS * self.gameModel;
                    for (Card *otherCard in otherCards)
                    {
                        [state appendFormat:@" %@",otherCard.contents];
                        otherCard.matched = YES;
                    }
                    [state appendFormat:@". Get %d score!",matchScore * MATCH_BOUNDS * self.gameModel];
                    card.matched = YES;
                    
                    self.gameState = state;
                }
                else
                {
                    NSMutableString *state = [NSMutableString stringWithFormat:@"State:%@ with",card.contents];
                    self.score -= MISMATCH_PENALTY * self.gameModel;
                    for (Card *otherCard in otherCards)
                    {
                        [state appendFormat:@" %@",otherCard.contents];
                        otherCard.chosen = NO;
                    }
                    [state appendFormat:@" not matched! %d point penalty!",MISMATCH_PENALTY * self.gameModel];
                    
                    self.gameState = state;
                }
            }
        }
    }
}

@end
