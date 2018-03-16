//
//  RecordEventHandler.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/15.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "RecordEventHandler.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Record+CoreDataProperties.h"
@implementation RecordEventHandler

-(void)initialize{
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    Record *record = [Record MR_createEntityInContext:defaultContext];
    
    record.key = @"1";
    record.name = @"name";
    record.other = @"other";
    record.ganZhiDay = @"1";
    record.ganZhiMonth = @"1";
    record.ganZhiHour = @"1";
    record.ganZhiYear = @"1";
    
    // 保存修改到当前上下文中.
    [defaultContext MR_saveToPersistentStoreAndWait];
    
    [self fetchAll];
}

-(void)fetchAll{
    NSArray *recordArr = [Record MR_findAll];
    for(Record *record in recordArr){
        NSLog(@"%@,%@",record.key,record.name);
    }
    NSLog(@"");
}

@end
