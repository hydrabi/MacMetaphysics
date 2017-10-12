//
//  ShenShaData.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/27.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubViewData.h"
@interface ShenShaData : SubViewData

/**
 年柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *yearShenShaArr;

/**
 月柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *monthShenShaArr;

/**
 日柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *dayShenShaArr;

/**
 时柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *hourShenShaArr;

/**
 所有神煞队列组成的队列
 */
@property (nonatomic,strong)NSMutableArray<NSMutableArray*> *totalShenShaArr;

/**
 干支年
 */
@property (nonatomic,strong)NSString *ganZhiYear;
/**
 干支月
 */
@property (nonatomic,strong)NSString *ganZhiMonth;
/**
 干支日
 */
@property (nonatomic,strong)NSString *ganZhiDay;
/**
 干支时
 */
@property (nonatomic,strong)NSString *ganZhiHour;
/**
 所有干支组成的队列
 */
@property (nonatomic,strong)NSMutableArray *totalGanZhiArr;

#pragma mark - 最上边
/**
 最上边时柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *topHourShenShaArr;

#pragma mark - 最下边
/**
 最下边月柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *bottomMonthShenShaArr;

/**
 最下边日柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *bottomDayShenShaArr;

/**
 最下边时柱神煞队列
 */
@property (nonatomic,strong)NSMutableArray *bottomHourShenShaArr;
@end
