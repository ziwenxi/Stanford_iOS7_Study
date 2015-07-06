//
//  BezierPathView.m
//  Dropit
//
//  Created by Meng on 15/7/7.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView


- (void)setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_path stroke];
}

@end
