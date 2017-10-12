//
//  NSString+Addition.h
//  Metaphysics
//
//  Created by Hydra on 2017/2/1.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIConstantParameter.h"
@interface NSString (Addition)
+ (NSString *)convertToIconTextWithHexString:(NSString *)hexStr;

/**
 天干字符串

 @return 天干字符串
 */
+(NSString*)stemsStr;

/**
 地支字符串

 @return 地支字符串
 */
+(NSString*)branchesStr;

/**
 对应的时间转换为时辰

 @param time 对应的时
 @return 对应的时辰
 */
+(NSString*)shiChenWithTime:(NSInteger)time;

/**
 获取干支时

 @param hour 当前选中时间
 @param day 当前已经得到的干支日
 @return 时的干支
 */
+(NSString*)ganZhiHourWithHour:(NSInteger)hour day:(NSString*)day;

/**
 获取干支中的天干

 @return 返回天干
 */
-(NSString*)getStems;

/**
 获取干支中的地支
 
 @return 返回地支
 */
-(NSString*)getBranches;

/**
 判断天干是阴还是阳

 @return yes为阳，no为阴
 */
-(BOOL)isStemsYang;

/**
 判断地支是阴还是阳
 
 @return yes为阳，no为阴
 */
-(BOOL)isBranchesYang;

/**
 获取六亲指定枚举类型的文字

 @param type 六亲指定枚举类型
 @return 六亲指定枚举类型的文字
 */
+(NSString*)getValueWithType:(liuQinType)type;


@end
