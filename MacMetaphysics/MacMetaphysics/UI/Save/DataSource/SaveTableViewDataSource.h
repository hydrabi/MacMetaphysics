//
//  SaveTableViewDataSource.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/22.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SaveViewController;
@class SaveViewModel;

/**
 处理保存数据页面的tableView的数据源
 */
@interface SaveTableViewDataSource : NSObject<NSTableViewDelegate,NSTableViewDataSource>

/**
 数据队列
 */
@property (copy, nonatomic)NSArray *recordArr;

/**
 初始化的同时带上viewModel

 @param viewModel viewModel
 @param viewController viewController
 @return 处理保存数据页面的tableView的数据源实例
 */
-(instancetype)initWithViewModel:(SaveViewModel*)viewModel viewController:(SaveViewController*)viewController;

/**
 重新加载数据
 */
-(void)reloadRecord;

@end
