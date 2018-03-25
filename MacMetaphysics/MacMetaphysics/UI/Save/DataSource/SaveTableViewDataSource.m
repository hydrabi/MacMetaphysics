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

@interface SaveTableViewDataSource()
@property (weak, nonatomic)SaveViewModel * viewModel;
@property (weak, nonatomic)SaveViewController * viewController;
@property (weak, nonatomic)NSTableView * tableView;
@property (weak, nonatomic)NSArray *recordArr;
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
        [self.tableView addTableColumn:column];
    }
    
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
    
    //姓名
    if([tableColumn.identifier isEqualToString:saveTableViewKeyCloumnIdentifier]){
        return record.name;
    }
    //编号
    else if([tableColumn.identifier isEqualToString:saveTableViewKeyCloumnIdentifier]){
        return record.key;
    }
    //公历
    else if([tableColumn.identifier isEqualToString:saveTableViewGregorianCloumnIdentifier]){
        
    }
    //农历
    else if([tableColumn.identifier isEqualToString:saveTableViewLunarCloumnIdentifier]){
        
    }
    //干支
    else if([tableColumn.identifier isEqualToString:saveTableViewGanZhiCloumnIdentifier]){
        
    }
    //笔记
    else if([tableColumn.identifier isEqualToString:saveTableViewNoteCloumnIdentifier]){
        
    }
    //日期
    else if([tableColumn.identifier isEqualToString:saveTableViewDateCloumnIdentifier]){
        
    }
    
    return @"";
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.recordArr.count;
}

@end
