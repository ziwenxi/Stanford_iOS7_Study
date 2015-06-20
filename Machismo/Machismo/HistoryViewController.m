//
//  HistoryViewController.m
//  Machismo
//
//  Created by Meng on 15/6/20.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *HistoryTextView;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    for (NSString *state in self.history)
    {
        self.HistoryTextView.text = [self.HistoryTextView.text stringByAppendingFormat:@"%@\n",state];
    }
}
@end
