//
//  BottomContentView.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/14.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "BottomContentView.h"
#import "UIConstantParameter.h"
#import "MainViewModel.h"
#import "NSView+Addition.h"
#import "GALFlippedClipView.h"
#import "BottomNSTableViewDataSource.h"
#import "BottomTableCellView.h"
#import "BottomCollectionViewDataSource.h"

static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *columnIdentifier = @"columnIdentifier";

@interface BottomContentView ()
@property (nonatomic,strong)NSScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *tableViewsArr;

@property (nonatomic,strong)NSView *testView;
@property (nonatomic,strong)NSClipView *scrollViewContentView;

@property (nonatomic,strong)BottomNSTableViewDataSource *otherDataSource;
@property (nonatomic,strong)NSTableView *tableView;

@property (nonatomic,strong)NSCollectionView *collectionView;
@property (nonatomic,strong)BottomCollectionViewDataSource *collectionViewDataSource;
@end

@implementation BottomContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self UIConfig];
//    [self makeConstraints];
//    [self bindViewModel];
    
//    [self tableViewConfig];
    
    [self collectionViewConfig];
}

-(void)tableViewConfig{
    self.tableView = [[NSTableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.scrollView = [[NSScrollView alloc] init];
    [self.scrollView setBorderType:NSNoBorder];
    [self.scrollView setHasHorizontalScroller:YES];
    [self.scrollView setHasVerticalScroller:YES];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.contentView.documentView = self.tableView;
    [self.view addSubview:self.scrollView];
    
    for(NSInteger i = 0;i<tableViewCount;i++){
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:[NSString stringWithFormat:@"%@%ld",columnIdentifier,(long)i]];
        column.width = tableViewWidth;
        column.hidden = NO;
        [self.tableView addTableColumn:column];
    }
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
}

-(void)collectionViewConfig{
    self.collectionView = [[NSCollectionView alloc] initWithFrame:NSMakeRect(0, 0, tableViewCount*tableViewWidth+(tableViewCount-1)*tableViewOffset, scrollViewHeight)];
//    [self.view addSubview:self.collectionView];
    
    self.scrollView = [[NSScrollView alloc] init];
    [self.scrollView setBorderType:NSNoBorder];
    [self.scrollView setHasHorizontalScroller:YES];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.contentView.documentView = self.collectionView;
    [self.view addSubview:self.scrollView];
    
    self.collectionViewDataSource = [[BottomCollectionViewDataSource alloc] initWithCollectionView:self.collectionView];
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
}

-(void)UIConfig{
    
    NSView *documentView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, tableViewCount*tableViewWidth+(tableViewCount-1)*tableViewOffset, scrollViewHeight)];
    documentView.translatesAutoresizingMaskIntoConstraints = NO;
//    [documentView setBackgroundColor:[NSColor redColor]];
    self.testView = documentView;
    
    self.scrollViewContentView = [[GALFlippedClipView alloc]init];
    self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.tableViewsArr = @[].mutableCopy;
    self.scrollView = [[NSScrollView alloc] init];
    [self.scrollView setBorderType:NSNoBorder];
    [self.scrollView setHasHorizontalScroller:YES];
    [self.scrollView setContentView:self.scrollViewContentView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    for(NSInteger i = 0;i<tableViewCount;i++){
        NSCollectionView *collectionView = [[NSCollectionView alloc] init];
        collectionView.myTag = i;
        [collectionView setBackgroundColor:[NSColor yellowColor]];
        [documentView addSubview:collectionView];
        [self.tableViewsArr addObject:collectionView];
    }
    
//    for(NSInteger i = 0;i<tableViewCount;i++){
//        NSTableView *tableView = [[NSTableView alloc] initWithFrame:NSZeroRect];
//        tableView.myTag = i;
//        [documentView addSubview:tableView];
//        [self.tableViewsArr addObject:tableView];
//    }
    
    self.scrollView.contentView.documentView = documentView;
    self.dataSorce = [[BottomTableViewDataSource alloc] initWithCollectionViews:self.tableViewsArr];
    
//    self.otherDataSource = [[BottomNSTableViewDataSource alloc] initWithTableViews:self.tableViewsArr];
    
//    self.testView = documentView;
//    [self.view addSubview:documentView];
}

-(void)makeConstraints{
    @weakify(self)
//    [self.scrollViewContentView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.edges.equalTo(self.scrollView);
//    }];
//
//    [self.testView makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self)
//        make.leading.left.bottom.equalTo(self.scrollViewContentView);
//        make.height.equalTo(scrollViewHeight);
//    }];
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.view.leading).offset(0);
        make.trailing.equalTo(self.view.trailing).offset(0);
        make.top.equalTo(self.view.top).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
    }];
    
    NSView *lastView = nil;

    for(NSInteger i = 0;i<tableViewCount;i++){
        NSCollectionView *tableView = self.tableViewsArr[i];
        NSView *superView = tableView.superview;
        [tableView makeConstraints:^(MASConstraintMaker *make){
            if(lastView){
                make.leading.equalTo(lastView.trailing).offset(tableViewOffset);
            }
            else{
                make.leading.equalTo(superView).offset(tableViewOffset);
            }

            make.top.equalTo(superView);
            make.bottom.equalTo(superView);
            make.width.equalTo(tableViewWidth);
            make.height.equalTo(scrollViewHeight);
        }];
        lastView = tableView;
    }
    
//    for(NSInteger i = 0;i<tableViewCount;i++){
//        NSTableView *tableView = self.tableViewsArr[i];
//        NSView *superView = tableView.superview;
//        [tableView makeConstraints:^(MASConstraintMaker *make){
//            if(lastView){
//                make.leading.equalTo(lastView.trailing).offset(tableViewOffset);
//            }
//            else{
//                make.leading.equalTo(superView).offset(tableViewOffset);
//            }
//            
//            make.top.equalTo(superView);
//            make.bottom.equalTo(superView);
//            make.width.equalTo(tableViewWidth);
//            make.height.equalTo(scrollViewHeight);
//        }];
//        lastView = tableView;
//    }
    
    
//    CGFloat offset = tableViewFirstVerOffset;
//    for(NSInteger i = 0;i<tableViewCount;i++){
//        NSCollectionView *tableView = self.tableViewsArr[i];
//        tableView.frame = CGRectMake(offset, 0, tableViewWidth, scrollViewHeight);
//        offset += tableViewWidth+tableViewOffset;
//    }

}

-(void)bindViewModel{
    @weakify(self)
    [[[MainViewModel sharedInstance].reloadBottomTablesSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self reloadAllTableView];
     }];
    
    RACSignal *lToSSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(lunarToSolar)];
    RACSignal *sToLSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(solarToLunar)];
    //乾坤变化信号
    RACSignal *quankunSignal    = [RACObserve([MainViewModel sharedInstance].middleData, universeType) distinctUntilChanged];
    
    [[lToSSignal
      merge:sToLSignal]
     subscribeNext:^(id _){
         @strongify(self)
         [self reloadAllTableView];
     }];
    
    [quankunSignal subscribeNext:^(id _){
        [[MainViewModel sharedInstance].bottomData resetData];
        [self reloadAllTableView];
    }];
}

-(void)reloadAllTableView{
    for(NSInteger i = 0;i<self.tableViewsArr.count;i++){
        NSCollectionView *collectionView = self.tableViewsArr[i];
        [collectionView reloadData];
    }
}

#pragma mark - NSTableViewDelegate,NSTableViewDataSource
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
