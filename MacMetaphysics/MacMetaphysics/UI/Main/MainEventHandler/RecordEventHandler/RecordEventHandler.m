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
#import "MainViewController.h"
@implementation RecordEventHandler

-(void)fetchAll{
    NSArray *recordArr = [Record MR_findAll];
    for(Record *record in recordArr){
        NSLog(@"%@,%@,%@",record.key,record.name,record.other);
    }
    NSLog(@"");
}

-(void)saveCurrentRecord{
    BOOL canSave = YES;
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    Record *record = [Record MR_createEntityInContext:defaultContext];
    MainViewController *viewController = (MainViewController*)self.viewModel.viewController;
    TopContentViewController *topContentView = viewController.topContentView;
    CurrentSelectDate *selectDate = self.viewModel.selectedDate;
    
    //名字
    if(topContentView.firstTextField.stringValue.length > 0){
        record.name = topContentView.firstTextField.stringValue;
    }
    else{
        canSave = NO;
    }
    
    //索引
    if(topContentView.secondTextField.stringValue.length > 0){
        record.key = topContentView.secondTextField.stringValue;
    }
    else{
        canSave = NO;
    }
    
    //笔记
    if(topContentView.thirdTextField.stringValue.length > 0){
        record.other = topContentView.thirdTextField.stringValue;
    }
    
    //新历年
    if(selectDate.gregorianYear){
        record.gregorianYear = selectDate.gregorianYear.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //新历月
    if(selectDate.gregorianMonth){
        record.gregorianMonth = selectDate.gregorianMonth.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //新历日
    if(selectDate.gregorianDay){
        record.gregorianDay = selectDate.gregorianDay.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //新历时
    if(selectDate.gregorianHour){
        record.gregorianHour = selectDate.gregorianHour.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //干支年
    if(selectDate.ganZhiYear){
        record.ganZhiYear = selectDate.ganZhiYear;
    }
    else{
        canSave = NO;
    }
    
    //干支月
    if(selectDate.ganZhiMonth){
        record.ganZhiMonth = selectDate.ganZhiMonth;
    }
    else{
        canSave = NO;
    }
    
    //干支日
    if(selectDate.ganZhiDay){
        record.ganZhiDay = selectDate.ganZhiDay;
    }
    else{
        canSave = NO;
    }
    
    //干支时
    if(selectDate.ganZhiHour){
        record.ganZhiHour = selectDate.ganZhiHour;
    }
    else{
        canSave = NO;
    }
    
    if(canSave){
        // 保存修改到当前上下文中.
        [defaultContext MR_saveToPersistentStoreAndWait];
        
        //提示成功 并清空当前界面
        
        [self fetchAll];
    }
    else{
        //提示
    }
    
}

-(void)clearAllData{
    [self.viewModel.selectedDate clearData];
}

@end
