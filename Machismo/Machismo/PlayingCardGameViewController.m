//
//  PlayingCardGameViewController.m
//  Machismo
//
//  Created by Meng on 15/6/6.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
