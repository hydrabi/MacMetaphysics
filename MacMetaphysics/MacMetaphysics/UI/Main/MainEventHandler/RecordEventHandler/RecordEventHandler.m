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
#import "AppDelegate.h"
#import "FNHUD.h"
#import "TopContentViewController+Record.h"

@implementation RecordEventHandler

#pragma mark - 增加记录

-(void)saveCurrentRecord{
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    Record *record = nil;
    
    //判断当前的key对应是否已经存在记录
    NSArray *currentKeyRecord = [self fetchCurrentKeyRecord];
    //有 替换内容
    if(currentKeyRecord.count>0){
        record = currentKeyRecord[0];
    }
    //没有 新增record
    else{
        record = [Record MR_createEntityInContext:defaultContext];
    }
    
    [self saveWithRecord:record];
}

-(void)saveWithRecord:(Record*)record{
    
    BOOL canSave = YES;
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    MainViewController *viewController = (MainViewController*)self.viewModel.viewController;
    TopContentViewController *topContentView = viewController.topContentView;
    CurrentSelectDate *selectDate = self.viewModel.selectedDate;
    
    //名字
    if(topContentView.firstTextField.stringValue.length > 0){
        record.name = topContentView.firstTextField.stringValue;
    }
    
    //索引
    if(topContentView.thirdTextField.stringValue.length > 0){
        record.key = topContentView.thirdTextField.stringValue;
    }
    else{
        canSave = NO;
    }
    
    //笔记
    if(topContentView.secondTextField.stringValue.length > 0){
        record.other = topContentView.secondTextField.stringValue;
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
    
    //农历年
    if(selectDate.lunarYear){
        record.lunarYear = selectDate.lunarYear.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //农历月
    if(selectDate.lunarMonth){
        record.lunarMonth = selectDate.lunarMonth.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //农历日
    if(selectDate.lunarDay){
        record.lunarDay = selectDate.lunarDay.integerValue;
    }
    else{
        canSave = NO;
    }
    
    //农历时
    if(selectDate.lunarHour){
        record.lunarHour = selectDate.lunarHour.integerValue;
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
    
    //保存左边菜单textView字典
    if(self.viewModel.leftMenuBottomTextData.bottomTextRecordDic){
        record.leftMenuTextDic = self.viewModel.leftMenuBottomTextData.bottomTextRecordDic;
    }
    
    record.universeType = self.viewModel.middleData.universeType;
    
    if(canSave){
        
        record.date = [NSDate date];
        
        // 保存修改到当前上下文中.
        [defaultContext MR_saveToPersistentStoreAndWait];
        
        //清空数据
        [self clearAllData];
        //提示成功 通知清空当前界面
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationKey_clearAllData
                                                            object:nil];
        [FNHUD showSuccess:@"保存成功" inView:self.viewModel.viewController.view];
    }
    else{
        
        //删除
        [record MR_deleteEntity];
        //提示
        [FNHUD showError:@"有属性未填写，无法保存" inView:self.viewModel.viewController.view];
    }
}

//清空数据
-(void)clearAllData{
    [self.viewModel.selectedDate clearData];
    [self.viewModel.middleData clearData];
//    [self.viewModel.shuangZaoData clearData];
    [self.viewModel.riZhuData clearData];
    [self.viewModel.bottomData clearData];
    [self.viewModel.fifteenYunData clearData];
    [self.viewModel.liuNianData clearData];
    [self.viewModel.leftMenuBottomTextData clearData];
    
    //清空底部，左边的textView
    self.viewModel.currentBottomSectionMenuType = LeftSideMenuTypeEmpty;
    [(RACSubject*)self.viewModel.leftMenuClickTextViewOperationSig sendNext:nil];
    [(RACSubject*)self.viewModel.currentBottomTextViewOperationSig sendNext:nil];
}

#pragma mark - 删除

//删除所有记录
-(void)deleteAllRecord{
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    [Record MR_truncateAllInContext:defaultContext];
    [self fetchAll];
}

//删除指定的记录
-(void)deleteRecords:(NSArray<Record*>*)recordArr{
    for(Record *record in recordArr){
        [record MR_deleteEntity];
    }
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    // 保存修改到当前上下文中.
    [defaultContext MR_saveToPersistentStoreAndWait];
}

#pragma mark - 查找

-(NSArray*)fetchAll{
    NSArray *recordArr = [Record MR_findAll];
    return recordArr;
}

-(NSArray*)fetchWithPredicate:(NSPredicate*)predicate{
    NSArray *recordArr = [Record MR_findAllWithPredicate:predicate];
    return recordArr;
}

//判断当前的key数据库是否已经有记录
-(NSArray*)fetchCurrentKeyRecord{
    
    MainViewController *viewController = (MainViewController*)self.viewModel.viewController;
    TopContentViewController *topContentView = viewController.topContentView;
    CurrentSelectDate *selectDate = self.viewModel.selectedDate;
    
    NSString *key = topContentView.thirdTextField.stringValue;
    NSString *upperKey = [key uppercaseString];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@",upperKey];
    
    NSArray *recordArr = [Record MR_findAllWithPredicate:predicate];
    return recordArr;
}
#pragma mark - 排序

-(NSArray*)sortByDateWithRecordArr:(NSArray<Record*>*)recordArr{
    if(recordArr.count>0){
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
        NSArray *sortArr = [recordArr sortedArrayUsingDescriptors:@[descriptor]];
        return sortArr;
    }
    return recordArr;
}

#pragma mark - 读取记录
-(void)readRecord:(Record*)record{
    [self.viewModel.selectedDate readRecord:record];
    [self.viewModel.leftMenuBottomTextData readRecord:record];
    
    MainViewController *viewController = (MainViewController*)self.viewModel.viewController;
    
    //上方contentView
    TopContentViewController *topContentView = viewController.topContentView;
    [topContentView resetGregorianValue];
    [topContentView shouldTransformTolunar];
    [topContentView fillTextViewWithRecord:record];
    
    //中间contentView
    MiddleContentView *middleContentView = viewController.middleContentView;
    [middleContentView setGenderButtonWithType:record.universeType];
    
    
    //清空底部，左边的textView
    self.viewModel.currentBottomSectionMenuType = LeftSideMenuTypeEmpty;
    [(RACSubject*)self.viewModel.leftMenuClickTextViewOperationSig sendNext:nil];
    [(RACSubject*)self.viewModel.currentBottomTextViewOperationSig sendNext:nil];
}

@end
