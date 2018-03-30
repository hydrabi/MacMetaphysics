//
//  AppDelegate.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/3.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "AppDelegate.h"
#import "ScreenShotManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "SaveWindowController.h"
#import "MainViewModel.h"
#import "FNHUD.h"
#import "BackUpMananger.h"

@interface AppDelegate ()
@property (nonatomic,strong)ScreenShotManager *screenShotManager;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.screenShotManager = [[ScreenShotManager alloc] init];
    
    [MagicalRecord setupCoreDataStack];
    [FNHUD setup];
    
    self.mainWindowViewController = [[MainWindowViewController alloc] initWithWindowNibName:NSStringFromClass([MainWindowViewController class])];
    [self.mainWindowViewController.window makeKeyAndOrderFront:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [MagicalRecord cleanUp];
}

//截图
- (IBAction)screenShot:(id)sender {
    [self.screenShotManager start];
}

//查找记录
- (IBAction)findRecord:(id)sender {
    [SaveWindowController showSaveModelViewController];
}

//保存记录
- (IBAction)saveRecord:(id)sender {
    [[MainViewModel sharedInstance].recordEventHandler saveCurrentRecord];
}

//备份操作
- (IBAction)backUp:(id)sender {
    BackUpMananger *backUpManager = [[BackUpMananger alloc] init];
    [backUpManager showSavePath];
}

@end
