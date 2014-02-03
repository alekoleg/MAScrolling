//
//  MAPageView.h
//  DemoScrolling
//
//  Created by Alekseenko Oleg on 17.01.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AnimationBlock) (float percentage);
@interface MAPageView : UIView

- (void)updateAnimationPercentage:(float)percentage;

- (void)viewNotVisible;

- (void)addView:(UIView *)view withAnimationBlock:(AnimationBlock )animation;
@end
