//
//  AppDelegate.m
//  SynchronizeIOS
//
//  Created by Вероника on 05.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "AppDelegate.h"
#import "SWMR.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    SWMR *model = [[SWMR alloc] init];
    model.count = 0;
    
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t iteration){
        if (iteration % 2 == 0)
        {
            ++model.count;
        }
        NSLog(@"iteration = %li  %lu", iteration, model.count);
    });
    return YES;
}

@end
