//
//  ViewModel.m
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import "ViewModel.h"
#import "ViewController.h"
#import "CounterModel.h"

@interface ViewModel ()

@property (nonatomic, weak) id<ViewProtocol> view;
@property (nonatomic, strong) CounterModel *model;

@end

@implementation ViewModel

-(void)valueChanged{
    self.counterText = [self.model formatNumber];
}

-(void)minus{
    [self.model minus];
}

-(void)plus{
    [self.model plus];
}

-(instancetype)initWithView:(ViewController *)view
{
    self = [super init];
    if(self)
    {
        _view = view;
        _model = [CounterModel new];
        _model.viewModel = self;
        _counterText = @"ноль";
    }
    return self;
}

-(instancetype)initWithViewModel:(ViewModel*)viewModel
{
    self = [super init];
    if(self)
    {
        _view = viewModel.view;
        _model = viewModel.model;
        _counterText = [_model formatNumber];
    }
    return self;
}

@end
