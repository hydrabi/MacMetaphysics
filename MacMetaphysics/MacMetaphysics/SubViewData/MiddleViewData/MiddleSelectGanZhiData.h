//
//  MiddleSelectGanZhiData.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/2/23.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SubViewData.h"
#import "UIConstantParameter.h"

/**
 记录选择命柱的干支的位置
 */
@interface MiddleSelectGanZhiLocation:NSObject

/**
 选中干
 */
@property (nonatomic,assign)BOOL selectedGan;

/**
 选中支
 */
@property (nonatomic,assign)BOOL selectedBranch;
@end

/**
 记录选择中间某个命柱的干支的情况的数据
 */
@interface MiddleSelectGanZhiData : SubViewData

/**
 四个命柱选中干支存储的位置信息
 */
@property (nonatomic,strong)NSMutableArray<MiddleSelectGanZhiLocation*> *selectLocationArr;

#pragma mark - 选中（反选）操作

/**
 中间四柱选中干支记录位置

 @param type 命柱的类型（相对于点击哪一个命柱）
 @param isGan 是否点击天干
 */
-(void)selectWithType:(MiddleSubViewType)type isGan:(BOOL)isGan;

/**
 指定命柱的选中情况获取

 @param type 命柱的类型（相对于点击哪一个命柱）
 @return 记录选择命柱的干支的位置信息
 */
-(MiddleSelectGanZhiLocation*)getLocationWithType:(MiddleSubViewType)type;

@end
