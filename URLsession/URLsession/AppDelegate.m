//
//  AppDelegate.m
//  URLsession
//
//  Created by Вероника on 03.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    
    ViewController *rootViewConroller = [ViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = rootViewConroller;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
