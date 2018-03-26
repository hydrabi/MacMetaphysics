//
//  NSAlert+Addition.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/26.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "NSAlert+Addition.h"
#import "MainViewModel.h"
#import "MainViewController.h"

@implementation NSAlert (Addition)

+(void)showAlertWithMessage:(NSString*)message Informative:(NSString*)informative complete:(void(^)(NSModalResponse resultCode))complete{
    MainViewModel *viewModel = [MainViewModel sharedInstance];
    MainViewController *viewController = (MainViewController*)viewModel.viewController;
    
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    [alert setMessageText:message];
    [alert setInformativeText:informative];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert beginSheetModalForWindow:viewController.view.window
                  completionHandler:^(NSModalResponse resultCode){
                      if(complete){
                          complete(resultCode);
                      }
                  }];
}

@end
