//
//  TopContentViewController+Record.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/30.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "TopContentViewController.h"
@class Record;
/**
 填充记录
 */
@interface TopContentViewController (Record)

/**
 填充记录

 @param record 记录模型
 */
-(void)fillTextViewWithRecord:(Record*)record;
@end
