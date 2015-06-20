//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Meng on 15/5/22.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BOUNDS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;

- (NSString *)validOfOtherCards:(NSArray *)otherCards;

@property (nonatomic,readonly) NSString *validOfOtherCards;
@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSUInteger gameModel;// >=2
@property (nonatomic,strong) NSMutableArray *gameStateHistory;

@end
