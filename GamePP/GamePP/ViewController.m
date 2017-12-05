//
//  ViewController.m
//  GamePP
//
//  Created by Вероника on 21.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "ViewController.h"
#include "stdlib.h"

#define abs(x) (x<0? -x : x)

@interface ViewController ()
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *rival;
@property (nonatomic, strong) UIView *platforma;

@property (nonatomic, strong) UIView *touchView;

@property (nonatomic,strong) UILabel *resultLabel;

@property (nonatomic,strong) UILabel *scoreLabel;
@property NSInteger scoreRival;
@property NSInteger scorePlatform;

@property(nonatomic,strong) UIButton *restartButton;

@property(nonatomic, strong) NSTimer *someBallTimer;
@property(nonatomic, strong) NSTimer *someRivalTimer;

@property NSInteger deltaX;
@property NSInteger deltaY;

@property NSInteger deltaRivalX;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.scoreRival = 0;
    self.scorePlatform = 0;
    
    self.deltaX = 1;
    self.deltaY = (rand() % 3 - 1);
    
    if(self.deltaY == 0)
    {
        self.deltaY = 1;
    }
    
    self.deltaRivalX = 1;
    
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, self.view.center.y, CGRectGetWidth(self.touchView.frame) - 30.0, 20.)];
    self.resultLabel.textColor = [UIColor colorWithRed:227.0f/255.0f green:207.0f/255.0f blue:226.0f/255.0f alpha:1.0f];
    
    self.restartButton = [[UIButton alloc] initWithFrame:CGRectMake(200., 20., 150., 20.)];
    self.restartButton.backgroundColor = [UIColor grayColor];
    [self.restartButton setTitle:@"Restart game" forState:UIControlStateNormal];
    [self.restartButton setTintColor:[UIColor darkTextColor]];
    self.restartButton.layer.cornerRadius = 5.0f;
    self.restartButton.layer.masksToBounds = YES;
    [self.restartButton addTarget:self action:@selector(restartGame)forControlEvents:UIControlEventTouchDown];
    
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10., 20., 150., 20.)];
    self.scoreLabel.text = [[[@"Score " stringByAppendingString: [[NSNumber numberWithInteger:self.scoreRival] stringValue]] stringByAppendingString: @" : "] stringByAppendingString: [[NSNumber numberWithInteger:self.scorePlatform] stringValue]];
    
    self.touchView = [[UIView alloc] initWithFrame:CGRectMake(0., 41., CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 41.)];
    self.touchView.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:207.0f/255.0f blue:226.0f/255.0f alpha:1.0f];
    
    self.platforma = [[UIView alloc] initWithFrame:CGRectMake(50., CGRectGetHeight(self.view.frame) - 60., 100., 10.)];
    self.platforma.backgroundColor = [UIColor magentaColor];
    
    self.rival = [[UIView alloc] initWithFrame:CGRectMake(50., 80., 100., 10.)];
    self.rival.backgroundColor = [UIColor blueColor];
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(rand() % 300, 100 + rand() % 500, 10., 10.)];
    self.ball.backgroundColor = [UIColor redColor];
    self.ball.layer.cornerRadius = 5.0f;
    self.ball.layer.masksToBounds = YES;
    
    [self.view addSubview:self.touchView];
    [self.view addSubview:self.ball];
    [self.view addSubview:self.rival];
    [self.view addSubview:self.platforma];
    [self.view addSubview:self.restartButton];
    [self.view addSubview:self.scoreLabel];
    [self.view addSubview:self.resultLabel];
    
    
    self.someBallTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(performeAnimation) userInfo:nil repeats:YES];
    [self.someBallTimer fire];
    
    self.someRivalTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(performeRivalAnimation) userInfo:nil repeats:YES];
    [self.someRivalTimer fire];
    
    
}

-(void)gameOver
{
    [self.someBallTimer invalidate];
    [self.someRivalTimer invalidate];
    self.someBallTimer = nil;
    self.someRivalTimer = nil;
    
    self.resultLabel.frame = CGRectMake(15.0, self.view.center.y, CGRectGetWidth(self.touchView.frame) - 30.0, 20.);
    
    if (self.scoreRival > self.scorePlatform)
    {
        self.resultLabel.text = @"Вы проиграли!";
    }
    else if (self.scoreRival < self.scorePlatform)
    {
        self.resultLabel.text = @"Вы выиграли!";
    }
    else
    {
        self.resultLabel.text = @"Ничья!";
    }
    
    self.resultLabel.textColor = [UIColor blackColor];
}

-(void)restartGame
{

    self.resultLabel.textColor = [UIColor colorWithRed:227.0f/255.0f green:207.0f/255.0f blue:226.0f/255.0f alpha:1.0f];
    
    self.scoreRival = 0;
    self.scorePlatform = 0;
    
    self.deltaX = 1;
    self.deltaY = (rand() % 3 - 1);
    
    if(self.deltaY == 0)
    {
        self.deltaY = 1;
    }
    
    self.deltaRivalX = 1;
    
    self.scoreLabel.text = [[[@"Score " stringByAppendingString: [[NSNumber numberWithInteger:self.scoreRival] stringValue]] stringByAppendingString: @" : "] stringByAppendingString: [[NSNumber numberWithInteger:self.scorePlatform] stringValue]];
    
    self.platforma.frame = CGRectMake(50., CGRectGetHeight(self.view.frame) - 60., 100., 10.);
    
    self.rival.frame = CGRectMake(50., 80., 100., 10.);
    
    self.ball.frame = CGRectMake(rand() % 300, 100 + rand() % 500, 10., 10.);
    
    self.someBallTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(performeAnimation) userInfo:nil repeats:YES];
    [self.someBallTimer fire];
    
    self.someRivalTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(performeRivalAnimation) userInfo:nil repeats:YES];
    [self.someRivalTimer fire];
}

-(void)performeRivalAnimation
{
    [self changeDeltaRivalX];
    
    if (CGRectGetMaxX(self.rival.frame) == CGRectGetMaxX(self.view.frame))
    {
       if (self.deltaRivalX <= 0)
       {
           self.rival.center = CGPointMake(self.rival.center.x + self.deltaRivalX, self.rival.center.y);
       }
    }
    else if (CGRectGetMinX(self.rival.frame) == CGRectGetMinX(self.view.frame))
    {
        if (self.deltaRivalX >= 0)
        {
            self.rival.center = CGPointMake(self.rival.center.x + self.deltaRivalX, self.rival.center.y);
        }
    }
    else
    {
         self.rival.center = CGPointMake(self.rival.center.x + self.deltaRivalX, self.rival.center.y);
    }
}

-(void)changeDeltaRivalX
{
        if (self.deltaY > 0)
        {
            self.deltaRivalX = 0;
        }
        else if (self.ball.center.x > self.rival.center.x)
        {
            if (self.deltaX < 0)
            {
                self.deltaRivalX = - self.deltaX;
            }
            else
            {
                self.deltaRivalX = 2 * self.deltaX;
            }
        }
        else if (self.ball.center.x < self.rival.center.x)
        {
            if (self.deltaX < 0)
            {
                self.deltaRivalX = 2 * self.deltaX;;
            }
            else
            {
                self.deltaRivalX = -self.deltaX;
            }
        }
        else
        {
            self.deltaRivalX = self.deltaX;
        }

}

-(void)performeAnimation
{
    self.ball.center = CGPointMake(self.ball.center.x + self.deltaX, self.ball.center.y + self.deltaY);
    
    if (![self checkBoundsX])
    {
        self.deltaX = (-1) * self.deltaX;
    }
    
    if (![self checkBoundsY])
    {
        [self gameOver];
        return;
    }
    
    if (![self checkRival] )
    {
        self.scoreRival = self.scoreRival + 1;
        self.scoreLabel.text = [[[@"Score " stringByAppendingString: [[NSNumber numberWithInteger:self.scoreRival] stringValue]] stringByAppendingString: @" : "] stringByAppendingString: [[NSNumber numberWithInteger:self.scorePlatform] stringValue]];
        [self changeDeltaY];
    }
    
    if(![self checkPlatforma])
    {
        self.scorePlatform = self.scorePlatform + 1;
        self.scoreLabel.text = [[[@"Score " stringByAppendingString: [[NSNumber numberWithInteger:self.scoreRival] stringValue]] stringByAppendingString: @" : "] stringByAppendingString: [[NSNumber numberWithInteger:self.scorePlatform] stringValue]];
        [self changeDeltaY];
    }
}


-(void) changeDeltaY
{
    if (self.deltaY < 0)
    {
        self.deltaY = (rand() % 4 + 1);
    }
    else
    {
        self.deltaY = (-1) * (rand() % 4
                              + 1);
    }
}

-(BOOL)checkRival
{
    if (
        (CGRectGetMinY(self.ball.frame) == 90.) &
        (self.ball.center.x + 5.0 >= CGRectGetMinX(self.rival.frame)) &
        (self.ball.center.x - 5.0 <= CGRectGetMaxX(self.rival.frame))
        )
    {
       return FALSE;
    }
    else return TRUE;
}

-(BOOL)checkPlatforma
{
    if (
        (CGRectGetMaxY(self.ball.frame) == CGRectGetHeight(self.view.frame) - 60.) &
        (self.ball.center.x >= CGRectGetMinX(self.platforma.frame) - 5.0) &
        (self.ball.center.x <= CGRectGetMaxX(self.platforma.frame) + 5.0)
        )
    {
        return FALSE;
    }
    else return TRUE;
}

-(BOOL)checkBoundsX
{
    if (CGRectGetMaxX(self.ball.frame) >= CGRectGetMaxX(self.view.frame))
    {
        return FALSE;
    }
    else if (CGRectGetMinX(self.ball.frame) <= CGRectGetMinX(self.view.frame))
    {
        return FALSE;
    }
    else return TRUE;
}

-(BOOL)checkBoundsY
{
    if (CGRectGetMaxY(self.ball.frame) >= CGRectGetMaxY(self.touchView.frame))
    {
        return FALSE;
    }
    else if (CGRectGetMinY(self.ball.frame) <= 41.0)
    {
        return FALSE;
    }
    else return TRUE;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [self locationInCurrentViewWithTouchSet:touches];
    
    if(CGRectGetWidth(self.view.frame)- CGRectGetWidth(self.platforma.frame)/2 >= location.x)
       if (0. <= location.x - CGRectGetWidth(self.platforma.frame)/2)
       {
           self.platforma.center = CGPointMake(location.x, self.platforma.center.y);
       }
}

-(CGPoint)locationInCurrentViewWithTouchSet:(NSSet *)touches
{
    UITouch *t = [touches anyObject];
    return [t locationInView:self.touchView];
}

@end
