//
//  NSDate+Addition.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/26.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

/**
 根据制定的格式获取日期字符串 yyyy-MM-dd HH:mm:ss.S
 
 @param format 日期格式
 @return 日期字符串
 */
- (NSString *)toStringWithFormat:(NSString*)format;

@end
