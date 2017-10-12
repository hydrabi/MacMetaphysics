//
//  NSNumber+Addition.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/12.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Addition)

/**
 获取指定月份的天数

 @param month 月份
 @param year 年
 @return 指定月份的天数
 */
+(NSInteger)getDayCountWithMonth:(NSInteger)month year:(NSInteger)year;
@end
