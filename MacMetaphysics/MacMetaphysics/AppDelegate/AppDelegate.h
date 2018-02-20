//
//  AppDelegate.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/3.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

/**
 开始时打开的window窗口
 */
@property (nonatomic,strong)MainWindowViewController *mainWindowViewController;
@property (weak) IBOutlet NSMenu *MainMenu;

@end

