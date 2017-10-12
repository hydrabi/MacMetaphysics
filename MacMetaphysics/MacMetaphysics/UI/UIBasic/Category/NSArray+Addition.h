//
//  NSArray+Addition.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/11.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIConstantParameter.h"


@interface NSArray (Addition)

/**
 创建干支

 @return 干支名称队列
 */
+(NSMutableArray*)jiaZiArr;

/**
 节气名称队列

 @return 节气名称队列
 */
+(NSArray*)termsNameArr;

/**
 月份名称队列

 @return 月份名称队列
 */
+(NSArray*)monthNameArr;

/**
 分隔月份的天数表，日柱表用

 @param month monthNameArr的对应索引
 @return 分隔月份的天数表
 */
+(NSArray*)separatorDayWithMonth:(NSInteger)month;

/**
 分隔月份名称的天数表，日柱表用

 @param month monthNameArr的对应索引
 @return 分隔月份名称的天数表
 */
+(NSArray*)separatorDayNameWithMonth:(NSInteger)month;

/**
 获取该年所有节气得准确时间

 @param year 那一年
 @param solarTermTimeArr 节气时间
 @param termsDate 节气日期
 @return 该年所有节气得准确时间
 */
+(NSMutableArray*)allTermsDateArrWithYear:(NSInteger)year solarTermTimeArr:(NSArray*)solarTermTimeArr termsDate:(NSMutableArray*)termsDate;

/**
 藏干对应地支的名称队列

 @return 藏干对应地支的名称队列
 */
+(NSArray*)cangGanArray;

/**
 纳音队列

 @return 纳音队列
 */
+(NSArray*)naYinArray;

/**
 六亲队列

 @param index 顺序
 @return 六亲队列
 */
+(NSArray*)getLiuQinArrWithIndex:(NSInteger)index;

/**
 根据年干返回月的干支（年上起月 双造用）

 @param stems <#stems description#>
 @return <#return value description#>
 */
+(NSArray*)getMonthGanZhiArrWithStems:(NSString*)stems;

/**
 所有中气

 @return <#return value description#>
 */
+(NSArray*)zhongQiArr;
@end
