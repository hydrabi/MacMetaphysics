//
//  CangGanData.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SubViewData.h"

/**
 藏干表
 */
@interface CangGanData : SubViewData

/**
 藏干规则字典
 */
@property (nonatomic,strong)NSMutableDictionary *cangGanDic;
/**
 年的藏干
 */
@property (nonatomic,strong)NSString *yearCangGan;
/**
 月的藏干
 */
@property (nonatomic,strong)NSString *monthCangGan;
/**
 日的藏干
 */
@property (nonatomic,strong)NSString *dayCangGan;
/**
 时的藏干
 */
@property (nonatomic,strong)NSString *hourCangGan;

/**
 获取指定的藏干

 @param ganZhi 对应的干支
 @return 对应的藏干
 */
-(NSString*)getCangGanWithGanZhi:(NSString*)ganZhi;
@end
