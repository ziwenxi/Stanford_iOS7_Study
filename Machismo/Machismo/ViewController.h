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

@interface ViewController : UIViewController

//protected
//for subclasses
- (Deck *)createDeck;  // abstract

@end