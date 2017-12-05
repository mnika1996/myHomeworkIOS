//
//  TouchView.m
//  TestVC
//
//  Created by Вероника on 11.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//
#import "TouchView.h"

@interface TouchView()
    @property CGPoint previousLocation;
    @property CGFloat step;
@property (nonatomic, strong) UILabel* labelAlpha;
@property (nonatomic, strong) UILabel* labelStep;

@end

@implementation TouchView

-(instancetype)initWithFrame:(CGRect)frame AndWithLabel:(UILabel *) labelAlpha AndLabelStep: (UILabel *) labelStep{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.previousLocation = CGPointZero;
        self.step = 0.005f;
        self.labelAlpha = labelAlpha;
        self.labelStep = labelStep;
    }
    return self;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *t = [touches anyObject];
//
//    CGPoint location = [t locationInView:self];
    
    CGPoint location = [self locationInCurrentViewWithTouchSet:touches];
    NSLog(@"Касание началось в области - x:%f :y%f", location.x, location.y);
    self.previousLocation = location;    
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *t = [touches anyObject];
//
//    CGPoint location = [t locationInView:self];
    
    CGPoint location = [self locationInCurrentViewWithTouchSet:touches];
    NSLog(@"Касание окончено - x:%f :y%f", location.x, location.y);
    
    [self changeAlphaAndStep:location :self.previousLocation];
    self.previousLocation = location;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    UITouch *t = [touches anyObject];
    //
    //    CGPoint location = [t locationInView:self];
    
    CGPoint location = [self locationInCurrentViewWithTouchSet:touches];
    NSLog(@"Касание продолжается - x:%f :y%f", location.x, location.y);
    
    [self changeAlphaAndStep:location :self.previousLocation];
    self.previousLocation = location;
}



-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Касание отменено  ");
}

-(void)changeAlphaAndStep:(CGPoint)currentLocation :(CGPoint)previousLocation
{
    if(currentLocation.y - previousLocation.y < - 1)
    {
        [self increaseAlpha];
    }
    else if(currentLocation.y > previousLocation.y + 1)
    {
        [self decreaseAlpha];
    }
    if(currentLocation.x > previousLocation.x + 1)
    {
        [self increaseStep];
    }
    else if(currentLocation.x + 1 < previousLocation.x)
    {
        [self decreaseStep];
    }
}

-(void)increaseStep
{
    if (self.step + 0.001f < 1.0f)
    {
        self.step = self.step + 0.001f;
        NSString *string = [NSString stringWithFormat:@"%f", self.step];
        self.labelStep.text = string;
    }
}

-(void)decreaseStep
{
    if (self.step - 0.001f > 0.0f)
    {
        self.step = self.step - 0.001f;
        NSString *string = [NSString stringWithFormat:@"%f", self.step];
        self.labelStep.text = string;
    }
}

-(void)increaseAlpha
{
    if (self.alpha + self.step < 1)
    {
        self.alpha += self.step;
        NSString *string = [NSString stringWithFormat:@"%f", self.alpha];
        self.labelAlpha.text = string;
    }
}

-(void)decreaseAlpha
{
    if (self.alpha - self.step > 0)
    {
        self.alpha -= self.step;
        NSString *string = [NSString stringWithFormat:@"%f", self.alpha];
        self.labelAlpha.text = string;
    }
}

-(CGPoint)locationInCurrentViewWithTouchSet:(NSSet *)touches
{
    UITouch *t = [touches anyObject];
    return [t locationInView:self];
}
@end
