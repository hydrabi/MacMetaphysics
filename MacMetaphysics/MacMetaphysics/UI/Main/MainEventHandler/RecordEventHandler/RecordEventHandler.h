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
@end
