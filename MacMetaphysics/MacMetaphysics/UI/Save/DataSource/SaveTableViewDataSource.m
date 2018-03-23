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
    
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewKeyCloumnIdentifier];
    id cell1 = [column1 dataCell];
    [cell1 setFont:[NSFont systemFontOfSize:titleFontSize_20]];
    column1.title = saveTableViewKeyHeaderTitle;
    [self.tableView addTableColumn:column1];
    
    NSTableColumn *column2 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewNameCloumnIdentifier];
    column2.title = saveTableViewNameHeaderTitle;
    [self.tableView addTableColumn:column2];
    
    NSTableColumn *column3 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewGregorianCloumnIdentifier];
    column3.title = saveTableViewGregorianHeaderTitle;
    [self.tableView addTableColumn:column3];
    
    NSTableColumn *column4 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewLunarCloumnIdentifier];
    column4.title = saveTableViewLunarHeaderTitle;
    [self.tableView addTableColumn:column4];
    
    NSTableColumn *column5 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewGanZhiCloumnIdentifier];
    column5.title = saveTableViewGanZhiHeaderTitle;
    [self.tableView addTableColumn:column5];
    
    NSTableColumn *column6 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewNoteCloumnIdentifier];
    column6.title = saveTableViewNoteHeaderTitle;
    [self.tableView addTableColumn:column6];
    
    NSTableColumn *column7 = [[NSTableColumn alloc] initWithIdentifier:saveTableViewDateCloumnIdentifier];
    column7.title = saveTableViewDateHeaderTitle;
    [self.tableView addTableColumn:column7];
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 30.0f;
}

//- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:<#(nonnull NSUserInterfaceItemIdentifier)#> owner:<#(nullable id)#>]
//}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    return @"content";
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return 6;
}

@end
