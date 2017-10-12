//
//  BottomViewData.h
//  Metaphysics
//
//  Created by Hydra on 2017/4/9.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SubViewData.h"
#import "UIConstantParameter.h"
static NSInteger tableViewSection = 2;
static NSInteger rowPerSection = 5;
static NSInteger rowPerVerticalLine = 10;

@interface BottomViewData : SubViewData
//起运天数
@property (nonatomic,assign)NSInteger qiYunShu;
//月柱在甲子队列中的位置
@property (nonatomic,assign)NSInteger firstIndexOfYueZhu;
//此属性为yes时方可展开计算
@property (nonatomic,assign)BOOL canStart;

//获取当前tableview tag所属索引对应的大运干支
-(NSString*)getDaYunWithTableIndex:(NSInteger)tableIndex;

//获取当前tableview tag所属索引对应的大运干支(双造用)
-(NSString*)getDaYunWithTableIndex:(NSInteger)tableIndex
                      universeType:(UniverseType)type
                            ganZhi:(NSString*)ganZhi
                       yueZhuIndex:(NSInteger)yueZhuIndex;

//获取ableview tag，row，section所对应的流年，年份
-(void)fillContentWithTableIndex:(NSInteger)tableIndex
                          tableSection:(NSInteger)tableSection
                              tableRow:(NSInteger)tableRow
                                 block:(void(^)(NSString *liuNian,NSString *xiaoYun,NSString *year))block;
@end
