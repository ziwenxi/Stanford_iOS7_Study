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

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSUInteger gameModel;// >=2
@property (nonatomic,readonly) NSString *gameState;

@end
