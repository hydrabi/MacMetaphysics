//
//  NSAlert+Addition.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/26.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSAlert (Addition)

/**
 使用NSAlert的快捷方式

 @param message 主提示
 @param informative 副提示
 @param complete 选择完成回调
 */
+(void)showAlertWithMessage:(NSString*)message Informative:(NSString*)informative complete:(void(^)(NSModalResponse resultCode))complete;

@end
