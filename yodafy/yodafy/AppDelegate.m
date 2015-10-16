//
//  AppDelegate.m
//  yodafy
//
//  Created by Colin Smith on 10/15/15.
//  Copyright © 2015 Colin Smith. All rights reserved.
//

#import "AppDelegate.h"
#import "YDLandingViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) YDLandingViewController *initialViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.initialViewController = [[YDLandingViewController alloc] initWithNibName:nil bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.initialViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
