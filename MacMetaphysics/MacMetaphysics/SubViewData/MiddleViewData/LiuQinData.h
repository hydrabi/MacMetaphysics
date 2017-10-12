//
//  LiuQinData.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubViewData.h"

/**
 六亲表（十神表）
 */
@interface LiuQinData : SubViewData

/**
 六亲的对应字典
 */
@property (nonatomic,strong)NSMutableDictionary *liuQinDic;

/**
 年顶部的六亲
 */
@property (nonatomic,strong)NSString *yearTopLiuQin;

/**
 年里面的六亲
 */
@property (nonatomic,strong)NSString *yearBottomLiuQin;

/**
 月顶部的六亲
 */
@property (nonatomic,strong)NSString *monthTopLiuQin;

/**
 月里面的六亲
 */
@property (nonatomic,strong)NSString *monthBottomLiuQin;

/**
 日部的六亲
 */
@property (nonatomic,strong)NSString *dayTopLiuQin;

/**
 日里面的六亲
 */
@property (nonatomic,strong)NSString *dayBottomLiuQin;

/**
 时顶部的六亲
 */
@property (nonatomic,strong)NSString *hourTopLiuQin;

/**
 时里面的六亲
 */
@property (nonatomic,strong)NSString *hourBottomLiuQin;

/**
 获取对应天干的六亲值

 @param riGanZhi 日干支
 @param otherGanZhi 其它的干支
 @return 对应六亲值
 */
-(NSString*)getLiuQinValueWithRiGanZhi:(NSString*)riGanZhi
                           otherGanZhi:(NSString*)otherGanZhi;

/**
 获取对应藏干的六亲值

 @param riGanZhi 日干支
 @param cangGan 藏干
 @return 获取对应藏干的六亲值
 */
-(NSString*)getLiuQinValueWithRiGanZhi:(NSString*)riGanZhi
                               cangGan:(NSString*)cangGan;
@end
