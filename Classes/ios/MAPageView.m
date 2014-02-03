
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
@property (nonatomic, strong) NSMutableArray *blockAnimationArray;
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
    _blockAnimationArray = [NSMutableArray array];
}

- (void)addView:(UIView *)view withAnimationBlock:(void (^)(float))animation {
    [self addSubview:view];
    
    AnimationBlock animationStrong = [animation copy];
    [_blockAnimationArray addObject:animationStrong];
    animation(_percentage);
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
    } else if (percentage < 0.0) {
        percentage = 0.0;
    }
    if (_percentage != percentage) {
        _percentage = percentage;
        for (AnimationBlock animation in _blockAnimationArray) {
            animation(_percentage);
        }
    }
}

@end
