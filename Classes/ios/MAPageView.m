
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
@property (nonatomic, strong) NSMapTable *groupAnimationMap;
@property (nonatomic, strong) NSMutableArray *tmpAnimtaions;
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setup {
    _percentage = 0.0;
    _animtaionsMap = [NSMapTable strongToStrongObjectsMapTable];
    _animationsViews = [NSMutableArray array];
    _tmpAnimtaions = [NSMutableArray array];
    _groupAnimationMap = [NSMapTable strongToStrongObjectsMapTable];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willEnterForeground:) name:@"THViewControllerViewWillAppear" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)willEnterForeground:(NSNotification *)not {
    
    for (UIView *view in _groupAnimationMap) {
        CAAnimation *anim = [_groupAnimationMap objectForKey:view];
        [view.layer removeAllAnimations];
        view.layer.anchorPoint = CGPointMake(0, 0);
        view.layer.speed = 0.0;
        view.layer.timeOffset = 0.01;
        [view.layer addAnimation:anim forKey:@"animation"];
        view.layer.timeOffset = 0.02;
        view.layer.timeOffset = _percentage;
    }
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
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    [group setValue:view forKey:@"animationView"];
    [_groupAnimationMap setObject:group forKey:view];
    [view.layer addAnimation:group forKey:@"animation"];
    [_animationsViews addObject:view];
    [_animtaionsMap setObject:timeOffsetBlock forKey:view];
}

- (void)addAnimationsToView:(UIView *)view forKeyPath:(NSString *)keyPath evaluateAnimation:(AnimationBlock)animationBlock {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animationBlock(animation);
    CAAnimationGroup *group = [_groupAnimationMap objectForKey:view];
    NSMutableArray *animations = [[group animations]mutableCopy];
    [animations addObject:animation];
    group.animations = [animations copy];
    [view.layer removeAllAnimations];
    [view.layer addAnimation:group forKey:@"animation"];
}

- (void)viewNotVisible {
    if (_percentage != 0) {
        [self updateAnimationPercentage:0];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //    CAAnimationGroup *group = [CAAnimationGroup animation];
    //    group.animations = [(CAAnimationGroup *)anim animations];
    //    group.duration = anim.duration;
    //    group.delegate = self;
    //    group.fillMode = kCAFillModeForwards;
    ////    NSLog(@"%i save animtaions", group.animations.count);
    //    UIView *view = [anim valueForKey:@"animationView"];
    //    [group setValue:view forKey:@"animationView"];
    //    [_tmpAnimtaions addObject:group];
    //
    //    CAAnimation *an = [_groupAnimationMap objectForKey:view];
    //    [view.layer addAnimation:an forKey:@"animation"];
}

//============================================================================================
#pragma mark - Actions -
//--------------------------------------------------------------------------------------------
- (void)updateAnimationPercentage:(float)percentage {
    if (percentage > 1.0) {
        percentage = 1.0;
    } else if (percentage < 0.0) {
        percentage = 0.0;
    }
    if (_percentage != percentage) {
        _percentage = percentage;
        for (UIView *obj in _animationsViews) {
            if ([[obj.layer animationKeys]count] == 0 && [_groupAnimationMap objectForKey:obj]) {
                [obj.layer removeAllAnimations];
                CAAnimation *animation = [_groupAnimationMap objectForKey:obj];
                [obj.layer addAnimation:animation forKey:@"animation"];
            }
            
            TimeOffsetBlock block = [_animtaionsMap objectForKey:obj];
            obj.layer.timeOffset = (block) ? (block(_percentage)) : _percentage;
        }
    }
}

- (void)layoutSubviews {
    
}
@end
