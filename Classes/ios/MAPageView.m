//
//  MAPageView.m
//  DemoScrolling
//
//  Created by Alekseenko Oleg on 17.01.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "MAPageView.h"
@import QuartzCore;

@interface MAPageView ()
@property (nonatomic) float percentage;
@property (nonatomic, strong) NSMapTable *animtaionsMap;
@property (nonatomic, strong) NSMutableArray *animationsViews;
@end

@implementation MAPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

//============================================================================================
#pragma mark - Setup -
//--------------------------------------------------------------------------------------------

- (void)setup {
    _percentage = 0.0;
    _animtaionsMap = [NSMapTable strongToStrongObjectsMapTable];
    _animationsViews = [NSMutableArray array];
}

- (void)addView:(UIView *)view withAnimatioForKeyPath:(NSString *)keyPath evaluateAnimation:(AnimationBlock)animationBlock timeOffsetBlock:(TimeOffsetBlock)timeOffsetBlock {
    NSAssert(view, @"nil view");
    [self addSubview:view];
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.layer.speed = 0.0;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animationBlock(animation);
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation];
    group.duration = animation.duration;
    [view.layer addAnimation:group forKey:@"animation"];
    [_animationsViews addObject:view];
    [_animtaionsMap setObject:timeOffsetBlock forKey:view];
}

- (void)addAnimationsToView:(UIView *)view forKeyPath:(NSString *)keyPath evaluateAnimation:(AnimationBlock)animationBlock {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animationBlock(animation);
    CAAnimationGroup *group = (CAAnimationGroup *)[view.layer animationForKey:@"animation"];
    NSMutableArray *animations = [[group animations]mutableCopy];
    [animations addObject:animation];
    CAAnimationGroup *newGroup = [CAAnimationGroup animation];
    newGroup.animations = [animations copy];
    CAAnimation *firstAnimation = [animations firstObject];
    newGroup.duration = firstAnimation.duration;
    [view.layer removeAllAnimations];
    [view.layer addAnimation:newGroup forKey:@"animation"];
    
}

- (void)viewNotVisible {
    if (_percentage != 0) {
        [self updateAnimationPercentage:0];
    }
}

//============================================================================================
#pragma mark - Actions -
//--------------------------------------------------------------------------------------------
- (void)updateAnimationPercentage:(float)percentage {
    if (percentage > 1.0) {
        percentage = 1.0;
    } else if (percentage <= 0.0) {
        percentage = 0.0;
    }
    if (_percentage != percentage) {
        _percentage = percentage;
        [_animationsViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            TimeOffsetBlock block = [_animtaionsMap objectForKey:obj];
            obj.layer.timeOffset = (block) ? (block(_percentage)) : _percentage;
        }];
    }
}


@end
