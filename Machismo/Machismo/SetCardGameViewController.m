//
//  SetCardGameViewController.m
//  Machismo
//
//  Created by Meng on 15/6/12.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController()

@property (weak, nonatomic) IBOutlet UILabel *gameStateLable;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (nonatomic) NSUInteger selfDefiningModel;

@end

@implementation SetCardGameViewController

#define CORNER_FONT_STANDARD_HIGHT 180.0
#define CORNER_RADIUS 12.0

//让界面变得更好看的魔法
- (CGFloat)cornerScaleFactor:(CGFloat)height {return height / CORNER_FONT_STANDARD_HIGHT;}
- (CGFloat)cornerRadius:(CGFloat)height {return CORNER_RADIUS * [self cornerScaleFactor:height];}

- (void)viewDidLoad
{
    //又是个让界面变得更好看的魔法
    self.restartButton.layer.cornerRadius = [self cornerRadius:self.restartButton.bounds.size.height];
    
    _selfDefiningModel = 3;//default model
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}
- (IBAction)touchCardButtons:(UIButton *)sender
{
    //游戏开始后禁用模式选择功能
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    if(!self.game)
    {
        ZMLog(@"create game");
        self.game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                             usingDeck:[self createDeck]];
        ZMLog(@"%@",self.game ? @"1" : @"2");
        self.game.gameModel = self.selfDefiningModel;
    }
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchRestartButton:(UIButton *)sender
{
    //恢复默认值
    self.selfDefiningModel = 2;    
    self.game = nil;
    [self updateUIWithNotCreateGame];
}

- (void) updateUIWithNotCreateGame
{
    for (UIButton *cardButton in self.cardButtons)
    {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.gameStateLable.text = @"State";
    self.scoreLable.text = @"Score:0";
}

- (void)updateUI
{
    [super updateUI];
    self.gameStateLable.text = ((SetCardMatchingGame *)self.game).gameState;
}

@end
