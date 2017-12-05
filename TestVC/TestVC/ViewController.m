//
//  ViewController.m
//  TestVC
//
//  Created by Вероника on 11.11.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"

@interface ViewController ()
    //@property CGFloat step;
@property (nonatomic, strong) TouchView *touchView;
    @property (nonatomic, strong) UILabel *labelAlpha;
    @property (nonatomic, strong) UILabel *labelStep;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.step = 0.05f;
    
    self.labelAlpha = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 100, 200)];
    self.labelStep = [[UILabel alloc] initWithFrame:CGRectMake(280, 40, 100, 200)];
    
    self.touchView = [[TouchView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) AndWithLabel: self.labelAlpha AndLabelStep: self.labelStep];
    self.touchView.center = self.view.center;
    self.touchView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.touchView];
    
   
    NSString *string = [NSString stringWithFormat:@"%f", self.touchView.alpha];
    self.labelAlpha.text = string;
    [self.view addSubview:self.labelAlpha];
    
    string = [NSString stringWithFormat:@"%f", 0.005f];
    self.labelStep.text = string;
    [self.view addSubview:self.labelStep];
    
    
    [self addGestureRecognizer];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 100, 100)];
//   //UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//
////    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 100, 100)];
////    //UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
////    upperView.backgroundColor = [UIColor greenColor];
////    upperView.alpha = 0.5;
////    [self.view addSubview:upperView];
//
//    NSArray *array =@[@"Fill", @"array", @"with", @"someStuff"];
//    //[self checkVCExistence];
//    //[self removeView];
//
    
    
    
}


-(void)viewWillAppear:(BOOL)animated //budet vuzvan do opercii
{
    [super viewWillAppear:YES];
    NSLog(@"");
}

-(void)removeView
{
    self.view = nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 100, 100)];
    
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)checkVCExistence
{
    UIViewController *controller = [UIViewController new];
    
    /*pravilnaya proverka*/
    if([controller isViewLoaded])
    {
        NSLog(@"View уже загружена");
    }
    
    /*ne pravilnaya proverka*/
    if (controller.view) {
        NSLog(@"View создана");
    }
}

#pragma mark = UI

-(void)addGestureRecognizer
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchHappened)];
    recognizer.delaysTouchesBegan = YES;
    [self.touchView addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHappened:)];
    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.touchView addGestureRecognizer:swipeDownRecognizer];
    
    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHappened:)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.touchView addGestureRecognizer:swipeUpRecognizer];
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHappened:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.touchView addGestureRecognizer:swipeLeftRecognizer];
    
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHappened:)];
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.touchView addGestureRecognizer:swipeRightRecognizer];
    
}


-(void)swipeHappened :(UISwipeGestureRecognizer *) swipeRecognizer
{
    if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionDown)
    {
//        if (self.touchView.alpha - self.step  > 0)
//        {
//            self.touchView.alpha -= self.step;
//            NSString *string = [NSString stringWithFormat:@"%f", self.touchView.alpha];
//            self.label.text = string;
//        }
        [self.touchView decreaseAlpha];
    }
    else if (swipeRecognizer.direction & UISwipeGestureRecognizerDirectionUp)
    {
//        if (self.touchView.alpha + self.step < 1)
//        {
//            self.touchView.alpha += self.step;
//            NSString *string = [NSString stringWithFormat:@"%f", self.touchView.alpha];
//            self.label.text = string;
//        }
        [self.touchView increaseAlpha];
    }
    else if (swipeRecognizer.direction & UISwipeGestureRecognizerDirectionRight)
    {
//        if (self.step + 0.01f < 1.0f)
//        {
//            self.step = self.step + 0.01f;
//        }
        [self.touchView increaseStep];
    }
    else
    {
//         if (self.step - 0.01f > 0.0f)
//         {
//             self.step = self.step - 0.01f;
//         }
        [self.touchView decreaseStep];
    }
}

-(void)touchHappened
{
    NSLog(@"Recognizer сработал");
}

@end
