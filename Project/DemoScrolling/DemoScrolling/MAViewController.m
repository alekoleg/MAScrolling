//
//  MAViewController.m
//  DemoScrolling
//
//  Created by Alekseenko Oleg on 17.01.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "MAViewController.h"
#import "MAScrollView.h"
#import "MAPageView.h"
@interface MAViewController ()

@property (nonatomic, weak) IBOutlet MAScrollView *scrollView;

@end

@implementation MAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupScrollView];
    [self setupTest];
}

//============================================================================================
#pragma mark - Setup -
//--------------------------------------------------------------------------------------------
- (void)setupScrollView {
    _scrollView.contentSize = CGSizeMake(4048, 0);
}

- (void)setupTest {
    MAPageView *pageview = [[MAPageView alloc]initWithFrame:CGRectMake(1024, 0, 500, 1024)];
    pageview.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:pageview];
    
    UIView *view = [[UIView alloc]initWithFrame: CGRectMake(20, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    NSValue *from = [NSValue valueWithCGPoint:CGPointMake(20, 100)];
    NSValue *to = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    [pageview addView:view withAnimatioForKeyPath:@"position" evaluateAnimation:^(CABasicAnimation *animation) {
        animation.toValue = to;
        animation.fromValue = from;
        animation.duration = 0.17;
    }];
    
}

@end
