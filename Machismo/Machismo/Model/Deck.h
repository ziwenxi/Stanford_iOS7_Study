//
//  Deck.h
//  Machismo
//
//  Created by Meng on 15/5/18.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;
- (Card *)drawRandomCard;
@end
