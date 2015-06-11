//
//  SetCardDeck.m
//  Machismo
//
//  Created by Meng on 15/6/10.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        for (NSString *suit in [SetCard validSuits])
        {
            for (NSString *color in [SetCard validColors])
            {
                    for (NSUInteger i = 0; i < [SetCard shadingNumber]; i++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.suit = suit;
                        card.color = color;
                        card.shading = (i<1) ? true : false;
                        
                        [self addCard:card];
                    }
            }
        }
    }
    return self;
}

@end
