//
//  AppDelegate.m
//  Flickr
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
    
    ViewController *rootViewController = [ViewController new];
    rootViewController.view.backgroundColor = [UIColor colorWithRed:134.0f/255.0f green:147.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
    
    self.window.rootViewController = rootViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
