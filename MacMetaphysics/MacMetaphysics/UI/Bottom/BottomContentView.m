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
#import "BottomCollectionViewDataSource.h"

static NSString *myCellReuseIdentifier = @"myCellReuseIdentifier";
static NSString *columnIdentifier = @"columnIdentifier";

@interface BottomContentView ()
@property (nonatomic,strong)NSScrollView *scrollView;

@property (nonatomic,strong)NSView *testView;
@property (nonatomic,strong)NSClipView *scrollViewContentView;


@property (nonatomic,strong)NSCollectionView *collectionView;
@property (nonatomic,strong)BottomCollectionViewDataSource *collectionViewDataSource;
@end

@implementation BottomContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionViewConfig];
    [self bindViewModel];
}

-(void)viewDidAppear{
    [super viewDidAppear];
    [self.collectionView reloadData];
}

-(void)collectionViewConfig{
    self.collectionView = [[NSCollectionView alloc] initWithFrame:NSMakeRect(0, 0, tableViewCount*tableViewWidth+(tableViewCount-1)*tableViewOffset, scrollViewHeight)];
    
    self.scrollView = [[NSScrollView alloc] init];
    [self.scrollView setBorderType:NSNoBorder];
    [self.scrollView setHasHorizontalScroller:YES];
    [self.scrollView setHasVerticalScroller:YES];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.contentView.documentView = self.collectionView;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    
    [self.scrollView setNeedsDisplay:YES];
    [self.scrollView setNeedsLayout:YES];
    [self.scrollView layoutSubtreeIfNeeded];
    [self.scrollView updateConstraints];
    
    [self.collectionView setNeedsDisplay:YES];
    [self.collectionView setNeedsLayout:YES];
    [self.collectionView layoutSubtreeIfNeeded];
    [self.collectionView updateConstraints];
    
    self.collectionViewDataSource = [[BottomCollectionViewDataSource alloc] initWithCollectionView:self.collectionView];
}

-(void)bindViewModel{
    @weakify(self)
    [[[MainViewModel sharedInstance].reloadBottomTablesSig
      deliverOnMainThread]
     subscribeNext:^(id _){
         @strongify(self)
         [self.collectionView reloadData];
     }];
    
    RACSignal *lToSSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(lunarToSolar)];
    RACSignal *sToLSignal       = [[MainViewModel sharedInstance] rac_signalForSelector:@selector(solarToLunar)];
    //乾坤变化信号
    RACSignal *quankunSignal    = [RACObserve([MainViewModel sharedInstance].middleData, universeType) distinctUntilChanged];
    
    [[lToSSignal
      merge:sToLSignal]
     subscribeNext:^(id _){
         @strongify(self)
         [self.collectionView reloadData];
     }];
    
    [quankunSignal subscribeNext:^(id _){
        [[MainViewModel sharedInstance].bottomData resetData];
        [self.collectionView reloadData];
    }];
}

@end
