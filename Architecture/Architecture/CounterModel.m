//
//  CounterModel.m
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import "CounterModel.h"

@implementation CounterModel

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.counter = @0;
    }
    return self;
}

-(void)plus{
    int newValue  = self.counter.intValue + 1;
    self.counter = [[NSNumber alloc] initWithInt:newValue];
    [self.viewModel valueChanged];
    //[self.presenter valueChanged];
}

-(void)minus
{
    int newValue  = self.counter.intValue;
    if (newValue == 0)
    {
        return;
    }
    newValue-=1;
    self.counter = [[NSNumber alloc] initWithInt:newValue];
    [self.viewModel valueChanged];
    //[self.presenter valueChanged];
}

-(NSString *)formatNumber
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"ru"];
    return [formatter stringFromNumber:self.counter];

}
@end
