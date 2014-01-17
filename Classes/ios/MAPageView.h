//
//  MAPageView.h
//  DemoScrolling
//
//  Created by Alekseenko Oleg on 17.01.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CFTimeInterval (^TimeOffsetBlock) (float percentage);
typedef void (^AnimationBlock) (CABasicAnimation *animation);
@interface MAPageView : UIView

- (void)addView:(UIView *)view withAnimatioForKeyPath:(NSString *)keyPath evaluateAnimation:(AnimationBlock)animationBlock timeOffsetBlock:(TimeOffsetBlock)timeOffsetBlock;

- (void)updateAnimationPercentage:(float)percentage;

@end
