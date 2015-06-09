//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Meng on 15/6/9.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLable;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLable;

@end

@implementation TextStatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSStrokeWidthAttributeName:@-3}];//for test
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window)
    {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    NSUInteger index = 0;
    while (index < [self.textToAnalyze length])
    {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value)
        {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }
        else
        {
            index++;
        }
    }
    
    return characters;
}

- (void)updateUI
{
    self.colorfulCharactersLable.text = [NSString stringWithFormat:@"%lu colorful characters",[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLable.text = [NSString stringWithFormat:@"%lu outlined characters",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

@end
