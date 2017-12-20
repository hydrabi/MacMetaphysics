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

@interface BottomContentView ()
@property (nonatomic,strong)NSScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *tableViewsArr;

@property (nonatomic,strong)NSView *testView;
@end

@implementation BottomContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
    [self makeConstraints];
    [self bindViewModel];
}

-(void)UIConfig{
    
    NSView *documentView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, tableViewCount*tableViewWidth+(tableViewCount-1)*tableViewOffset, scrollViewHeight)];
    documentView.translatesAutoresizingMaskIntoConstraints = NO;
//    [documentView setBackgroundColor:[NSColor redColor]];
    self.tableViewsArr = @[].mutableCopy;
    self.scrollView = [[NSScrollView alloc] init];
    [self.scrollView setBorderType:NSNoBorder];
    [self.scrollView setHasHorizontalScroller:YES];
    [self.scrollView setHasVerticalScroller:YES];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.scrollView.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    [self.view addSubview:self.scrollView];
    
    for(NSInteger i = 0;i<tableViewCount;i++){
        NSCollectionView *collectionView = [[NSCollectionView alloc] init];
        collectionView.myTag = i;
        [collectionView setBackgroundColor:[NSColor yellowColor]];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [documentView addSubview:collectionView];
        [self.tableViewsArr addObject:collectionView];
    }
    
    self.scrollView.documentView = documentView;
    self.dataSorce = [[BottomTableViewDataSource alloc] initWithCollectionViews:self.tableViewsArr];
    
//    self.testView = documentView;
//    [self.view addSubview:documentView];
}

-(void)makeConstraints{
    @weakify(self)
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

@end
