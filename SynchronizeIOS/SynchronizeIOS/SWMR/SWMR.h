//
//  SWMR.h
//  SynchronizeIOS
//
//  Created by Вероника on 05.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWMR : NSObject


@property(nonatomic) NSUInteger count;
//@property(atomic) NSUInteger count;

-(void)setCount:(NSUInteger)count;
-(NSUInteger)count;

@end
