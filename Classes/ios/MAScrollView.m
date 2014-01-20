//
//  MAScrollView.m
//  DemoScrolling
//
//  Created by Alekseenko Oleg on 17.01.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "MAScrollView.h"
#import "MAPageView.h"
@implementation MAScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentOffset"];
}
//============================================================================================
#pragma mark - Setup -
//--------------------------------------------------------------------------------------------
- (void)setup {
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
}


//============================================================================================
#pragma mark - KVO -
//--------------------------------------------------------------------------------------------

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self updateSubViewsStatus];
    }
}

//============================================================================================
#pragma mark - Actions -
//--------------------------------------------------------------------------------------------

- (void)updateSubViewsStatus {
    NSLog(@"x - %f, y - %f", self.contentOffset.x, self.contentOffset.y);
    [self.subviews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(MAPageView * obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MAPageView class]]) {
            if (obj.frame.origin.x <= self.contentOffset.x && obj.frame.origin.x + obj.frame.size.width >= self.contentOffset.x){
                float persentage = (self.contentOffset.x - obj.frame.origin.x) / obj.frame.size.width;
                [obj updateAnimationPercentage:persentage];
            } else {
                [obj viewNotVisible];
            }
        }
    }];
}


@end
