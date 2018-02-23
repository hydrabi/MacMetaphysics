//
//  MiddleViewData.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SubViewData.h"
#import "LiuQinData.h"
#import "CangGanData.h"
#import "NaYinData.h"
#import "ShenShaData.h"
#import "MiddleSelectGanZhiData.h"
#import "UIConstantParameter.h"
@interface MiddleViewData : SubViewData

/**
 乾坤
 */
@property (nonatomic,assign)UniverseType universeType;

/**
 六亲数据
 */
@property (nonatomic,strong)LiuQinData *liuQinData;

/**
 藏干数据
 */
@property (nonatomic,strong)CangGanData *cangGanData;

/**
 纳音数据
 */
@property (nonatomic,strong)NaYinData *naYinData;

/**
 神煞数据
 */
@property (nonatomic,strong)ShenShaData *shenShaData;

/**
 选中的干支情况
 */
@property (nonatomic,strong)MiddleSelectGanZhiData *selectGanZhiData;
@end
