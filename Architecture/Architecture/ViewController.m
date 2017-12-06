//
//  ViewController.m
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import "ViewController.h"
#import "CounterModel.h"
#import "Presenter.h"
#import "ViewModel.h"


static CGPoint point = {15.,50.};
static CGSize size = {100., 30.};
static CGFloat elementoofset  = 15.0;

@interface ViewController ()

@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UILabel *label;

//@property (nonatomic, strong) CounterModel *counterModel;

//@property (nonatomic, strong) Presenter *viewPresenter;

//@property (nonatomic, strong) NSString *testObserveble;
@property (nonatomic,strong) ViewModel *viewModel;

@end

@implementation ViewController


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString: @"viewModel"])
    {
        ViewController *newView = object;
        self.label.text = newView.viewModel.counterText;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.counterModel = [CounterModel new];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - size.width * 2)/2, point.y, size.width * 2, size.height)];
    self.label.backgroundColor = [UIColor yellowColor];
    [self.label setText:@"ноль"];
    
//    self.label.text = [self formatNumber:self.counterModel.counter];
    
    self.plusButton = [[UIButton alloc] initWithFrame:CGRectMake(point.x, point.y +  elementoofset + size.height, size.width, size.height)];
    self.plusButton.backgroundColor = [UIColor blueColor];
    [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
    
    self.minusButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - elementoofset - size.width, point.y +elementoofset+ size.height, size.width, size.height)];
    self.minusButton.backgroundColor = [UIColor blueColor];
    [self.minusButton setTitle:@"-" forState:UIControlStateNormal];
    
    [self.view addSubview: self.label];
    [self.view addSubview: self.plusButton];
    [self.view addSubview:self.minusButton];
    
    self.viewModel = [[ViewModel alloc] initWithView:self];
    [self addObserver:self forKeyPath:@"viewModel" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    //self.viewPresenter = [[Presenter alloc] initWithView:self];
//    [self.plusButton addTarget:self.viewPresenter action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
//    [self.minusButton addTarget:self.viewPresenter action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    //[self.minusButton addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    [self.minusButton addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    [self.plusButton addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
}

-(void)plus
{
//    //[self.counterModel  plus];
//    [self updateLabel];
    [self.viewModel plus];
    self.viewModel = [[ViewModel alloc] initWithViewModel:self.viewModel];
}

-(void)minus
{
    //self.testObserveble= @"1223455";
    
    //[self.viewPresenter minus];
    
//    //[self.counterModel minus];
//    [self updateLabel];
    [self.viewModel minus];
    self.viewModel = [[ViewModel alloc] initWithViewModel:self.viewModel];
}
//
//
//-(void)updateLabel
//{
//   // self.label.text = [self formatNumber:self.counterModel.counter];
//}
//
//-(NSString *)formatNumber:(NSNumber*) number
//{
//    NSNumberFormatter *formatter = [NSNumberFormatter new];
//    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
//    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"ru"];
//    return [formatter stringFromNumber:number];
//
//}

//-(void)setCounterLabelText:(NSString*) string
//{
//    self.label.text = string;
//}

@end
