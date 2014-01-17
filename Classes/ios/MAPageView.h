//
//  MAPageView.h
//  DemoScrolling
//
//  Created by Alekseenko Oleg on 17.01.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAPageView : UIView

- (void)addView:(UIView *)view withAnimatioForKeyPath:(NSString *)keyPath evaluateAnimation:(void (^)(CABasicAnimation *animation))animationBlock;

- (void)updateAnimationPercentage:(float)percentage;

@end
