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
        _viewModel      = viewModel;
        _viewController = viewController;
        _tableView = viewController.recordTableView;
        
        [self setUpTableView];
    }
    return self;
}

-(void)setUpTableView{
    [self tableViewColumnConfig];
}


-(void)tableViewColumnConfig{
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:saveTableViewKeyCloumnIdentifier];
    
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 30.0f;
}

//- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:<#(nonnull NSUserInterfaceItemIdentifier)#> owner:<#(nullable id)#>]
//}

@end
