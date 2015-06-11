//
//  ViewController.h
//  Machismo
//
//  Created by Meng on 15/5/17.
//  Copyright (c) 2015年 Meng. All rights reserved.
//
// Abstract class.  Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@class CardMatchingGame;

@interface ViewController : UIViewController

//protected
//for subclasses
- (Deck *)createDeck;  // abstract

@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

- (NSUInteger)cardButtonsNumber;
- (void) updateUI;
- (NSString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@end