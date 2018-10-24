//
//  AppDelegate.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HLNavigationViewController.h"
#import "HLindexViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //清除一些存储数据
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"登录状态"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"type"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"endDate"];
    
    
    //向微信注册，这句必需要有才能在具体的地方实现分享功能。
    [WXApi registerApp:@"wx4868b35061f87885" withDescription:@"artPage 2.0"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //如果已经登录，进入主页
    if([gainUserDefault(@"登录状态") isEqualToString:@"已登录"])
    {
        HLindexViewController *tempVC = [[HLindexViewController alloc] init];
        self.window.rootViewController = [[HLNavigationViewController alloc] initWithRootViewController:tempVC];
    }
    else //进入登录界面
    {
        self.window.rootViewController = [[ViewController alloc] init];
    }
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
