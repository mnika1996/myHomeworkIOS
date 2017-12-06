//
//  SWMR.m
//  SynchronizeIOS
//
//  Created by Вероника on 05.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "SWMR.h"

@interface SWMR()

@property(nonatomic, strong) NSLock *lock;
@property (strong) dispatch_queue_t SWMRqueue;

@end

@implementation SWMR

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _lock = [NSLock new];
        _SWMRqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

@synthesize count = _count;

//-(void)setCount:(NSUInteger)count
//{
//    @synchronized(self)
//    {
//        _count = count;
//    }
//
//}
//
//-(NSUInteger)count
//{
//    @synchronized(self)
//    {
//        return _count;
//    }
//}

//-(void)setCount:(NSUInteger)count
//{
//    [self.lock lock];
//    _count = count;
//    [self.lock unlock];
//
//}


-(void)setCount:(NSUInteger)count
{
    
    dispatch_barrier_sync(self.SWMRqueue, ^(void){
        _count = count;
    });
    
}

-(NSUInteger)count
{
    __block NSUInteger updatedCount = 0;
    dispatch_sync(self.SWMRqueue, ^(void){
        updatedCount = _count;
    });
    return updatedCount;
}

@end
