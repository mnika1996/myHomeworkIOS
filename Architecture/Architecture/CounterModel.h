//
//  CounterModel.h
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import <Foundation/Foundation.h>
//#import "PresenterProtocol.h"
#import "ViewModelProtocol.h"

@interface CounterModel : NSObject

@property (nonatomic, strong) NSNumber *counter;

//@property (nonatomic, weak) id<PresenterProtocol> presenter;

@property (nonatomic, weak) id<ViewModelProtocol> viewModel;

-(void)plus;

-(void)minus;

-(NSString *)formatNumber;

@end
