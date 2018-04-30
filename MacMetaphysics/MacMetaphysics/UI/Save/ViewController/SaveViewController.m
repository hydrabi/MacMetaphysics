//
//  SaveViewController.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/17.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "SaveViewController.h"
#import "Record+CoreDataProperties.h"
#import "MainViewModel.h"

@interface SaveViewController ()<NSMenuDelegate>
@property (strong, nonatomic)NSMenuItem * deleteItem;
@property (strong, nonatomic)NSMenuItem * sortToTopItem;
@end

@implementation SaveViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
    [self setUpTableViewDataSource];
    [self setUpTableViewMenu];
    
    //绑定双击事件
    [self.recordTableView setDoubleAction:@selector(doubleClick:)];
}

-(void)bindViewModel{
    @weakify(self)
    [[self.keySearchButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
        @strongify(self)
         [self keySearchButtonClick];
    }];
}

-(void)setUpTableViewDataSource{
    self.tableViewDataSource = [[SaveTableViewDataSource alloc] initWithViewModel:self.viewModel
                                                                   viewController:self];
}

#pragma mark - 方法点击
-(void)keySearchButtonClick{
    NSString *keySearchString = self.keyInputTextView.stringValue;
    //有输入搜索条件 查找搜索条件对应的记录
    if(keySearchString.length > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key CONTAINS[cd] %@",keySearchString];
        [self.tableViewDataSource reloadRecordWithPredicate:predicate];
    }
    //无输入，查找所有记录
    else{
        [self.tableViewDataSource reloadRecord];
    }
}

#pragma mark - Menu
-(void)setUpTableViewMenu{
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Menu"];
    menu.delegate = self;
    
    NSMenuItem *item1 = [[NSMenuItem alloc] initWithTitle:@"删除"
                                                   action:@selector(deleteItemClick) keyEquivalent:@""];
    [menu addItem:item1];
    self.deleteItem = item1;
    
    NSMenuItem *item2 = [[NSMenuItem alloc] initWithTitle:@"相同四柱置顶"
                                                   action:@selector(sortSiZhuToTop) keyEquivalent:@""];
    [menu addItem:item2];
    self.sortToTopItem = item2;
    
    [self.recordTableView setMenu:menu];
}

//点击删除
-(void)deleteItemClick{
    NSIndexSet *indexSet = self.recordTableView.selectedRowIndexes;
    NSMutableArray *tempArr = @[].mutableCopy;
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index,BOOL *stop){
        if(self.tableViewDataSource.recordArr.count>index){
            Record *record = self.tableViewDataSource.recordArr[index];
            [tempArr addObject:record];
        }
    }];
    
    if(tempArr.count>0){
        [[MainViewModel sharedInstance].recordEventHandler deleteRecords:tempArr];
        [self.tableViewDataSource reloadRecord];
    }
}

//置顶排序
-(void)sortSiZhuToTop{
    
    NSIndexSet *indexSet = self.recordTableView.selectedRowIndexes;
    NSMutableArray *tempArr = @[].mutableCopy;
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index,BOOL *stop){
        if(self.tableViewDataSource.recordArr.count>index){
            Record *record = self.tableViewDataSource.recordArr[index];
            [tempArr addObject:record];
        }
    }];
    
    if(tempArr.count>0){
        Record *record = tempArr[0];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ganZhiYear == %@ AND ganZhiMonth == %@ AND ganZhiDay == %@ AND ganZhiHour == %@",
                                  record.ganZhiYear,
                                  record.ganZhiMonth,
                                  record.ganZhiDay,
                                  record.ganZhiHour];
        
        NSArray *timesArr = [self.tableViewDataSource.recordArr filteredArrayUsingPredicate:predicate];
        
        [self.tableViewDataSource.recordArr removeObjectsInArray:timesArr];
        [self.tableViewDataSource.recordArr insertObjects:timesArr
                                                atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, timesArr.count)]];
        [self.tableViewDataSource reloadAfterSortToTop];
    }
}

- (void)doubleClick:(id)sender {
    [self.tableViewDataSource doubleClickAction];
    [[NSApplication sharedApplication] stopModal];
}

#pragma mark - NSMenuDelegate

- (void)menuNeedsUpdate:(NSMenu*)menu{
    
    //没选中的话不出现删除的菜单
    if(self.recordTableView.numberOfSelectedRows == 0){
        if(menu.itemArray.count > 0){
            [menu removeItem:self.deleteItem];
        }
        
        if(menu.itemArray.count > 0){
            [menu removeItem:self.sortToTopItem];
        }
    }
    else{
        if(menu.itemArray.count == 0){
            [menu addItem:self.deleteItem];
        }
        
        if(menu.itemArray.count == 1){
            [menu addItem:self.sortToTopItem];
        }
    }
}

-(NSInteger)numberOfItemsInMenu:(NSMenu *)menu{
    NSInteger row = [self.recordTableView clickedRow];
    if(row < 0){
        return 0;
    }
    else{
        //没选中的话不出现删除的菜单
        if(self.recordTableView.numberOfSelectedRows > 0){
            return 2;
        }
        
    }
    return 0;
}

@end
