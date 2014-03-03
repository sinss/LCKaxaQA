//
//  AppDelegate.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/16.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    Reachability *kaxaNetReach;
    UINavigationController *homeNavigation;
    UINavigationController *meNavigation;
    UINavigationController *searchNavigation;
    UINavigationController *settingNavigation;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
