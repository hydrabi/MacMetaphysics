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
    self.contentViewController = viewController;
}

- (void)windowWillClose:(NSNotification *)notification{
    [[NSApplication sharedApplication] terminate:nil];
}

@end
