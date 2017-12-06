//
//  ViewController.m
//  AnimationTest
//
//  Created by Вероника on 21.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *someView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.someView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.someView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.someView];
    [UIView animateWithDuration:3 animations:^{
        self.someView.frame = CGRectMake(200, 40, 50, 300);
        self.someView.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:5.0 animations:^{ self.someView.center = CGPointMake(200, 60);}];
    }];
    
    [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{self.someView.frame = CGRectMake(100, 40, 50, 30);} completion:^(BOOL finished){}];
    
    //self.someRandomTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(performeAnimation) userInfo:nil repeats:YES];
    //[self.someRandomTimer fire];
    //[self performBasicAnimation];
    //[self performAnimationSequence];
    
}

-(void) performBasicAnimation{
    CABasicAnimation *theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    theAnimation.duration = 3.0;
    theAnimation.repeatCount = 2;
    theAnimation.autoreverses = YES;
    theAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.view.frame)/2, self.someView.frame.origin.y)];
    theAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    [self.someView.layer addAnimation:theAnimation forKey:@"animationPosition"];
}

-(void)perforKeyframeAnimation{
    NSArray *pathArray = @[[NSValue valueWithCGPoint:CGPointMake(10., 50.)], [NSValue valueWithCGPoint:CGPointMake(100., 50.)], [NSValue valueWithCGPoint:CGPointMake(10., 50.)]];
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.values = pathArray;
    pathAnimation.duration = 5.0;
    pathAnimation.autoreverses = YES;
    [self.someView.layer addAnimation:pathAnimation forKey:@"position"];
}


-(void)performAnimationSequence
{
    CABasicAnimation *positionAnimation;
    positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration= 3.0;
    positionAnimation.autoreverses = YES;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.view.frame)/2, self.someView.frame.origin.y)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    
    CABasicAnimation *heightAnimation;
    heightAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    [heightAnimation setFromValue:[NSValue valueWithCGSize:CGSizeMake(self.someView.frame.size.width, self.someView.frame.size.height)]];
    [heightAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(self.someView.frame.size.width, 200)]];
    heightAnimation.duration = 3.0;
    heightAnimation.beginTime = 2.0;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.autoreverses =YES;
    [opacityAnimation setFromValue:[NSNumber numberWithInt:1]];
    [opacityAnimation setToValue:[NSNumber numberWithInt:0]];
    opacityAnimation.duration = 5;
    opacityAnimation.beginTime = 2;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = 2;
    [group setDuration:10.0];
    [group setAnimations:@[positionAnimation, heightAnimation, opacityAnimation]];
    [self.someView.layer addAnimation:group forKey:nil];
}
-(void)performeAnimation
{
    self.someView.frame = CGRectMake(self.someView.frame.origin.x, self.someView.frame.origin.y + 1.0f, self.someView.frame.size.width, self.someView.frame.size.width);
}

-(void)stopTimer{
    [self.someRandomTimer invalidate];
    self.someRandomTimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
