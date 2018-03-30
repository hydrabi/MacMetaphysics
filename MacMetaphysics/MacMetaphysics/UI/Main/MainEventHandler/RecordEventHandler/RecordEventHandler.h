//
//  RecordEventHandler.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/15.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BasicEventHandler.h"
@class Record;
@interface RecordEventHandler : BasicEventHandler

/**
 保存当前记录
 */
-(void)saveCurrentRecord;

/**
 删除所有记录
 */
-(void)deleteAllRecord;

/**
 删除指定的记录

 @param recordArr 需要删除的记录
 */
-(void)deleteRecords:(NSArray<Record*>*)recordArr;

/**
 获取所有记录

 @return 所有记录组成的队列
 */
-(NSArray*)fetchAll;

/**
 根据特定的条件查找记录

 @param predicate 正则表达式（需要查找的条件）
 @return 根据特定的条件返回的记录
 */
-(NSArray*)fetchWithPredicate:(NSPredicate*)predicate;

/**
 根据日期排序

 @param recordArr 记录队列
 @return 已排序的记录队列
 */
-(NSArray*)sortByDateWithRecordArr:(NSArray<Record*>*)recordArr;

#pragma mark - 读取记录

/**
 读取记录（包括填充key，姓名，笔记等）

 @param record 需要读取的记录
 */
-(void)readRecord:(Record*)record;
@end
