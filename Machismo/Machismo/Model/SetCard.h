//
//  SetCard.h
//  Machismo
//
//  Created by Meng on 15/6/10.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong,nonatomic) NSString *suit;//  ▲ ● ■
@property (strong,nonatomic) NSString *color;// red green purple
@property (nonatomic) BOOL shading;

+ (NSArray *)validSuits;
+ (NSArray *)validColors;
+ (NSUInteger)shadingNumber;


@end
