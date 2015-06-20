//
//  PlayingCardGameViewController.m
//  Machismo
//
//  Created by Meng on 15/6/11.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"
#import "HistoryViewController.h"

@interface PlayingCardGameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModelSelectSegmented;
@property (weak, nonatomic) IBOutlet UILabel *gameModelLable;
@property (weak, nonatomic) IBOutlet UITextField *matchModelTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *gameStateLable;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (nonatomic) NSUInteger selfDefiningModel;

@end

@implementation PlayingCardGameViewController

#define CORNER_FONT_STANDARD_HIGHT 180.0
#define CORNER_RADIUS 12.0

//让界面变得更好看的魔法
- (CGFloat)cornerScaleFactor:(CGFloat)height {return height / CORNER_FONT_STANDARD_HIGHT;}
- (CGFloat)cornerRadius:(CGFloat)height {return CORNER_RADIUS * [self cornerScaleFactor:height];}

- (void)viewDidLoad
{
    //又是个让界面变得更好看的魔法
    self.restartButton.layer.cornerRadius = [self cornerRadius:self.restartButton.bounds.size.height];
    self.gameModelSelectSegmented.layer.cornerRadius = [self cornerRadius:self.gameModelSelectSegmented.bounds.size.height * 3];
    
    [self.gameModelSelectSegmented addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];//target-action
    
    _selfDefiningModel = 2;//default model
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show PlayingCardGameHistory"])
    {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController *HVC = (HistoryViewController *)segue.destinationViewController;
            HVC.history = self.game.gameStateHistory;
        }
    }
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
    self.gameModelLable.text = [NSString stringWithFormat:@"game model:%lu",(unsigned long)self.selfDefiningModel];
}

- (void) assertSelfDefiningModel:(NSString *)text
{
    if ([self.matchModelTextFiled.text integerValue] < 2)
    {
        [[[UIAlertView alloc] initWithTitle:@"Wrong" message:@"game model at least 2" delegate:nil cancelButtonTitle:@"certain" otherButtonTitles:nil, nil] show];
        self.matchModelTextFiled.text = @"";
        self.gameModelSelectSegmented.selectedSegmentIndex = 0;
    }
    else if ([self.matchModelTextFiled.text integerValue] > [self cardButtonsNumber])
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

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
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

- (IBAction)touchCardButton:(UIButton *)sender
{
    //游戏开始后禁用模式选择功能
    self.gameModelSelectSegmented.enabled = NO;
    self.matchModelTextFiled.enabled = NO;
    self.matchModelTextFiled.enabled = NO;
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    if(!self.game)
    {
        self.game = [[PlayingCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                             usingDeck:[self createDeck]];
        self.game.gameModel = self.selfDefiningModel;
    }
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
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
    self.gameStateLable.text = ((PlayingCardMatchingGame *)self.game).gameState;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
