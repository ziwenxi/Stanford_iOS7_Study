//
//  ViewController.m
//  Machismo
//
//  Created by Meng on 15/5/17.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModelSelectSegmented;
@property (weak, nonatomic) IBOutlet UILabel *gameModelLable;
@property (weak, nonatomic) IBOutlet UITextField *matchModelTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *gameStateLable;
@property (nonatomic) NSUInteger selfDefiningModel;
@end

#define CORNER_FONT_STANDARD_HIGHT 180.0
#define CORNER_RADIUS 12.0

@implementation ViewController

//让界面变得更好看的魔法
- (CGFloat)cornerScaleFactor:(CGFloat)height {return height / CORNER_FONT_STANDARD_HIGHT;}
- (CGFloat)cornerRadius:(CGFloat)height {return CORNER_RADIUS * [self cornerScaleFactor:height];}

- (void) viewDidLoad
{
    //又是个让界面变得更好看的魔法
    self.restartButton.layer.cornerRadius = [self cornerRadius:self.restartButton.bounds.size.height];
    self.gameModelSelectSegmented.layer.cornerRadius = [self cornerRadius:self.gameModelSelectSegmented.bounds.size.height * 3];
    
    [self.gameModelSelectSegmented addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];//target-action
    
    _selfDefiningModel = 2;//default model
}

- (void) segmentAction:(UISegmentedControl *)Seg
{
    if  (self.gameModelSelectSegmented.selectedSegmentIndex == 2)
    {
        [self assertSelfDefiningModel:self.matchModelTextFiled.text];
    }
    else
    {
        self.selfDefiningModel = self.gameModelSelectSegmented.selectedSegmentIndex + 2;
    }
    self.gameModelLable.text = [NSString stringWithFormat:@"game model:%d",self.selfDefiningModel];
}

- (void) assertSelfDefiningModel:(NSString *)text
{
    if ([self.matchModelTextFiled.text integerValue] < 2)
    {
        [[[UIAlertView alloc] initWithTitle:@"Wrong" message:@"game model at least 2" delegate:nil cancelButtonTitle:@"certain" otherButtonTitles:nil, nil] show];
        self.matchModelTextFiled.text = @"";
        self.gameModelSelectSegmented.selectedSegmentIndex = 0;
    }
    else if ([self.matchModelTextFiled.text integerValue] > 30)
    {
        [[[UIAlertView alloc] initWithTitle:@"Wrong" message:@"beyond card max number" delegate:nil cancelButtonTitle:@"certain" otherButtonTitles:nil, nil] show];
        self.matchModelTextFiled.text = @"";
        self.gameModelSelectSegmented.selectedSegmentIndex = 0;
    }
    else
    {
        self.selfDefiningModel = [self.matchModelTextFiled.text integerValue];
    }
}

- (CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.gameModel = self.selfDefiningModel;
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    //游戏开始后禁用模式选择功能
    self.gameModelSelectSegmented.enabled = NO;
    self.matchModelTextFiled.enabled = NO;
    self.matchModelTextFiled.enabled = NO;
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchRestartButton
{
    //恢复默认值
    self.gameModelSelectSegmented.enabled = YES;
    self.matchModelTextFiled.enabled = YES;
    self.matchModelTextFiled.enabled = YES;
    self.gameModelSelectSegmented.selectedSegmentIndex = 0;
    self.selfDefiningModel = 2;
    self.gameModelLable.text = [NSString stringWithFormat:@"game model:%d",_selfDefiningModel];
    self.matchModelTextFiled.text = nil;
    
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

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMacthed;
    }
    self.gameStateLable.text = _game.gameState;
    self.scoreLable.text = [NSString stringWithFormat:@"Score:%ld",(long)self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

#pragma mark - UITextFiledDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
