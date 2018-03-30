//
//  RecordExtraModel.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/27.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 对记录做额外操作的模型
 */
@interface RecordExtraModel : NSObject

/**
 组合后的四柱字符串
 */
@property (nonatomic, copy) NSString * fullSiZhuString;

/**
 该四柱出现的次数
 */
@property (nonatomic, assign) NSUInteger siZhuAppearTimes;
@end
