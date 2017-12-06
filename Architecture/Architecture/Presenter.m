//
//  ViewPresenter.m
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import "Presenter.h"
//#import "CounterModel.h"
#import "ViewProtocol.h"

@interface Presenter()

//@property (nonatomic, strong)CounterModel *counterModel;
@property (nonatomic, weak) id<ViewProtocol> view;

@end

@implementation Presenter
//
//-(instancetype)initWithView:(id<ViewProtocol>)view
//{
//    self = [super init];
//    if(self)
//    {
//        _view = view;
//
//        _counterModel = [CounterModel new];
//        //_counterModel.presenter = self;
//        [self.view setCounterLabelText:[self.counterModel formatNumber]];
//    }
//    return self;
//}
//
-(void)plus
{
    //[self.counterModel plus];
}

-(void)minus
{
    //[self.counterModel minus];
}

-(void)valueChanged{
    //NSString *newValuString = [self.counterModel formatNumber];
    //[self.view setCounterLabelText:newValuString];
}
@end
