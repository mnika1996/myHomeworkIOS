//
//  MVMProgressView.m
//  URLsession
//
//  Created by Вероника on 30.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "MVMProgressView.h"

@interface MVMProgressView()

@property(nonatomic, strong) UILabel *progressLabel;
@property(nonatomic, strong) UIView *progressView;
@property(nonatomic, strong) UIView *ball;

@property(nonatomic, assign) BOOL isAnimationRuning;

@property(nonatomic, strong) NSTimer *ballTimer;

@property NSInteger deltaY;

@end

@implementation MVMProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _progress = 0;
        _deltaY = -1;
        _isAnimationRuning = YES;
        
        _ball = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetHeight(self.frame) - 10, 10, 10)];
        _ball.backgroundColor = [UIColor redColor];
        _ball.layer.masksToBounds = YES;
        _ball.layer.cornerRadius = 5.0;
        [self addSubview:_ball];
        
        _progressLabel = [UILabel new];
        _progressLabel.frame = CGRectMake(0, 30, 100, 30);
        
        [self addSubview:_progressLabel];
        
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(10, 30 + CGRectGetHeight(_progressLabel.frame), (CGRectGetWidth(self.frame) - 20)*_progress, 1)];
        _progressView.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:_progressView];
        
        _ballTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(performeAnimation) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)startAnimation
{
    if(self.isAnimationRuning)
    {
        [self.ballTimer fire];
    }
    else
    {
        self.isAnimationRuning = YES;
    }
}

-(void)stopAnimation
{
    self.isAnimationRuning =  NO;
}

-(void)performeAnimation
{
    if (self.ball.center.y == CGRectGetHeight(self.frame) - 5)
    {
        self.deltaY = -1;
    }
    else if (self.ball.center.y == 400)
    {
        self.deltaY = 1;
    }
    if(self.isAnimationRuning) self.ball.center = CGPointMake(self.ball.center.x, self.ball.center.y + self.deltaY);
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    self.progressLabel.text = [NSString stringWithFormat:@"%f%%", progress * 100];
    self.progressView.frame = CGRectMake(CGRectGetMinX(self.progressView.frame), CGRectGetMinY(self.progressView.frame), (CGRectGetWidth(self.frame) - 20)*progress, 1);
    if(progress>=100)
    {
        [self.ballTimer invalidate];
        self.ballTimer = nil;
        [self.progressLabel removeFromSuperview];
        [self.progressView removeFromSuperview];
    }
}

@end
