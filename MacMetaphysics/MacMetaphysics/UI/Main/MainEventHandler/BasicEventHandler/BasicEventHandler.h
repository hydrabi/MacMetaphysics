//
//  BasicEventHandler.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/15.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewModel.h"
#import "MainViewController.h"

@interface BasicEventHandler : NSObject

@property (nonatomic, strong) MainViewModel * viewModel;

@property (nonatomic, strong) MainViewController * viewController;


/**
 初始化的同时带上viewModel
 
 @param viewModel viewModel
 @return 事件处理
 */
-(instancetype)initWithViewModel:(MainViewModel*)viewModel;

/**
 初始化
 */
-(void)initialize;

/**
 绑定viewModel
 */
-(void)bindViewModel;

@end
