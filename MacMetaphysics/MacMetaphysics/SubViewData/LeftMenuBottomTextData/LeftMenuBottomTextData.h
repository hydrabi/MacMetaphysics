//
//  LeftMenuBottomTextData.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/18.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SubViewData.h"
@class Record;

/**
 左边菜单点击对应选项后出现在底部的textView 记录每个不同选项对应的数据
 */
@interface LeftMenuBottomTextData : SubViewData

/**
 记录每个不同选项对应的数据 leftMneuType作为key 记录textView记录的文字
 */
@property (nonatomic,strong)NSMutableDictionary *bottomTextRecordDic;

/**
 获取当前枚举对应的数据

 @return 字符串
 */
-(NSString*)getCurrentString;


/**
 读取记录

 @param record 记录模型
 */
-(void)readRecord:(Record*)record;

@end
