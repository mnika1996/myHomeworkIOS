//
//  AppDelegate.m
//  Architecture
//
//  Created by Вероника on 25.11.17.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [UIWindow new];
    
    ViewController *rootViewController = [ViewController new];
    rootViewController.view.backgroundColor =[UIColor whiteColor];
    
    self.window.rootViewController = rootViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
