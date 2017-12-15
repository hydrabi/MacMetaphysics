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
@interface BottomContentView ()
@property (nonatomic,strong)NSScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *tableViewsArr;
@end

@implementation BottomContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
    [self makeConstraints];
    [self bindViewModel];
}

-(void)UIConfig{
    
    self.tableViewsArr = @[].mutableCopy;
    self.scrollView = [[NSScrollView alloc] init];
    self.scrollView.size = NSMakeSize(tableViewCount*tableViewWidth+(tableViewCount-1)*tableViewOffset, scrollViewHeight);
    self.scrollView.scrollEnabled = YES;
    [self addSubview:self.scrollView];
    
    for(NSInteger i = 0;i<tableViewCount;i++){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                              style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        [self.tableViewsArr addObject:tableView];
        [self.scrollView addSubview:tableView];
    }
    self.dataSorce = [[BottomTableViewDataSource alloc] initWithTableViews:self.tableViewsArr];
}

-(void)makeConstraints{
    @weakify(self)
    [self.scrollView makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.leading.equalTo(self.leading).offset(0);
        make.trailing.equalTo(self.trailing).offset(0);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
    
    CGFloat offset = tableViewFirstVerOffset;
    for(NSInteger i = 0;i<tableViewCount;i++){
        UITableView *tableView = self.tableViewsArr[i];
        tableView.frame = CGRectMake(offset, 0, tableViewWidth, scrollViewHeight);
        tableView.delegate = self.dataSorce;
        tableView.dataSource = self.dataSorce;
        offset += tableViewWidth+tableViewOffset;
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
        UITableView *tableView = self.tableViewsArr[i];
        [tableView reloadData];
    }
}

@end
