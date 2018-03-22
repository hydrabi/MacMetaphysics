//
//  SaveViewController.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BasicViewController.h"

/**
 用于保存出生日期等信息
 */
@interface SaveViewController : BasicViewController

/**
 编号输入框
 */
@property (weak) IBOutlet NSTextField *keyInputTextView;

/**
 按编号查找按钮
 */
@property (weak) IBOutlet NSButton *keySearchButton;

/**
 展示记录的tableView
 */
@property (weak) IBOutlet NSTableView *recordTableView;

@end
