//
//  AppDelegate.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/3.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.mainWindowViewController = [[MainWindowViewController alloc] initWithWindowNibName:NSStringFromClass([MainWindowViewController class])];
    [self.mainWindowViewController.window makeKeyAndOrderFront:nil];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
