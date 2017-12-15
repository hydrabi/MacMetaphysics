//
//  BottomFirstTableViewHeader.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BasicNibView.h"
@interface BottomFirstTableViewHeader : BasicNibView
/**
 恢复按钮，使流年选择清空，流年窗口隐藏，大运选择恢复
 */
@property (weak) IBOutlet NSTextField *recoverButton;
@end
