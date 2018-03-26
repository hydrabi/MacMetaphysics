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
@end

@implementation SaveViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
    [self setUpTableViewDataSource];
    [self setUpTableViewMenu];
}

-(void)bindViewModel{
    @weakify(self)
    [[self.keySearchButton rac_signalForSelector:@selector(mouseDown:)]
     subscribeNext:^(id _){
        @strongify(self)
         
    }];
}

-(void)setUpTableViewDataSource{
    self.tableViewDataSource = [[SaveTableViewDataSource alloc] initWithViewModel:self.viewModel
                                                                   viewController:self];
}

#pragma mark - Menu
-(void)setUpTableViewMenu{
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Menu"];
    menu.delegate = self;
    NSMenuItem *item1 = [[NSMenuItem alloc] initWithTitle:@"删除"
                                                   action:@selector(deleteItemClick) keyEquivalent:@""];
    [menu addItem:item1];
    self.deleteItem = item1;
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

#pragma mark - NSMenuDelegate

- (void)menuNeedsUpdate:(NSMenu*)menu{
    
    //没选中的话不出现删除的菜单
    if(self.recordTableView.numberOfSelectedRows == 0){
        if(menu.itemArray.count > 0){
            [menu removeItem:self.deleteItem];
        }
    }
    else{
        if(menu.itemArray.count == 0){
            [menu addItem:self.deleteItem];
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
            return 1;
        }
        
    }
    return 0;
}

@end
