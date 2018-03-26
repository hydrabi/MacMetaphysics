//
//  SaveTableViewDataSource.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/22.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SaveTableViewDataSource.h"
#import "SaveViewModel.h"
#import "SaveViewController.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "Record+CoreDataProperties.h"
#import <DateTools/DateTools.h>
#import "NSDate+Addition.h"
#import "NSString+Addition.h"

@interface SaveTableViewDataSource()
@property (weak, nonatomic)SaveViewModel * viewModel;
@property (weak, nonatomic)SaveViewController * viewController;
@property (weak, nonatomic)NSTableView * tableView;
@end

@implementation SaveTableViewDataSource

-(instancetype)initWithViewModel:(SaveViewModel*)viewModel viewController:(SaveViewController*)viewController{
    self = [super init];
    if(self){
        _viewModel            = viewModel;
        _viewController       = viewController;
        _tableView            = viewController.recordTableView;
        _tableView.delegate   = self;
        _tableView.dataSource = self;

        [self setUpTableView];
        [self reloadRecord];
    }
    return self;
}

-(void)setUpTableView{
    [self tableViewColumnConfig];
}


-(void)tableViewColumnConfig{
    //将原有的column清空掉
    for(NSTableColumn *column in self.tableView.tableColumns){
        [self.tableView removeTableColumn:column];
    }
    
    NSArray *identifierArr = @[saveTableViewKeyCloumnIdentifier,
                               saveTableViewNameCloumnIdentifier,
                               saveTableViewGregorianCloumnIdentifier,
                               saveTableViewLunarCloumnIdentifier,
                               saveTableViewGanZhiCloumnIdentifier,
                               saveTableViewNoteCloumnIdentifier,
                               saveTableViewDateCloumnIdentifier];
    
    NSArray *nameArr = @[saveTableViewKeyHeaderTitle,
                         saveTableViewNameHeaderTitle,
                         saveTableViewGregorianHeaderTitle,
                         saveTableViewLunarHeaderTitle,
                         saveTableViewGanZhiHeaderTitle,
                         saveTableViewNoteHeaderTitle,
                         saveTableViewDateHeaderTitle];
    
    for(NSInteger i = 0;i<identifierArr.count;i++){
        NSString *identifier = identifierArr[i];
        NSString *title = nameArr[i];
        
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:identifier];
        id cell = [column dataCell];
        [cell setFont:[NSFont systemFontOfSize:titleFontSize_20]];
        column.title = title;
        column.minWidth = [self getMinWidthWithIdentifier:identifier];
        column.editable = NO;
        [self.tableView addTableColumn:column];
    }
    
}

-(CGFloat)getMinWidthWithIdentifier:(NSString*)identifier{
    CGFloat minWidth = 100.0f;
    
    //编号
    if([identifier isEqualToString:saveTableViewKeyCloumnIdentifier]){
        minWidth = 130.0f;
    }
    //姓名
    else if([identifier isEqualToString:saveTableViewNameCloumnIdentifier]){
        minWidth = 90.0f;
    }
    //公历
    else if([identifier isEqualToString:saveTableViewGregorianCloumnIdentifier]){
        minWidth = 180.0f;
        
    }
    //农历
    else if([identifier isEqualToString:saveTableViewLunarCloumnIdentifier]){
        minWidth = 220.0f;
    }
    //干支
    else if([identifier isEqualToString:saveTableViewGanZhiCloumnIdentifier]){
        minWidth = 280.0f;
    }
    //笔记
    else if([identifier isEqualToString:saveTableViewNoteCloumnIdentifier]){
        minWidth = 400.0f;
    }
    //日期
    else if([identifier isEqualToString:saveTableViewDateCloumnIdentifier]){
        minWidth = 120.0f;
    }
    
    return minWidth;
}

-(void)reloadRecord{
    self.recordArr = [[MainViewModel sharedInstance].recordEventHandler fetchAll];
    [self.tableView reloadData];
}

#pragma mark - NSTableViewDelegate,NSTableViewDataSource

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 30.0f;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    Record *record = self.recordArr[row];
    
    //编号
    if([tableColumn.identifier isEqualToString:saveTableViewKeyCloumnIdentifier]){
        return record.key;
    }
    //姓名
    else if([tableColumn.identifier isEqualToString:saveTableViewNameCloumnIdentifier]){
        return record.name;
    }
    //公历
    else if([tableColumn.identifier isEqualToString:saveTableViewGregorianCloumnIdentifier]){
        NSDate *gDate = [NSDate dateWithYear:record.gregorianYear
                       month:record.gregorianMonth
                         day:record.gregorianDay
                        hour:record.gregorianHour
                      minute:0
                      second:0];
        return [gDate toStringWithFormat:@"yyyy-MM-dd HH:mm"];
        
    }
    //农历
    else if([tableColumn.identifier isEqualToString:saveTableViewLunarCloumnIdentifier]){
        NSString *shiChen = [NSString shiChenWithTime:record.lunarHour];
        NSString *result = [NSString stringWithFormat:@"%d年 %d月 %d日 %@时",
                            record.lunarYear,
                            record.lunarMonth,
                            record.lunarDay,
                            shiChen];
        return result;
    }
    //干支
    else if([tableColumn.identifier isEqualToString:saveTableViewGanZhiCloumnIdentifier]){
        NSString *result = [NSString stringWithFormat:@"%@年 %@月 %@日 %@时",
                            record.ganZhiYear,
                            record.ganZhiMonth,
                            record.ganZhiDay,
                            record.ganZhiHour];
        return result;
    }
    //笔记
    else if([tableColumn.identifier isEqualToString:saveTableViewNoteCloumnIdentifier]){
        return record.other;
    }
    //日期
    else if([tableColumn.identifier isEqualToString:saveTableViewDateCloumnIdentifier]){
        return [record.date toStringWithFormat:@"yyyy-MM-dd"];
    }
    
    return @"";
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.recordArr.count;
}

@end
