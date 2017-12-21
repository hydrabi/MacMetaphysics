//
//  BottomNSTableViewDataSource.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/21.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomNSTableViewDataSource.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "BottomLocation.h"
#import "NSString+Addition.h"
#import "NSView+Addition.h"
#import "BottomTableCellView.h"
#import "CustomBottomTableHeader.h"
static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *columnIdentifier = @"columnIdentifier";

@interface BottomNSTableViewDataSource()
@property (nonatomic,weak)NSMutableArray<NSTableView*> *tableViews;
@end

@implementation BottomNSTableViewDataSource

-(instancetype)initWithTableViews:(NSMutableArray*)tableViewArr{
    self = [super init];
    if(self){
        self.tableViews = tableViewArr;
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    for(NSInteger i = 0;i<self.tableViews.count;i++){
        NSTableView *tableView = self.tableViews[i];
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:columnIdentifier];
        column.width = tableViewWidth;
        column.hidden = NO;
        [tableView addTableColumn:column];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        if(tableView.myTag == 0){
            CustomBottomTableHeader *header = [CustomBottomTableHeader instanceBasicNibView];
            header.frame = NSMakeRect(0, 0, tableViewWidth, tableViewHeaderHeight);
            tableView.headerView = header;
        }
        else{
            CustomBottomTableHeader *header = [CustomBottomTableHeader instanceBasicNibView];
            header.frame = NSMakeRect(0, 0, tableViewWidth, tableViewHeaderHeight);
            header.tableViewTag = tableView.myTag;
            [header reloadData];
            tableView.headerView = header;
        }
        
        [tableView reloadData];
    }
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return rowPerSection*tableViewSection;
}

//-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
//    return [NSString stringWithFormat:@"%d",row];
//}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    BottomTableCellView *cell = [tableView makeViewWithIdentifier:myCellReuseIdentifier owner:self];
    if(!cell){
        cell = [BottomTableCellView instanceBasicNibView];
        cell.frame = NSMakeRect(0, 0, tableViewWidth, tableViewCellHeight);
    }
    
    cell.yearLabel.text = [NSString stringWithFormat:@"%d",row];
    cell.liuNianLabel.text = [NSString stringWithFormat:@"%d",row];
    
    //    MainViewModel *main = [MainViewModel sharedInstance];
    //    if(main.hadHiddenBottomTableView){
    //        if(collectionView.myTag >= main.hiddenBottomTableViewTag){
    //            [cell hideContent];
    //        }
    //        else{
    //            [cell showContent];
    //        }
    //    }
    //    //展示
    //    else{
    //        [cell showContent];
    //    }
    //
    //    NSNumber *key = [BottomLocation createKeyNumberWithTag:collectionView.myTag
    //                                                 indexPath:indexPath];
    //    if([main.liuNianData.bottomLocationDic objectForKey:key]){
    //        [cell selectCell:YES];
    //    }
    //    else{
    //        [cell selectCell:NO];
    //    }
    //
    //    [self fillContentWithCell:cell
    //                    tableView:collectionView
    //                    indexPath:indexPath];
    
    return cell;
}

-(NSTableRowView*)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    NSTableRowView *rowView = [[NSTableRowView alloc] init];
    return rowView;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return tableViewCellHeight;
}


@end
