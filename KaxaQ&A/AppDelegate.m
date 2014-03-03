//
//  AppDelegate.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/16.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "HomeTableViewController.h"
#import "MyAreaTableViewController.h"
#import "SettingTableViewController.h"
#import "SearchResultTableViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [homeNavigation release], homeNavigation = nil;
    [meNavigation release], meNavigation = nil;
    [searchNavigation release], searchNavigation = nil;
    [settingNavigation release], settingNavigation = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *homeView = [[[HomeTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    UIViewController *myAreaView = [[[MyAreaTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    SearchResultTableViewController *searchResultView = [[[SearchResultTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    SettingTableViewController *viewController4 = [[[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    homeNavigation = [[[UINavigationController alloc] initWithRootViewController:homeView] autorelease];
    meNavigation = [[[UINavigationController alloc] initWithRootViewController:myAreaView] autorelease];
    searchNavigation = [[[UINavigationController alloc] initWithRootViewController:searchResultView] autorelease];
    settingNavigation = [[[UINavigationController alloc] initWithRootViewController:viewController4] autorelease];
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeNavigation, meNavigation, searchNavigation, settingNavigation, nil];
    [self.tabBarController.tabBar setTintColor:[UIColor darkGrayColor]];
    [self.tabBarController.tabBar setSelectedImageTintColor:[UIColor redColor]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    //向ASPN註冊
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    
    //檢查網路連線
    if (kaxaNetReach == nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(networkReachabilityChanged:)
                                                     name:kReachabilityChangedNotification 
                                                   object:nil];
        kaxaNetReach = [[Reachability reachabilityWithHostName:kaxaReachUrl] retain];
        [kaxaNetReach startNotifier];
        /*
        NetworkStatus currentStatus = [kaxaNetReach currentReachabilityStatus];
        if (currentStatus == NotReachable)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kaxaNetNotReachName object:self userInfo:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kaxaNetReachName object:self userInfo:nil];
        }
        */
    }
    UIDevice *device = [UIDevice currentDevice];
    double  ver = [[device systemVersion] floatValue];
    if (ver >= 5.0)
    {
        //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:navigationBarBackground] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:navigationBarColor];
        //[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:navigationBarButtonColor];
        //[[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:toolbarBackground] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        [[UIToolbar appearance] setTintColor:toolBarColor];
        //[[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTintColor:toolBarButtonColor];
    }
    [self regLocalPush];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/
/*
 取得 push token
 */
//取得設備標記Device token .
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
{
	
    //使用[NSUserDefaults standardUserDefaults]來儲存deviceToken
    [[NSUserDefaults standardUserDefaults] setValue:[deviceToken description] forKey: @"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Device token:%@",[deviceToken description]);
    
}
//取得失敗 .
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {     
    NSLog(@"Device token:%@",[err description]);
}
//設定訊息類型.
- (UIRemoteNotificationType)enabledRemoteNotificationTypes 
{
	return UIRemoteNotificationTypeBadge
    |UIRemoteNotificationTypeAlert
    |UIRemoteNotificationTypeSound;
}
//檢查網路連線
- (void)networkReachabilityChanged:(NSNotification*)notify
{
    Reachability *currentReachability = [notify object];
    
    NetworkStatus currentStatus = [currentReachability currentReachabilityStatus];
    
    if (currentStatus == NotReachable)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kaxaNetNotReachName object:self userInfo:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kaxaNetReachName object:self userInfo:nil];
    }
}
#pragma mark - register local push
- (void)regLocalPush
{
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
        NSDateFormatter *comps = [[NSDateFormatter alloc] init];
        [comps setDateFormat:@"yyyy-MM-dd HH:mm zzzz"];
        NSDate *date = [comps dateFromString:@"2011-10-09 20:00 +0800"];
        [comps release];
        
        notification.fireDate = date;
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.repeatInterval = NSDayCalendarUnit;
        notification.alertBody=@"一起Kaxa吧，讓每顆熱情學習的心持續跳動!!";
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
    [notification release];
}
@end
