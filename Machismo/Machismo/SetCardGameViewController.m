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
#import "SetCard.h"
#import "HistoryViewController.h"

@interface SetCardGameViewController()

@property (weak, nonatomic) IBOutlet UILabel *gameStateLable;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (nonatomic) NSUInteger selfDefiningModel;
@property (nonatomic,strong) NSDictionary *colorOfCard;

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
    
    self.colorOfCard = @{@"red" : [UIColor redColor], @"green" : [UIColor greenColor], @"purple" : [UIColor purpleColor]};
    
    _selfDefiningModel = 3;//default model
    
    if(!self.game)
    {
        self.game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
        self.game.gameModel = self.selfDefiningModel;
    }
    [self updateUIWithNotCreateGame];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show SetCardGameHistory"])
    {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController *HVC = (HistoryViewController *)segue.destinationViewController;
            HVC.history = self.game.gameStateHistory;
        }
    }
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
        self.game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                             usingDeck:[self createDeck]];
        self.game.gameModel = self.selfDefiningModel;
    }
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchRestartButton:(UIButton *)sender
{
    //恢复默认值
    self.selfDefiningModel = 3;
    self.game = nil;
    if(!self.game)
    {
        self.game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
        self.game.gameModel = self.selfDefiningModel;
    }
    [self updateUIWithNotCreateGame];
}

- (void) updateUIWithNotCreateGame
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self attributeTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.gameStateLable.text = @"State";
    self.scoreLable.text = @"Score:0";
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self attributeTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMacthed;
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Score:%ld",(long)self.game.score];
    self.gameStateLable.text = ((SetCardMatchingGame *)self.game).gameState;
}

- (NSAttributedString *)attributeTitleForCard:(Card *)card
{
    NSShadow *shadow1 = [[NSShadow alloc] init];
    shadow1.shadowColor = [UIColor grayColor];
    shadow1.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    NSShadow *shadow2 = [[NSShadow alloc] init];
    shadow2.shadowColor = [UIColor whiteColor];
    shadow2.shadowOffset = CGSizeMake(0.0F,0.0f);
    return [[NSAttributedString alloc] initWithString:((SetCard *)card).suit
                                           attributes:@{NSForegroundColorAttributeName : [self.colorOfCard valueForKey:((SetCard *)card).color],
                                                                 NSShadowAttributeName : ((SetCard *)card).shading ? shadow1 : shadow2,
                                                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0f]}];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return card.chosen ? [UIImage imageNamed:@"setCardback"] : [UIImage imageNamed:@"cardFront"];
}

@end
