//
//  SaveWindowController.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SaveWindowController.h"
#import "SaveViewModel.h"
#import "SaveViewController.h"
#import "AppDelegate.h"

@interface SaveWindowController ()

@end

@implementation SaveWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    SaveViewModel *viewModel = [[SaveViewModel alloc] init];
    SaveViewController *viewController = [[SaveViewController alloc] initWithViewModel:viewModel];
    
    self.contentViewController = viewController;
}

+(instancetype)showSaveModelViewController{
    SaveWindowController *windowController = [[SaveWindowController alloc] initWithWindowNibName:NSStringFromClass([SaveWindowController class])];
    
    [[NSApplication sharedApplication] runModalForWindow:windowController.window];
    return windowController;
}

- (void)windowWillClose:(NSNotification *)notification{
    [[NSApplication sharedApplication] stopModal];
}
@end
