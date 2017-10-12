//
//  NaYinData.h
//  Metaphysics
//
//  Created by Hydra on 2017/3/26.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SubViewData.h"

@interface NaYinData : SubViewData

/**
 纳音字典
 */
@property (nonatomic,strong)NSMutableDictionary *naYinDic;
/**
 年的纳音
 */
@property (nonatomic,strong)NSString *yearNaYin;
/**
 月的纳音
 */
@property (nonatomic,strong)NSString *monthNaYin;
/**
 日的纳音
 */
@property (nonatomic,strong)NSString *dayNaYin;
/**
 时的纳音
 */
@property (nonatomic,strong)NSString *hourNaYin;
@end
