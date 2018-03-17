//
//  MainWindowViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/4.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainWindowViewController.h"
#import "MainViewController.h"
#import "MainViewModel.h"
@interface MainWindowViewController ()

@end

@implementation MainWindowViewController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    MainViewModel *viewModel = [MainViewModel sharedInstance];
    MainViewController *viewController = [[MainViewController alloc] initWithViewModel:viewModel];
    
    //设置初始位置
    NSScreen *screen = self.window.screen;
    CGFloat offsetFromLeftOfScreen = 0.0f;
    CGFloat offsetFromTopOfScreen = 20.0f;
    CGRect screenRect = NSRectToCGRect(screen.visibleFrame);
    CGFloat newOriginY = CGRectGetMaxY(screenRect) - self.window.frame.size.height - offsetFromTopOfScreen;
    [self.window setFrameOrigin:NSMakePoint(offsetFromLeftOfScreen, newOriginY)];
    
    self.contentViewController = viewController;
}

- (void)windowWillClose:(NSNotification *)notification{
    [[NSApplication sharedApplication] terminate:nil];
}

@end
