//
//  ViewPresenter.h
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import <Foundation/Foundation.h>
#import "ViewProtocol.h"
#import "PresenterProtocol.h"

@interface Presenter : NSObject <PresenterProtocol>
-(instancetype)initWithView:(id<ViewProtocol>) view;
@end
