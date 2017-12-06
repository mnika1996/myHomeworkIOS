//
//  ViewModel.h
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import <Foundation/Foundation.h>
#import "ViewProtocol.h"
#import "ViewModelProtocol.h"

@interface ViewModel : NSObject <ViewModelProtocol>

@property (nonatomic, strong) NSString *counterText;

-(instancetype)initWithView:(id<ViewProtocol>)view;
-(instancetype)initWithViewModel:(ViewModel*)viewModel;
@end
