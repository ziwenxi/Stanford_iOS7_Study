//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Meng on 15/6/28.
//  Copyright (c) 2015年 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic,strong) NSString *suit;
@property (nonatomic) BOOL faceUp;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
