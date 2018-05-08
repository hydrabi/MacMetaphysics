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
#import "NSAlert+Addition.h"

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
//    [self.window setFrame:<#(NSRect)#> display:<#(BOOL)#>];
    
    self.contentViewController = viewController;
}

- (void)windowWillClose:(NSNotification *)notification{
    [[NSApplication sharedApplication] terminate:nil];
}

- (BOOL)windowShouldClose:(NSWindow *)sender{
    BOOL result = NO;
    [NSAlert showAlertWithMessage:@"是否需要保存？"
                      Informative:@"选择确定后保存并关闭，选择取消直接关闭"
                         complete:^(NSModalResponse result){
                             if(result == 1000){
                                 [[MainViewModel sharedInstance].recordEventHandler saveCurrentRecordWithCompletion:^(BOOL success){
                                     [[NSApplication sharedApplication] terminate:nil];
                                 }];
                             }
                             else{
                                 [[NSApplication sharedApplication] terminate:nil];
                             }
                         }];
    
    return result;
}

@end
